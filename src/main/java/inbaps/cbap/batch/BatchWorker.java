package inbaps.cbap.batch;

import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Clob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Pattern;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import inbaps.cbap.openapi.CommonOpenApi;
import inbaps.cbap.spider.CommonSpider;

public class BatchWorker extends Thread {
    
	protected Log log = LogFactory.getLog(this.getClass());
	
	Connection conn = null;
    CallableStatement cstmt = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String SQL = "";
    
    Map<String, Object> mParam = new HashMap<String, Object>();
    Map<String, Object> mSqlParam = new LinkedHashMap<String, Object>();
    
    BatchWorker(String name, Connection pConn, Map<String, Object> pParam, Map<String, Object> pSqlParam){	// 생성자에 스레드 이름이 전달인자로 넘어 옴
    	super(name);	// 전달인자로 준 값이 스레드의 이름이 됨
    	conn = pConn;
    	mParam = pParam;
    	mSqlParam = pSqlParam;
    }
    
    // 스레드 객체가 수행해야 하는 작업을 run() 메서드를 오버라이딩하여 이 내부에 기술
    public void run(){
        try{
			// 현재 실행할 배치프로그램 상태를 시작상태로 업데이트 한다. 
			SQL = "{CALL SP_BTCH_RSV_STRT(?,?,?,?)}";
			cstmt = conn.prepareCall(SQL);
			cstmt.clearParameters();
			cstmt.setString(1, String.valueOf(mParam.get("EXE_NUM") ));
			cstmt.setString(2, String.valueOf(mParam.get("USR_ID") ));
			cstmt.setString(3, String.valueOf(mParam.get("BAT_ID") ));
			cstmt.setString(4, mSqlParam.toString());
			cstmt.executeQuery();
			cstmt.close();
			
        	String batId = "";
        	String calPrgm = "";
        	String calFilePath = "";
        	String calType = "";	// 호출유형(JAVA:자바프로그램, PRC:프로시저, EXE:실행파일, SVC:웹서비스)
        	if(mParam.containsKey("BAT_ID")){batId =String.valueOf( mParam.get("BAT_ID"));}
        	if(mParam.containsKey("CAL_PRGM")){calPrgm = String.valueOf(mParam.get("CAL_PRGM"));}
        	if(mParam.containsKey("CAL_FILE_PATH")){calFilePath = String.valueOf(mParam.get("CAL_FILE_PATH"));}
        	if(mParam.containsKey("CAL_TYPE")){calType = String.valueOf(mParam.get("CAL_TYPE"));}
        	
        	if("JAVA".equals(calType)){
        		if("inbaps.cbap.batch.BatchWorker.runApi".equals(calPrgm)){
        			runApi();
        		}else if("inbaps.cbap.batch.BatchWorker.runCrawling".equals(calPrgm)){
        			runCrawling();
        		}
        	}else if("PRC".equals(calType)){
        		//
        		runProcedure(calPrgm);
        	}else if("EXE".equals(calType)){
        		//
        		runExecuteFile(calPrgm, calFilePath);
        	}else if("SVC".equals(calType)){
        		//
        	}
        	
        	// 10초 
    		sleep(10000);
        	
        	// 현재 실행한 배치프로그램 상태를  종료상태로 업데이트하고, 다음순서의 배치프로그램을 예약등록한다.
    		SQL = "{CALL SP_BTCH_RSV_NEXT}";
			cstmt = conn.prepareCall(SQL);
			cstmt.clearParameters();
			cstmt.executeQuery();
			cstmt.close();
			
        }catch(ThreadDeath ouch){
        	System.out.println("I (" + getName() + ") is being killed.");
        	throw(ouch);
        }catch(Exception e){
        	e.printStackTrace();
        }finally{
        	//
        }
    }
    
    private void runProcedure(String calPrgm) throws Exception{
    	String SQL = "";
    	String calProParam = "";
    	int iProParamCnt = 0;    	

    	SQL = "{CALL " + calPrgm;
    	iProParamCnt = mSqlParam.size();
    	for(int i=1; i<=iProParamCnt; i++){
    		calProParam += (i==1?"?":",?");
    	}
		if(iProParamCnt > 0){
			SQL += "(" + calProParam + ")";
		}		
		SQL += "}";
		
		//System.out.println(SQL);
		
    	cstmt = conn.prepareCall(SQL);
    	cstmt.clearParameters();    	
    	int iProParam = 0;
		Set<String> set =mSqlParam.keySet();
		Iterator<String> iter = set.iterator();
		while(iter.hasNext()){
			iProParam++;
			String key = ((String)iter.next());
			String value = String.valueOf(mSqlParam.get(key));
			cstmt.setString(iProParam, value);	
			//System.out.println(value);
		}
    	cstmt.executeQuery();
    	cstmt.close();
    }
    
    private void runExecuteFile(String calPrgm, String calFilePath){
		//
    	String calProParam = "";
    	
		String executeFile = calFilePath + calPrgm;
		
		Set<String> set =mSqlParam.keySet();
		Iterator<String> iter = set.iterator();
		while(iter.hasNext()){
			String key = ((String)iter.next());
			String value = String.valueOf(mSqlParam.get(key));
			calProParam += " " + value;
		}
		executeFile += calProParam;
		//System.out.println("executeFullPath: " + executeFile);
		
		Runtime rt = Runtime.getRuntime();
		Process p;
		  
		try {
			p = rt.exec(executeFile);
			p.waitFor();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
    
    private Map<String,Object> runApi() throws Exception{
    	
    	Map<String,Object> mv = new HashMap<String,Object>();    	
    	Map<String, Object> map = mSqlParam;

        String exeNum = "";
        String usrId = "";
		String projId = "";
		String jobId = "";
		String srcId = "";
        String url = "";
        String method = "";
        String outFormat = "";
        String xmlPrefix = "";
        String xmlNamespaceuri = "";
        String loopCnt = "";
        int successOupCnt = 0;
		int failOupCnt = 0;
		int iLoopCnt = 1;
		BigDecimal iDelayTime =  BigDecimal.ZERO;
		
        /* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
    	/* 현재 실행중 상태이면 작업중지
    	/* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */		
		List<Map<String,Object>> jobExe = executeQuery(selectExeApiExecuteYn(), map);
        
        String jobEndYn = "";
        for(Map<String, Object> jobMap : jobExe){
        	if(jobMap.containsKey("END_YN")) 
        	{
        		jobEndYn = String.valueOf(jobMap.get("END_YN"));
        		if("N".equals(jobEndYn)){
        			mv.put("state", "Processing");
        			return mv;
        		}
        	}
        }
        
        /*
         * commandMap 파라미터 로그 확인
         */
        if(map.isEmpty() == false){
        	if(map.containsKey("EXE_NUM")) 
        	{
        		exeNum = String.valueOf(map.get("EXE_NUM"));
        	}
        	if(map.containsKey("USR_ID")) 
        	{
	        	usrId = String.valueOf(map.get("USR_ID"));
        	}
        	if(map.containsKey("PROJ_ID")) 
        	{
        		projId = String.valueOf(map.get("PROJ_ID"));
        	}
        	if(map.containsKey("JOB_ID")) 
        	{
	        	jobId = String.valueOf(map.get("JOB_ID"));
        	}
        	if(map.containsKey("SRC_ID")) 
        	{
	        	srcId = String.valueOf(map.get("SRC_ID"));
        	}
        	if(map.containsKey("METHOD")) 
        	{
	        	method = String.valueOf(map.get("METHOD"));
        	}
        	if(map.containsKey("OUT_FMT")) 
        	{
        		outFormat = String.valueOf(map.get("OUT_FMT"));
        	}
        	if(map.containsKey("LOOP_CNT")) 
        	{
        		loopCnt = String.valueOf(map.get("LOOP_CNT"));
        		
        		if(Pattern.matches("[0-9]*", loopCnt)){
        			iLoopCnt = Integer.parseInt(loopCnt);	
        		}

        	}
        }
        
        /* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
    	/* JOB DELETE
    	/* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
        Map<String, Object> delExeJobMap = new HashMap<String,Object>();        
        delExeJobMap.put("EXE_NUM",exeNum);
        delExeJobMap.put("USR_ID",usrId);
        delExeJobMap.put("PROJ_ID",projId);
        delExeJobMap.put("JOB_ID",jobId);
        execute(deleteDsExeApiJob(), delExeJobMap);	  
        /* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
    	/* JOB INSERT
    	/* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
        Map<String, Object> insExeJobMap = new HashMap<String,Object>();        
        insExeJobMap.put("EXE_NUM",exeNum);
        insExeJobMap.put("USR_ID",usrId);
        insExeJobMap.put("PROJ_ID",projId);
        insExeJobMap.put("JOB_ID",jobId);
        insExeJobMap.put("EXE_STATE","S01");	// S01:시작
        insExeJobMap.put("EXE_LOG","");
        execute(insertDsExeApiJob(), insExeJobMap);
        
        /* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
    	/* SOURCE LIST
    	/* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
        // 현재는 SRC_ID 파라미터가 존재하므로 한개의 SOURCE 를 반환함.
        List<Map<String,Object>> lstSrc = executeQuery(selectDsApiSourceList(), map);
        
        CommonOpenApi cOpenApi = null;
        
        int iSrcNum = 0;        
        
        // SOURCE LIST
        for(Map<String, Object> srcMap : lstSrc){
        	if(srcMap.containsKey("SRC_ID")) 
        	{
        		srcId = String.valueOf(srcMap.get("SRC_ID"));
        	}else{
        		srcId = "";
        	}
        	map.put("SRC_ID", srcId);
        	if(srcMap.containsKey("METHOD")) 
        	{
	        	method = String.valueOf(srcMap.get("METHOD"));
        	}else{
        		method = "";
        	}
        	if(srcMap.containsKey("OUT_FMT")) 
        	{
        		outFormat = String.valueOf(srcMap.get("OUT_FMT"));
        	}else{
        		outFormat = "";
        	}
        	if(srcMap.containsKey("XML_PREFIX")) 
        	{
        		xmlPrefix = String.valueOf(srcMap.get("XML_PREFIX"));
        	}else{
        		xmlPrefix = "";
        	}
        	if(srcMap.containsKey("XML_NAMESPACEURI")) 
        	{
        		xmlNamespaceuri = String.valueOf(srcMap.get("XML_NAMESPACEURI"));
        	}else{
        		xmlNamespaceuri = "";
        	}
        	if(srcMap.containsKey("DELAY_TIME")) 
        	{
        		iDelayTime = new BigDecimal(String.valueOf(srcMap.get("DELAY_TIME")));
        	}else{
        		iDelayTime = BigDecimal.ZERO;
        	}
        	if(srcMap.containsKey("SRC_VAL")) 
        	{
        		url = String.valueOf(srcMap.get("SRC_VAL"));
        	}else{
        		url = "";
        	}
        	
            Map<String,Object> mapReqParam = new HashMap<String,Object>();
            List<Map<String,Object>> lstmapUrlParam = new ArrayList<Map<String,Object>>();
            Map<String,Object> mapUrlParam = new HashMap<String,Object>();
            Map<String,Object> mapUrlLoopParam = new HashMap<String,Object>();
            
            List<Map<String,Object>> lstInReq = executeQuery(selectDsApiInputList(), map);
            String inpKey = "";
            String inpVal = "";
            String inpType = "";
            String inpEncode = "";
            String prmType = "";
            String prmDlm = "";
            String strNum = "";
            String incNum = "";
            String[] arrInpVal = null;
            String inpKeyMulti = "";
            // Input Value 항목수만큼 반복
            // 아래 로직에서 리스트에서 유일하게 있는 값은 else 구문에 "" 치환을 하면 안된다.
            for(Map<String, Object> reqMap : lstInReq){
            	if(reqMap.containsKey("INP_TYPE")) 
            	{
            		inpType = String.valueOf(reqMap.get("INP_TYPE"));
            	}
            	if(reqMap.containsKey("PRM_TYPE")) 
            	{
            		prmType = String.valueOf(reqMap.get("PRM_TYPE"));
            	}
            	if(reqMap.containsKey("PRM_DLM")) 
            	{
            		prmDlm = String.valueOf(reqMap.get("PRM_DLM"));
            	}
            	if(prmDlm == null || prmDlm.isEmpty()){
            		prmDlm = ",";
            	}
            	if(reqMap.containsKey("INP_KEY")) 
            	{
            		inpKey = String.valueOf(reqMap.get("INP_KEY"));
            	}
            	
            	if(reqMap.containsKey("INP_ENCODE")) 
            	{
            		inpEncode = String.valueOf(reqMap.get("INP_ENCODE"));
            	}
            	
            	if(reqMap.containsKey("INP_VAL")) 
            	{
            		inpVal = String.valueOf(reqMap.get("INP_VAL"));
            		if("URL".equals(inpType) && "FIX_MULT".equals(prmType)){
        				// FIX_MULT 값의 키값 (전체 항목중에 최대 한개만 가능)
            			inpKeyMulti = inpKey;
            			arrInpVal = inpVal.split(prmDlm);
            			if("UTF8".equals(inpEncode)){
	            			for(int j=0; j<arrInpVal.length; j++){
	            				arrInpVal[j] = java.net.URLEncoder.encode(arrInpVal[j],"UTF-8");	
	            			}
            			}
            		}
            		else if("URL".equals(inpType) && "DB_MULT".equals(prmType)){
            			inpKeyMulti = inpKey;
            			Map<String, Object> selInpValMap = new HashMap<String,Object>();        
            			selInpValMap.put("USR_ID",usrId);
            			selInpValMap.put("INP_COND",inpVal);
                    	
                    	List<Map<String,Object>> lstInpVal = executeQuery(selectDsApiInpValList(), selInpValMap);
                    	int jj=0;
                    	if(lstInpVal.size()>0){
                    		arrInpVal = new String[lstInpVal.size()];
	                    	for(Map<String, Object> mapInpVal : lstInpVal) {
	                    		arrInpVal[jj] = (mapInpVal.get("INP_VAL")==null)?"":String.valueOf(mapInpVal.get("INP_VAL"));
	                    		jj++;
	                		}
                    	}
                    	if("UTF8".equals(inpEncode)){
	            			for(int j=0; j<arrInpVal.length; j++){
	            				arrInpVal[j] = java.net.URLEncoder.encode(arrInpVal[j],"UTF-8");	
	            			}
            			}
            		}else{
	            		if("UTF8".equals(inpEncode)){
	            			inpVal = java.net.URLEncoder.encode(inpVal,"UTF-8");
	            		}
            		}
            	}

            	if(reqMap.containsKey("STR_NUM")) 
            	{
            		strNum = String.valueOf(reqMap.get("STR_NUM"));
            	}else{
            		strNum = "";
            	}
            	if(reqMap.containsKey("INC_NUM")) 
            	{
            		incNum = String.valueOf(reqMap.get("INC_NUM"));
            	}else{
            		incNum = "";
            	}
            	
            	if("REQ".equals(inpType)){
            		mapReqParam.put(inpKey, inpVal);
            	}else if("URL".equals(inpType)){
            		mapUrlParam.put(inpKey, inpVal);
            		if("ADJ_LOOP".equals(prmType)){
            			mapUrlLoopParam.put(inpKey, strNum + ":" + incNum);	
            		}
            	}
            }
            
            if(arrInpVal!=null){
	            for(int i=0;i<arrInpVal.length;i++){
	            	Map<String,Object> mapUrl = new HashMap<String,Object>();
	            	mapUrl.putAll(mapUrlParam);
	            	mapUrl.put(inpKeyMulti, arrInpVal[i]);
	            	lstmapUrlParam.add(mapUrl);
	            }
            }else{
            	lstmapUrlParam.add(mapUrlParam);
            }            
            
            /* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
        	/* EXE ITEM DELETE
        	/* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
            Map<String, Object> delExeItmMap = new HashMap<String,Object>();            
            delExeItmMap.put("EXE_NUM",exeNum);
            delExeItmMap.put("USR_ID",usrId);
            delExeItmMap.put("PROJ_ID",projId);
            delExeItmMap.put("JOB_ID",jobId);
            delExeItmMap.put("SRC_ID",srcId);          
            execute(deleteDsExeApiItemBySrc(), delExeItmMap);
            
            /* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
        	/* EXE INPUT DELETE
        	/* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
            Map<String, Object> delExeInpMap = new HashMap<String,Object>();        
            delExeInpMap.put("EXE_NUM",exeNum);
            delExeInpMap.put("USR_ID",usrId);
            delExeInpMap.put("PROJ_ID",projId);
            delExeInpMap.put("JOB_ID",jobId);
            delExeInpMap.put("SRC_ID",srcId);
            execute(deleteDsExeApiInpBySrc(), delExeInpMap);
            
            /* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
        	/* EXE SOURCE DELETE
        	/* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
        	/*
        	 * 이건 고려해보자!!!!
        	 * 1. 중복URL 로직 반영시 : 기존 URL 결과에 UPDATE
        	 * 2. 재수집시 기존꺼 삭제하는 방안.. 둘다 고민해보자..
        	 * 
        	 */
        	Map<String, Object> delExeSrcMap = new HashMap<String,Object>();        
        	delExeSrcMap.put("EXE_NUM",exeNum);
        	delExeSrcMap.put("USR_ID",usrId);
        	delExeSrcMap.put("PROJ_ID",projId);
        	delExeSrcMap.put("JOB_ID",jobId);
        	delExeSrcMap.put("SRC_ID",srcId);
        	execute(deleteDsExeApiSrcBySrc(), delExeSrcMap);
            
            iSrcNum = 0;
            String urlParam = "";
            String loopValue = "";
            int iloopStr = 0;
            int iloopInc = 0;
            String[] arrLoop = null;
            String keyVal = "";
            
            Map<String,Object> mapUrlFinalParam = null;
            Map<String, Object> insExeSrcMap = null;
            Map<String, Object> insExeInpMap = null;
            Map<String, Object> itemAll = null;
            Map<String,Object> xmlNode = null;
            Map<String, Object> item = null;
            Map<String, Object> updExeSrc2Map = null;

            List<Map<String,Object>> itemRoot = null;
            List<Map<String,Object>> itemList = null;
            
            List<Map<String,Object>> lstRoot = null;
            List<Map<String,Object>> lstItem = null;
            Map<String, Object> rootIns = null;
            Map<String, Object> itemIns = null;
            
            /* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
        	/* INPUT 항목중에 FIX_MULT 항목 존재 시 반복문 수행(없으면 1번 수행)
        	/* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
            for(Map<String, Object> urlMap : lstmapUrlParam){
            	// ADJ_LOOP 항목이 존재하면 반복, 아니면 1번 수행
	            for(int i=1; i<=iLoopCnt; i++){
	            	iSrcNum++;
	            	mapUrlFinalParam = new HashMap<String,Object>();
	            	
	            	urlParam = "";
	            	for( String key : urlMap.keySet() ){
	                    log.debug("key=" + key + ",value=" + urlMap.get(key));
	                    keyVal = urlMap.get(key).toString();
	                    if(mapUrlLoopParam.containsKey(key)){
	                    	// loopValue = 1:10
	                    	loopValue = mapUrlLoopParam.get(key).toString();
	                    	arrLoop = loopValue.split(":");
	              			iloopStr = Integer.parseInt(arrLoop[0]);
	              			iloopInc = Integer.parseInt(arrLoop[1]);
	              			keyVal = String.valueOf(iloopStr + (iloopInc * (i-1)));
	                    }
	                    
	                    mapUrlFinalParam.put(key, keyVal);
	                    
	                    if(urlParam==""){
	    		        	urlParam += key + "=" + keyVal;
	    		        }else{
	    		        	urlParam += "&" + key + "=" + keyVal;
	    		        }
	                } 
	
	                /* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
	            	/* EXE SOURCE INSERT (대상 URL을 우선 INSERT)
	            	/* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
	                insExeSrcMap = new HashMap<String,Object>();        
	            	insExeSrcMap.put("EXE_NUM",exeNum);
	            	insExeSrcMap.put("USR_ID",usrId);
	            	insExeSrcMap.put("PROJ_ID",projId);
	            	insExeSrcMap.put("JOB_ID",jobId);
	            	insExeSrcMap.put("SRC_ID",srcId);
	            	insExeSrcMap.put("SRC_NUM",iSrcNum);
	            	insExeSrcMap.put("SRC_URL",url + "?" + urlParam);
	            	insExeSrcMap.put("SRC_POSITION",""); 
	            	insExeSrcMap.put("EXE_STATE","S01");	// S01:시작
	            	insExeSrcMap.put("EXE_LOG","");
	            	execute(insertDsExeApiSrc(), insExeSrcMap);
	                
	                /* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
	            	/* 완성된 하나의 URL별 API 수집
	            	/* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
	                cOpenApi = new CommonOpenApi();
	                
	                cOpenApi.setUrl(url);
	                cOpenApi.setMethod(method);
	                cOpenApi.setFormat(outFormat);
	                cOpenApi.setUrlParam(mapUrlFinalParam);
	                cOpenApi.setRequestParam(mapReqParam);            
	                cOpenApi.sendRequest();
	                
	                /* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
	            	/* EXE INPUT INSERT
	            	/* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
	                // 파라미터 수만큼 INSERT
	                if(mapUrlFinalParam != null)
	        		{
	        			for( String key : mapUrlFinalParam.keySet() ){
        	            	insExeInpMap = new HashMap<String,Object>();        
        	                insExeInpMap.put("EXE_NUM",exeNum);
        	                insExeInpMap.put("USR_ID",usrId);
        	                insExeInpMap.put("PROJ_ID",projId);
        	                insExeInpMap.put("JOB_ID",jobId);
        	                insExeInpMap.put("SRC_ID",srcId);
        	                insExeInpMap.put("SRC_NUM",iSrcNum);
        	                insExeInpMap.put("INP_ID","I00001");
        	                insExeInpMap.put("INP_KEY",key);
        	                insExeInpMap.put("INP_VAL",String.valueOf(mapUrlFinalParam.get(key)));
        	                insExeInpMap.put("EXE_STATE","S02");	// S02:정상종료
        	                insExeInpMap.put("EXE_LOG","");
        	                execute(insertDsExeApiInp(), insExeInpMap);
	        	        }
	        		}
	        		
	        		/* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
	            	/* EXE OUTPUT INSERT
	            	/* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
	        		// 이 부분을 수정해야 함..
	                itemAll = new HashMap<String,Object>();	                
	                itemAll.put("EXE_NUM",exeNum);
	                itemAll.put("USR_ID",usrId);
	                itemAll.put("PROJ_ID",projId);
	                itemAll.put("JOB_ID",jobId);
	                itemAll.put("SRC_ID",srcId);
	                itemAll.put("SRC_NUM",iSrcNum);
	                itemAll.put("OUP_ID","O00000");
	                itemAll.put("ROW_NUM",0);                
	                itemAll.put("OUP_KEY","XML");
	                itemAll.put("OUP_VAL",cOpenApi.getContent());
	                itemAll.put("EXE_STATE","S02");
	                itemAll.put("EXE_LOG","");            
	                execute(insertDsExeApiItem(), itemAll);
	        		
	        		xmlNode = new HashMap<String,Object>();
	                
	        		List<Map<String,Object>> lstOup = executeQuery(selectDsApiOutputList(), map);
	                xmlNode = cOpenApi.getXmlNode(lstOup, xmlPrefix , xmlNamespaceuri);
	                String rootOupId = "";
	                String listOupId = "";
	                
	                if(xmlNode.containsKey("ROOT")) 
	            	{
	                	itemRoot = (List<Map<String, Object>>) xmlNode.get("ROOT");
	            	}else{
	            		itemRoot = null;
	            	}
	                if(xmlNode.containsKey("LIST")) 
	            	{
	                	itemList = (List<Map<String,Object>>)xmlNode.get("LIST");
	            	}else{
	            		itemList = null;
	            	}
	                if(xmlNode.containsKey("ROOT_OUP_ID")){
	                	rootOupId= String.valueOf(xmlNode.get("ROOT_OUP_ID"));
	                }
	                if(xmlNode.containsKey("LIST_OUP_ID")){
	                	listOupId= String.valueOf(xmlNode.get("LIST_OUP_ID"));
	                }
	                
	                // ★ 배치에서만  lstRoot를 사용하지 않음.
	                //lstRoot = new ArrayList<Map<String,Object>>();
	                if(itemRoot != null){
	                	for(Map<String, Object> node : itemRoot){	                	
		        			for( String key : node.keySet() ){
		        		        item = new HashMap<String,Object>();
		        		        
		        		        item.put("EXE_NUM",exeNum);
		        		        item.put("USR_ID",usrId);
		        		        item.put("PROJ_ID",projId);
		        		        item.put("JOB_ID",jobId);
		        		        item.put("SRC_ID",srcId);
		        		        item.put("SRC_NUM",iSrcNum);
		        		        item.put("OUP_ID",rootOupId);
		        		        item.put("ROW_NUM",0);                
		        		        item.put("OUP_KEY",key);
		        		        item.put("OUP_VAL",(node.get(key)==null)?"":node.get(key));
		        		        item.put("EXE_STATE","S02");
		        		        item.put("EXE_LOG","");
		        		        
		        		        // ★ 배치에서만  하나씩 등록한다.
		        		        execute(insertDsExeApiItem(), item);		        		        
		        		        //lstRoot.add(item);
		                    } 
		                }
	                	// ★ 배치에서는 아래 리스트형태로 등록하지 않고, 하나씩 등록한다.
//		                if(lstRoot.size()>0){
//			                rootIns = new HashMap<String,Object>();
//			                rootIns.put("list", lstRoot);
//			                openapiService.insertDsExeApiItemFor(rootIns);
//		                }
	                }	                
	                
	                int iRowNum=0;
	                
	                successOupCnt = 0;
	        		failOupCnt = 0;
	        		
	        		lstItem = new ArrayList<Map<String,Object>>();
	        		if(itemList != null){
	        			for(Map<String, Object> node : itemList){
		        			iRowNum++;
	    	                successOupCnt++;
		        			for( String key : node.keySet() ){
		        				item = new HashMap<String,Object>();
		        		        
		        		        item.put("EXE_NUM",exeNum);
		        		        item.put("USR_ID",usrId);
		        		        item.put("PROJ_ID",projId);
		        		        item.put("JOB_ID",jobId);
		        		        item.put("SRC_ID",srcId);
		        		        item.put("SRC_NUM",iSrcNum);
		        		        item.put("OUP_ID",listOupId);
		        		        item.put("ROW_NUM",iRowNum);                
		        		        item.put("OUP_KEY",key);
		        		        item.put("OUP_VAL",(node.get(key)==null)?"":node.get(key));
		        		        item.put("EXE_STATE","S02");
		        		        item.put("EXE_LOG","");
		        		        
		        		        // ★ 배치에서만  하나씩 등록한다.
		        		        execute(insertDsExeApiItem(), item);		   
		        		        //lstItem.add(item);
		                    } 
		                }
	        			//★ 배치에서는 아래 리스트형태로 등록하지 않고, 하나씩 등록한다.
//		                if(lstItem.size()>0){
//			                itemIns = new HashMap<String,Object>();
//			                itemIns.put("list", lstItem);
//			                openapiService.insertDsExeApiItemFor(itemIns);
//		                }
	        		}
	                
	                /* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
	            	/* EXE SOURCE END UPDATE
	            	/* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */    
	                updExeSrc2Map = new HashMap<String,Object>();        
	                updExeSrc2Map.put("EXE_NUM",exeNum);
	                updExeSrc2Map.put("USR_ID",usrId);
	                updExeSrc2Map.put("PROJ_ID",projId);
	                updExeSrc2Map.put("JOB_ID",jobId);
	                updExeSrc2Map.put("SRC_ID",srcId);
	                updExeSrc2Map.put("SRC_NUM",iSrcNum);
	                updExeSrc2Map.put("SUCCESS_OUP_CNT",successOupCnt);
	                updExeSrc2Map.put("FAIL_OUP_CNT",failOupCnt);
	                updExeSrc2Map.put("EXE_STATE","S02");	// S02:정상종료
	                updExeSrc2Map.put("EXE_LOG","");
	                execute(updateDsExeApiSrcEnd(), updExeSrc2Map);  
	                
	                // Delay Time
	                if(iDelayTime.compareTo(BigDecimal.ZERO)==1){
	                	try{
	                		Thread.sleep(iDelayTime.longValue());
	                	}catch(InterruptedException e){
	                		if(log.isDebugEnabled()){e.printStackTrace();}
	                	}
	                }
	            }
            }

        }// SOURCE LIST 반복 종료
        
        /* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
    	/* JOB UPDATE
    	/* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
        Map<String, Object> updExeJobMap = new HashMap<String,Object>();        
        updExeJobMap.put("EXE_NUM",exeNum);
        updExeJobMap.put("USR_ID",usrId);
        updExeJobMap.put("PROJ_ID",projId);
        updExeJobMap.put("JOB_ID",jobId);
        updExeJobMap.put("EXE_STATE","S02");	// S02:종료
        updExeJobMap.put("EXE_LOG","");
        execute(updateDsExeApiJob(), updExeJobMap);        
        
        mv.put("state", "Completed");
        
		return mv;
    }
    
    private Map<String,Object> runCrawling() throws Exception{
    	
    	Map<String,Object> mv = new HashMap<String,Object>();    	
    	Map<String, Object> map = mSqlParam;
    	
        String exeNum = "";
		String usrId = "";
		String projId = "";
		String jobId = "";
		String srcId = "";
		String tgtId = "";
		String tgtSaveVal = "";
        String regex = "";
        String replaceRegex = "";
        String tgtFindType = "";
        String exeUrl = "";
        String srcPosition = "";
        String srcEncode = "";
        String srcSaveType = "";
		int successTgtCnt = 0;
		int failTgtCnt = 0;
		BigDecimal iDelayTime =  BigDecimal.ZERO;
		
		/* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
    	/* 현재 실행중 상태이면 작업중지
    	/* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */		
		List<Map<String,Object>> jobExe = executeQuery(selectExeCrwExecuteYn(), map);
        
        String jobEndYn = "";
        for(Map<String, Object> jobMap : jobExe){
        	if(jobMap.containsKey("END_YN")) 
        	{
        		jobEndYn = String.valueOf(jobMap.get("END_YN"));
        		if("N".equals(jobEndYn)){
        			mv.put("state", "Processing");
        			return mv;
        		}
        	}
        }
        /*
         * commandMap 파라미터 로그 확인
         */
        if(map.isEmpty() == false){
        	
        	if(map.containsKey("EXE_NUM")) 
        	{
        		exeNum = String.valueOf(map.get("EXE_NUM"));
        	}
        	if(map.containsKey("USR_ID")) 
        	{
	        	usrId = String.valueOf(map.get("USR_ID"));
        	}
        	if(map.containsKey("PROJ_ID")) 
        	{
        		projId = String.valueOf(map.get("PROJ_ID"));
        	}
        	if(map.containsKey("JOB_ID")) 
        	{
	        	jobId = String.valueOf(map.get("JOB_ID"));
        	}
        }
        
        List<Map<String,Object>> lstJob = executeQuery(selectDsJobList(), map);
        Map<String, Object> item = null;
        
        // JOB LIST
        for(Map<String, Object> jobMap : lstJob){
        	if(jobMap.containsKey("JOB_ID")) 
        	{
	        	jobId = String.valueOf(jobMap.get("JOB_ID"));
        	}else{
        		jobId = "";
        	}
        	map.put("JOB_ID", jobId);
        	
            /* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
        	/* JOB DELETE
        	/* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
            Map<String, Object> delExeJobMap = new HashMap<String,Object>();        
            delExeJobMap.put("EXE_NUM",exeNum);
            delExeJobMap.put("USR_ID",usrId);
            delExeJobMap.put("PROJ_ID",projId);
            delExeJobMap.put("JOB_ID",jobId);
            execute(deleteDsExeJob(), delExeJobMap);	  
            /* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
        	/* JOB INSERT
        	/* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
            Map<String, Object> insExeJobMap = new HashMap<String,Object>();        
            insExeJobMap.put("EXE_NUM",exeNum);
            insExeJobMap.put("USR_ID",usrId);
            insExeJobMap.put("PROJ_ID",projId);
            insExeJobMap.put("JOB_ID",jobId);
            insExeJobMap.put("EXE_STATE","S01");	// S01:시작
            insExeJobMap.put("EXE_LOG","");
            execute(insertDsExeJob(), insExeJobMap);
            
            /* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
        	/* SOURCE LIST
        	/* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
            List<Map<String,Object>> lstSrc = executeQuery(selectDsSourceList(), map);
            
            int iSrcNum = 0;
            // SOURCE LIST
            for(Map<String, Object> srcMap : lstSrc){
            	
            	if(srcMap.containsKey("SRC_ID")) 
            	{
            		srcId = String.valueOf(srcMap.get("SRC_ID"));
            	}else{
            		srcId = "";
            	}
            	if(srcMap.containsKey("SRC_ENCODE")) 
            	{
            		srcEncode = String.valueOf(srcMap.get("SRC_ENCODE"));
            	}else{
            		srcEncode = "";
            	}
            	if(srcMap.containsKey("SRC_SAVE_TYPE")) 
            	{
            		srcSaveType = String.valueOf(srcMap.get("SRC_SAVE_TYPE"));
            	}else{
            		srcSaveType = "";
            	}
            	if(srcMap.containsKey("DELAY_TIME")) 
            	{
            		iDelayTime = new BigDecimal(String.valueOf(srcMap.get("DELAY_TIME")));
            	}else{
            		iDelayTime = BigDecimal.ZERO;
            	}
            	
            	/* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
            	/* TARGET LIST
            	/* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */        	
            	List<Map<String,Object>> lstTgt = executeQuery(selectDsTargetList(), srcMap);            

            	if(!srcMap.containsKey("EXE_NUM")){
            		srcMap.put("EXE_NUM", exeNum);
            	}
            	if(!srcMap.containsKey("LOOP_BLOCK_CNT")){
            		srcMap.put("LOOP_BLOCK_CNT", "");
            	}
            	if(!srcMap.containsKey("LOOP_CNT")){
            		srcMap.put("LOOP_CNT", "");
            	}
            	if(!srcMap.containsKey("LOOP_BLOCK_CNT_AUTO")){
            		srcMap.put("LOOP_BLOCK_CNT_AUTO", "N");
            	}
            	if(!srcMap.containsKey("LOOP_CNT_AUTO")){
            		srcMap.put("LOOP_CNT_AUTO", "N");
            	}

                /* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
            	/* EXE ITEM DELETE
            	/* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */  
            	Map<String, Object> delExeItmMap = new HashMap<String,Object>();        
            	delExeItmMap.put("EXE_NUM",exeNum);
            	delExeItmMap.put("USR_ID",usrId);
            	delExeItmMap.put("PROJ_ID",projId);
            	delExeItmMap.put("JOB_ID",jobId);
            	delExeItmMap.put("SRC_ID",srcId);
            	execute(deleteDsExeItemBySrc(), delExeItmMap);
            	
                /* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
            	/* EXE TARGET DELETE
            	/* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
                Map<String, Object> delExeTgtMap = new HashMap<String,Object>();        
                delExeTgtMap.put("EXE_NUM",exeNum);
                delExeTgtMap.put("USR_ID",usrId);
                delExeTgtMap.put("PROJ_ID",projId);
                delExeTgtMap.put("JOB_ID",jobId);
                delExeTgtMap.put("SRC_ID",srcId);
                execute(deleteDsExeTgtBySrc(), delExeTgtMap);
            	
                /* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
            	/* EXE SOURCE DELETE
            	/* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
            	/*
            	 * 이건 고려해보자!!!!
            	 * 1. 중복URL 로직 반영시 : 기존 URL 결과에 UPDATE
            	 * 2. 재수집시 기존꺼 삭제하는 방안.. 둘다 고민해보자..
            	 * 
            	 */
            	Map<String, Object> delExeSrcMap = new HashMap<String,Object>();        
            	delExeSrcMap.put("EXE_NUM",exeNum);
            	delExeSrcMap.put("USR_ID",usrId);
            	delExeSrcMap.put("PROJ_ID",projId);
            	delExeSrcMap.put("JOB_ID",jobId);
            	delExeSrcMap.put("SRC_ID",srcId);
            	execute(deleteDsExeSrcBySrc(), delExeSrcMap);
            	
            	/* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
            	/* URL LIST
            	/* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */            
                List<Map<String,Object>> lstUrl = getSourceContent(srcMap); // INPUT, TABLE, LOOP 등의 정보로  완성된 URL 을 생성하고 배열로 반환한다.

                /* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
            	/* EXE SOURCE INSERT (대상 URL을 우선 INSERT)
            	/* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
                iSrcNum = 0;
                for(Map<String, Object> urlMap : lstUrl){
                	iSrcNum++;
                	srcPosition = String.valueOf(urlMap.get("SRC_POSITION"));	// PID.JID.SID.SNUM.TID.RNUM.KEY.PNO
                    exeUrl = String.valueOf(urlMap.get("EXE_URL"));
                    
    	        	Map<String, Object> insExeSrcMap = new HashMap<String,Object>();        
    	        	insExeSrcMap.put("EXE_NUM",exeNum);
    	        	insExeSrcMap.put("USR_ID",usrId);
    	        	insExeSrcMap.put("PROJ_ID",projId);
    	        	insExeSrcMap.put("JOB_ID",jobId);
    	        	insExeSrcMap.put("SRC_ID",srcId);
    	        	insExeSrcMap.put("SRC_NUM",iSrcNum);
    	        	insExeSrcMap.put("SRC_URL",exeUrl);
    	        	insExeSrcMap.put("SRC_POSITION",srcPosition); 
    	        	insExeSrcMap.put("EXE_STATE","S00");	// S00:준비
    	        	insExeSrcMap.put("EXE_LOG","");
    	        	execute(insertDsExeSrc(), insExeSrcMap); 	
                }      
                
                iSrcNum = 0;
                for(Map<String, Object> urlMap : lstUrl){
                	iSrcNum++;
                	
                	srcPosition = String.valueOf(urlMap.get("SRC_POSITION"));	// PID.JID.SID.SNUM.TID.RNUM.KEY.PNO
                    exeUrl = String.valueOf(urlMap.get("EXE_URL"));
                    
                	
    	            /* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
    	        	/* 완성된 하나의 URL별 웹소스(CONTENT) 수집
    	        	/* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */            	
            		// 하나의 URL별로 CONTENT 가져오기 
                    CommonSpider cSpider = new CommonSpider();
    	            cSpider.setUrl(exeUrl);
    	            cSpider.setSrcEncode(srcEncode);
    	            cSpider.setSrcSaveType(srcSaveType);
    	            cSpider.setContent("");
    	            cSpider.sendGet();	// URL CONTENT 저장
    	            
    	            /* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
                	/* EXE SOURCE UPDATE
                	/* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
    	            Map<String, Object> updExeSrcMap = new HashMap<String,Object>();        
    	            updExeSrcMap.put("EXE_NUM",exeNum);
    	            updExeSrcMap.put("USR_ID",usrId);
    	            updExeSrcMap.put("PROJ_ID",projId);
    	            updExeSrcMap.put("JOB_ID",jobId);
    	            updExeSrcMap.put("SRC_ID",srcId);
    	            updExeSrcMap.put("SRC_NUM",iSrcNum);
    	            updExeSrcMap.put("SRC_CONTENT",cSpider.getContent());
    	            updExeSrcMap.put("EXE_STATE","S01");	// S01:시작
    	            updExeSrcMap.put("EXE_LOG","");
    	            execute(updateDsExeSrcStart(), updExeSrcMap);	            
    	            
    	            /* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
    	        	/* TARGET 별 추출결과 저장
    	        	/* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
            		successTgtCnt = 0;
            		failTgtCnt = 0;                
    	            for(Map<String, Object> tgtMap : lstTgt){
    	            	tgtId = (tgtMap.get("TGT_ID")==null)?"":String.valueOf(tgtMap.get("TGT_ID"));
    	            	regex = (tgtMap.get("TGT_FIND_VAL")==null)?"":String.valueOf(tgtMap.get("TGT_FIND_VAL"));
    	            	replaceRegex = (tgtMap.get("TGT_REP_VAL")==null)?"":String.valueOf(tgtMap.get("TGT_REP_VAL"));
    	            	tgtSaveVal = (tgtMap.get("TGT_SAVE_VAL")==null)?"":String.valueOf(tgtMap.get("TGT_SAVE_VAL"));
    	            	tgtFindType = (tgtMap.get("TGT_FIND_TYPE")==null)?"":String.valueOf(tgtMap.get("TGT_FIND_TYPE"));
    	            	
    	            	/* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
    	            	/* EXE TARGET INSERT
    	            	/* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
    	            	Map<String, Object> insExeTgtMap = new HashMap<String,Object>();        
    	            	insExeTgtMap.put("EXE_NUM",exeNum);
    	            	insExeTgtMap.put("USR_ID",usrId);
    	            	insExeTgtMap.put("PROJ_ID",projId);
    	            	insExeTgtMap.put("JOB_ID",jobId);
    	            	insExeTgtMap.put("SRC_ID",srcId);
    	            	insExeTgtMap.put("SRC_NUM",iSrcNum);
    	            	insExeTgtMap.put("TGT_ID",tgtId);
    	            	insExeTgtMap.put("TGT_SAVE_VAL",tgtSaveVal);  	
    	            	insExeTgtMap.put("EXE_STATE","S01");	// S01:시작
    	            	insExeTgtMap.put("EXE_LOG","");
    	            	execute(insertDsExeTgt(), insExeTgtMap);	        	            	
    	            	
    		            cSpider.setRegex(regex);
    		            cSpider.setReplaceRegex(replaceRegex);
    		            cSpider.setTgtFindType(tgtFindType);
    		            cSpider.setTgtSaveVal(tgtSaveVal);
    		            cSpider.setDisptype("MCH_GNM");
    		            List<Map<String, Object>> lstMatch = cSpider.getRegexMap();

    		            int iRowNum = 0;
    		            for(Map<String, Object> mchMap : lstMatch) {
    		            	iRowNum ++;
    		            	for( String key : mchMap.keySet() ){
    		                    log.debug("key=" + key + ",value=" + mchMap.get(key));
    		                    
    			                /* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
    			            	/* EXE ITEM INSERT
    			            	/* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */	                    
    		                    item = new HashMap<String,Object>();		                    
    		                    item.put("EXE_NUM",exeNum);
    		                    item.put("USR_ID",usrId);
    		                    item.put("PROJ_ID",projId);
    		                    item.put("JOB_ID",jobId);		                    
    		                    item.put("SRC_ID",srcId);
    		                    item.put("SRC_NUM",iSrcNum);
    		                    item.put("TGT_ID",tgtId);
    		                    item.put("ROW_NUM",iRowNum);
    		                    item.put("ITEM_KEY",key);
    		                    item.put("ITEM_NM",key);
    		                    item.put("ITEM_VAL",mchMap.get(key));
    		                    item.put("EXE_STATE","S02");
    		                    item.put("EXE_LOG","");		    
    		                    execute(insertDsExeItem(), item);
    		                } 
    		            }	
    		            
    	                /* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
    	            	/* EXE TARGET UPDATE
    	            	/* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */	
    		            Map<String, Object> updExeTgtMap = new HashMap<String,Object>();        
    		            updExeTgtMap.put("EXE_NUM",exeNum);
    		            updExeTgtMap.put("USR_ID",usrId);
    		            updExeTgtMap.put("PROJ_ID",projId);
    		            updExeTgtMap.put("JOB_ID",jobId);
    		            updExeTgtMap.put("SRC_ID",srcId);
    		            updExeTgtMap.put("SRC_NUM",iSrcNum);
    		            updExeTgtMap.put("TGT_ID",tgtId);
    		            updExeTgtMap.put("ITM_CNT",iRowNum);  	
    		            updExeTgtMap.put("EXE_STATE","S02");	// S02:정상종료
    		            updExeTgtMap.put("EXE_LOG","");
    		            execute(updateDsExeTgt(), updExeTgtMap);	
    	                
    	                successTgtCnt += (iRowNum>0)?1:0;
    	                failTgtCnt += (iRowNum<=0)?1:0;
    	            }
    	            
                    /* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
                	/* EXE SOURCE UPDATE
                	/* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */    
    	            Map<String, Object> updExeSrc2Map = new HashMap<String,Object>();        
    	            updExeSrc2Map.put("EXE_NUM",exeNum);
    	            updExeSrc2Map.put("USR_ID",usrId);
    	            updExeSrc2Map.put("PROJ_ID",projId);
    	            updExeSrc2Map.put("JOB_ID",jobId);
    	            updExeSrc2Map.put("SRC_ID",srcId);
    	            updExeSrc2Map.put("SRC_NUM",iSrcNum);
    	            updExeSrc2Map.put("SUCCESS_TGT_CNT",successTgtCnt);
    	            updExeSrc2Map.put("FAIL_TGT_CNT",failTgtCnt);
    	            updExeSrc2Map.put("EXE_STATE","S02");	// S02:정상종료
    	            updExeSrc2Map.put("EXE_LOG","");
    	            execute(updateDsExeSrcEnd(), updExeSrc2Map);
                    
                    // Delay Time
                    if(iDelayTime.compareTo(BigDecimal.ZERO)==1){
                    	try{
                    		Thread.sleep(iDelayTime.longValue());
                    	}catch(InterruptedException e){
                    		if(log.isDebugEnabled()){e.printStackTrace();}
                    	}
                    }

                }// URL 반목문 종료

                
            } // SOURCE LIST 반복 종료
            
            /* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
        	/* JOB UPDATE
        	/* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
            Map<String, Object> updExeJobMap = new HashMap<String,Object>();        
            updExeJobMap.put("EXE_NUM",exeNum);
            updExeJobMap.put("USR_ID",usrId);
            updExeJobMap.put("PROJ_ID",projId);
            updExeJobMap.put("JOB_ID",jobId);
            updExeJobMap.put("EXE_STATE","S02");	// S02:종료
            updExeJobMap.put("EXE_LOG","");
            execute(updateDsExeJob(), updExeJobMap);        
        }
    	
    	mv.put("state", "Completed");
        
		return mv;
    	
    }
    
    private List<Map<String,Object>> getSourceContent(Map<String, Object> map) throws Exception{
    	List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
    	
    	log.debug("==========getSourceContent()===========" );
    	for( Map.Entry<String, Object> elem : map.entrySet() ){
            log.debug(String.format("키 : %s, 값 : %s", elem.getKey(), elem.getValue()) );
        }
    	
		// SRC_ID 별 대상 URL 및 LOOP_BLOCK_CNT, LOOP_CNT 값을 반환
		List<Map<String,Object>> lstUrl = executeQuery(selectDsExeUrlVal(), map);
		
    	String urlVal = "";
    	String urlLoopVal = "";
    	String srcPosition = "";
    	String loopBlockCntVal = "";
    	String loopCntVal = "";
    	String[] prmKey = new String[5];
    	String[] prmTyp = new String[5];
    	String[] prmVal = new String[5];
    	String[] prmInc = new String[5];
    	int[] iPrmVal = new int[5];
    	int[] iPrmInc = new int[5];
    	
    	int iLoopBlockCnt = 0; 
    	int iLoopCnt = 0;
    	int iLoop = 0;
    	Map<String,Object> urlMap = null;
    	
    	if(lstUrl.size()>0){
    		Map<String, Object> prmMap = lstUrl.get(0);
			for(int j=0; j<5; j++){
				prmKey[j] = (prmMap.get("PRM" + (j+1) + "_KEY")==null)?"":String.valueOf(prmMap.get("PRM" + (j+1) + "_KEY"));
				prmTyp[j] = (prmMap.get("PRM" + (j+1) + "_TYP")==null)?"":String.valueOf(prmMap.get("PRM" + (j+1) + "_TYP"));
				prmVal[j] = (prmMap.get("PRM" + (j+1) + "_VAL")==null)?"":String.valueOf(prmMap.get("PRM" + (j+1) + "_VAL"));
				prmInc[j] = (prmMap.get("PRM" + (j+1) + "_INC")==null)?"":String.valueOf(prmMap.get("PRM" + (j+1) + "_INC"));
				
				if(!prmVal[j].isEmpty() && isInteger(prmVal[j])){iPrmVal[j] = Integer.parseInt(prmVal[j]);}
				if(!prmInc[j].isEmpty() && isInteger(prmInc[j])){iPrmInc[j] = Integer.parseInt(prmInc[j]);}
			}
    	}
		
		for(Map<String, Object> map2 : lstUrl) {

			srcPosition = (map2.get("SRC_POSITION")==null)?"":String.valueOf(map2.get("SRC_POSITION"));
			urlVal = (map2.get("URL_VAL")==null)?"":String.valueOf(map2.get("URL_VAL"));
			loopBlockCntVal = (map2.get("LOOP_BLOCK_CNT_VAL")==null)?"0":String.valueOf(map2.get("LOOP_BLOCK_CNT_VAL"));
			loopCntVal = (map2.get("LOOP_CNT_VAL")==null)?"0":String.valueOf(map2.get("LOOP_CNT_VAL"));
			
			if(!loopBlockCntVal.isEmpty() && isInteger(loopBlockCntVal))
				iLoopBlockCnt = Integer.parseInt(loopBlockCntVal);
			else
				iLoopBlockCnt = 0;
			
			if(!loopCntVal.isEmpty() && isInteger(loopCntVal))
				iLoopCnt = Integer.parseInt(loopCntVal);
			else
				iLoopCnt = 0;
			
			if(iLoopBlockCnt > 0 && iLoopCnt > 0)
				iLoop = Math.round(iLoopCnt/iLoopBlockCnt);
			else
				iLoop = 1;
			
			for(int i=0; i<iLoop; i++){
				urlLoopVal = urlVal;
				for(int j=0; j<5; j++){
					// 가변
					if("ADJ".equals(prmTyp[j]) && !prmKey[j].isEmpty()){
						int iAdd = (iPrmVal[j]+(iPrmInc[j]*i));
						urlLoopVal = urlLoopVal.replace("{" + prmKey[j] + "}", ""+iAdd);
					}
					// 고정
					else if("FIX".equals(prmTyp[j]) && !prmKey[j].isEmpty()){
						urlLoopVal = urlLoopVal.replace("{" + prmKey[j] + "}", prmVal[j]);	
					}
				}
				urlMap = new HashMap<String,Object>();
				urlMap.put("SRC_POSITION", srcPosition + "." + (i+1));
				urlMap.put("EXE_URL", urlLoopVal);
				
				list.add(urlMap);
			}
		}		
    	
		return list;
    }
    
    public boolean isInteger( String input )
    {
       try
       {
          Integer.parseInt( input );
          return true;
       }
       catch( Exception e)
       {
          return false;
       }
    }
    
    private List<Map<String,Object>> executeQuery(Map<String,Object> map, Map<String, Object> mSqlParam) throws SQLException{
    	
    	List<Map<String,Object>> lstRst = new ArrayList<Map<String,Object>>();
    	 
    	ResultSet rs = null;
    	// SQL, Map(파라미터순서, 파라미터타입, 파라미터명)

    	String sql = "";
    	sql = String.valueOf(map.get("SQL"));

    	String key;
    	String type;

    	if(map.containsKey("PRL")){
	    	List<HashMap<String,String>> lstPrl = (ArrayList<HashMap<String,String>>)map.get("PRL");
	    	for(int i=0; i<lstPrl.size(); i++)
	    	{
	    		Map<String, String> prl = lstPrl.get(i);
	    		key = prl.get("KEY");
	    		type = prl.get("VALUE");
	    		
	    		//System.out.println("KEY=" + key + ",TYPE=" + type);
	    		
	    		sql = sql.replaceAll(type, String.valueOf(mSqlParam.get(key)));
	    	}
    	}

    	//System.out.println("SQL=" + sql);
    	
    	pstmt = conn.prepareStatement(sql);
    	
    	if(map.containsKey("PRM")){
	    	List<HashMap<String,String>> lstPrm = (ArrayList<HashMap<String,String>>)map.get("PRM");
	    	
	    	for(int i=0; i<lstPrm.size(); i++)
	    	{
	    		Map<String, String> prm = lstPrm.get(i);
	    		key = prm.get("KEY");
	    		type = prm.get("VALUE");
	    		
	    		if("STRING".equals(type)){
	    			pstmt.setString((i+1), String.valueOf(mSqlParam.get(key)));
	    			//System.out.println("KEY=" + key + ",VALUE=" + String.valueOf(mSqlParam.get(key)));
	    		}else if("INTEGER".equals(type)){
	    			pstmt.setInt((i+1), Integer.valueOf(String.valueOf(mSqlParam.get(key))));
	    			//System.out.println("KEY=" + key + ",VALUE=" + String.valueOf(mSqlParam.get(key)));
	    		}else if("FLOAT".equals(type)){
	    			pstmt.setFloat((i+1), Float.valueOf(String.valueOf(mSqlParam.get(key))));
	    			//System.out.println("KEY=" + key + ",VALUE=" + String.valueOf(mSqlParam.get(key)));
	    		}else if("CLOB".equals(type))
	    		{
		    		Clob clob = conn.createClob();
		    		clob.setString(1, String.valueOf(mSqlParam.get(key)));
		    		pstmt.setClob((i+1), clob);
	    		}
	    	}
    	}
    	
		rs = pstmt.executeQuery();
		
		ResultSetMetaData rsmd = rs.getMetaData();
		
		while (rs.next()) {
			Map<String,Object> mapRow = new HashMap<String,Object>();
			
			for(int i=0; i<rsmd.getColumnCount(); i++){
				mapRow.put(rsmd.getColumnName((i+1)), rs.getString(rsmd.getColumnName((i+1))));
			}
			
			lstRst.add(mapRow);    
        }
		
		pstmt.close();
		
    	return lstRst;
    }
    
    private boolean execute(Map<String,Object> map, Map<String, Object> mSqlParam) throws SQLException{
    	boolean bOk = false;
    	
    	String sql = "";
    	sql = String.valueOf(map.get("SQL"));

    	String key;
    	String type;

    	if(map.containsKey("PRL")){
	    	List<HashMap<String,String>> lstPrl = (ArrayList<HashMap<String,String>>)map.get("PRL");
	    	for(int i=0; i<lstPrl.size(); i++)
	    	{
	    		Map<String, String> prl = lstPrl.get(i);
	    		key = prl.get("KEY");
	    		type = prl.get("VALUE");
	    		
	    		//System.out.println("KEY=" + key + ",VALUE=" + mSqlParam.get(key));
	    		
	    		sql = sql.replaceAll(type, String.valueOf(mSqlParam.get(key)));
	    	}
    	}

    	//System.out.println("SQL=" + sql);
    	
    	pstmt = conn.prepareStatement(sql);
    	
    	if(map.containsKey("PRM")){
	    	List<HashMap<String,String>> lstPrm = (ArrayList<HashMap<String,String>>)map.get("PRM");
	    	
	    	for(int i=0; i<lstPrm.size(); i++)
	    	{
	    		Map<String, String> prm = lstPrm.get(i);
	    		key = prm.get("KEY");
	    		type = prm.get("VALUE");
	    		
	    		if("STRING".equals(type)){
	    			pstmt.setString((i+1), String.valueOf(mSqlParam.get(key)));
	    			//System.out.println("KEY=" + key + ",VALUE=" + String.valueOf(mSqlParam.get(key)));
	    		}else if("INTEGER".equals(type)){
	    			pstmt.setInt((i+1), Integer.valueOf(String.valueOf(mSqlParam.get(key))));
	    			//System.out.println("KEY=" + key + ",VALUE=" + String.valueOf(mSqlParam.get(key)));
	    		}else if("FLOAT".equals(type)){
	    			pstmt.setFloat((i+1), Float.valueOf(String.valueOf(mSqlParam.get(key))));
	    			//System.out.println("KEY=" + key + ",VALUE=" + String.valueOf(mSqlParam.get(key)));
	    		}else if("CLOB".equals(type))
	    		{
	    			//System.out.println("KEY=" + key + ",VALUE=CLOB");
		    		Clob clob = conn.createClob();
		    		clob.setString(1, String.valueOf(mSqlParam.get(key)));
		    		pstmt.setClob((i+1), clob);
	    		}
	    	}
    	}
    	
		bOk = pstmt.execute();
		pstmt.close();
		return bOk;
    }
    
    private HashMap<String, String> getSqlParamMap(String key, String value){
    	HashMap<String, String> prm = new HashMap<String, String>();
    	prm.put("KEY", key);
    	prm.put("VALUE", value);
    	return prm;
    }
    
    private Map<String,Object> selectExeApiExecuteYn(){
    	Map<String,Object> mapSql =  new HashMap<String,Object>();
    	
    	StringBuilder sb = new StringBuilder();
    	
    	sb.append("select exe_state");
    	sb.append("     , nvl2(end_time,'Y','N') as end_yn");
		sb.append("  from cbap$_exe_api_job t");
		sb.append(" where t.exe_num = ?");
		sb.append("   and t.usr_id = ?");
		sb.append("   and t.proj_id = ?");
		sb.append("   and t.job_id = ?");
		
    	// SQL 등록
    	mapSql.put("SQL", sb.toString());
    	
    	// SQL 파라미터정보 등록
    	List<HashMap<String,String>> lstPrm = new ArrayList<HashMap<String,String>>();
    	lstPrm.add(getSqlParamMap("EXE_NUM", "STRING"));
    	lstPrm.add(getSqlParamMap("USR_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("PROJ_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("JOB_ID", "STRING"));
    	
    	mapSql.put("PRM", lstPrm);
    	
    	return mapSql;
    }
    
    private Map<String,Object> deleteDsExeApiJob(){
		Map<String,Object> mapSql =  new HashMap<String,Object>();
		
		StringBuilder sb = new StringBuilder();
    	
		sb.append("delete from cbap$_exe_api_job where exe_num = ? and usr_id = ? and proj_id = ? and job_id = ?");
		
    	// SQL 등록
    	mapSql.put("SQL", sb.toString());
    	
    	// SQL 파라미터정보 등록
    	List<HashMap<String,String>> lstPrm = new ArrayList<HashMap<String,String>>();
    	lstPrm.add(getSqlParamMap("EXE_NUM", "STRING"));
    	lstPrm.add(getSqlParamMap("USR_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("PROJ_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("JOB_ID", "STRING"));
    	
    	mapSql.put("PRM", lstPrm);
    	
    	return mapSql;    	
    }

    private Map<String,Object> insertDsExeApiJob(){
		Map<String,Object> mapSql =  new HashMap<String,Object>();
		
		StringBuilder sb = new StringBuilder();
    	
		sb.append("insert into cbap$_exe_api_job (exe_num, usr_id, proj_id, job_id, exe_state, exe_log, str_time, rgst_id, rgst_dt) values ");
		sb.append(" (?,?,?,?,?,?,SYSTIMESTAMP,?, SYSDATE)");
		
    	// SQL 등록
    	mapSql.put("SQL", sb.toString());
    	
    	// SQL 파라미터정보 등록
    	List<HashMap<String,String>> lstPrm = new ArrayList<HashMap<String,String>>();
    	lstPrm.add(getSqlParamMap("EXE_NUM", "STRING"));
    	lstPrm.add(getSqlParamMap("USR_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("PROJ_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("JOB_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("EXE_STATE", "STRING"));
    	lstPrm.add(getSqlParamMap("EXE_LOG", "STRING"));
    	lstPrm.add(getSqlParamMap("USR_ID", "STRING"));
    	
    	mapSql.put("PRM", lstPrm);
    	
    	return mapSql;    	
    }    
    
    private Map<String,Object> selectDsApiSourceList(){
    	
    	Map<String,Object> mapSql =  new HashMap<String,Object>();
    	
    	StringBuilder sb = new StringBuilder();
    	
    	sb.append("select usr_id");
    	sb.append("     , proj_id, job_id, src_id, src_nm"); 
		sb.append("     , src_div_cd");
		sb.append("     , src_typ_cd");
		sb.append("     , src_encode");
		sb.append("     , src_val");
		sb.append("     , src_val_position");
		sb.append("     , method, auth_yn, out_fmt");
		sb.append("     , xml_prefix, xml_namespaceuri");
		sb.append("     , delay_time ");
		sb.append("     , disp_ord"); 
		sb.append("  from cbap$_api_src"); 
		sb.append(" where usr_id = ?");
		sb.append("   and proj_id = ?");
		sb.append("   and job_id = ?");
		sb.append("   and src_id in (:SRC_ID_LST)");
		sb.append(" order by disp_ord");
		
    	// SQL 등록
    	mapSql.put("SQL", sb.toString());
    	
    	// SQL 파라미터정보 등록
    	List<HashMap<String,String>> lstPrm = new ArrayList<HashMap<String,String>>();
    	lstPrm.add(getSqlParamMap("USR_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("PROJ_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("JOB_ID", "STRING"));
    	//lstPrm.add(getSqlParamMap("SRC_ID", "STRING"));
    	
    	mapSql.put("PRM", lstPrm);
    	
    	// SQL 파라미터정보 등록(동적쿼리)
    	List<HashMap<String,String>> lstPrl = new ArrayList<HashMap<String,String>>();
    	lstPrl.add(getSqlParamMap("SRC_ID_LST", ":SRC_ID_LST"));
    	mapSql.put("PRL", lstPrl);
    	
    	return mapSql;
    }
    
    private Map<String,Object> selectDsApiInputList(){
    	
    	Map<String,Object> mapSql =  new HashMap<String,Object>();
    	
    	StringBuilder sb = new StringBuilder();
    	
    	sb.append("select usr_id");
    	sb.append("     , proj_id");
    	sb.append("     , job_id");
    	sb.append("     , src_id");
    	sb.append("     , inp_id");
    	sb.append("     , inp_nm");
    	sb.append("     , inp_key");
    	sb.append("     , inp_val");
    	sb.append("     , inp_val as inp_eval");
    	sb.append("     , inp_type");
    	sb.append("     , inp_encode");
    	sb.append("     , prm_type");
    	sb.append("     , prm_dlm");
    	sb.append("     , str_num");
    	sb.append("     , inc_num");
    	sb.append("     , use_yn");
    	sb.append("     , disp_ord");
    	sb.append("  from cbap$_api_inp");
    	sb.append(" where usr_id = ?");
    	sb.append("   and proj_id = ?");
    	sb.append("   and job_id = ?");
    	sb.append("   and src_id = ?");
    	sb.append("   and use_yn = ?");
    	sb.append(" order by disp_ord");
		
    	// SQL 등록
    	mapSql.put("SQL", sb.toString());
    	
    	// SQL 파라미터정보 등록
    	List<HashMap<String,String>> lstPrm = new ArrayList<HashMap<String,String>>();
    	lstPrm.add(getSqlParamMap("USR_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("PROJ_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("JOB_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("USE_YN", "STRING"));
    	
    	mapSql.put("PRM", lstPrm);
    	
    	return mapSql;
    }
    
    private Map<String,Object> selectDsApiInpValList(){
    	
    	Map<String,Object> mapSql =  new HashMap<String,Object>();
    	
    	StringBuilder sb = new StringBuilder();
    	
    	sb.append("select t.row_num");
    	sb.append("     , t.inp_val ");
    	sb.append("  from cbap$_api_inp_val t");
    	sb.append(" where t.usr_id = ?");
    	sb.append("   and t.proj_id || '.' || t.job_id || '.' || t.src_id || '.' || t.inp_id = ?");
    	sb.append("   and t.use_yn = 'Y'");
    	sb.append(" order by t.disp_ord");
		
    	// SQL 등록
    	mapSql.put("SQL", sb.toString());
    	
    	// SQL 파라미터정보 등록
    	List<HashMap<String,String>> lstPrm = new ArrayList<HashMap<String,String>>();
    	lstPrm.add(getSqlParamMap("USR_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("INP_COND", "STRING"));
    	
    	mapSql.put("PRM", lstPrm);
    	
    	return mapSql;
    }
        
    private Map<String,Object> deleteDsExeApiItemBySrc(){
		Map<String,Object> mapSql =  new HashMap<String,Object>();
		
		StringBuilder sb = new StringBuilder();
    	
		sb.append("delete from cbap$_exe_api_oup where exe_num = ? and usr_id = ? and proj_id = ? and job_id = ? and src_id = ?");
		
    	// SQL 등록
    	mapSql.put("SQL", sb.toString());
    	
    	// SQL 파라미터정보 등록
    	List<HashMap<String,String>> lstPrm = new ArrayList<HashMap<String,String>>();
    	lstPrm.add(getSqlParamMap("EXE_NUM", "STRING"));
    	lstPrm.add(getSqlParamMap("USR_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("PROJ_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("JOB_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_ID", "STRING"));
    	
    	mapSql.put("PRM", lstPrm);
    	
    	return mapSql;    	
    }
    
    private Map<String,Object> deleteDsExeApiInpBySrc(){
		Map<String,Object> mapSql =  new HashMap<String,Object>();
		
		StringBuilder sb = new StringBuilder();
    	
		sb.append("delete from cbap$_exe_api_inp where exe_num = ? and usr_id = ? and proj_id = ? and job_id = ? and src_id = ?");
		
    	// SQL 등록
    	mapSql.put("SQL", sb.toString());
    	
    	// SQL 파라미터정보 등록
    	List<HashMap<String,String>> lstPrm = new ArrayList<HashMap<String,String>>();
    	lstPrm.add(getSqlParamMap("EXE_NUM", "STRING"));
    	lstPrm.add(getSqlParamMap("USR_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("PROJ_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("JOB_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_ID", "STRING"));
    	
    	mapSql.put("PRM", lstPrm);
    	
    	return mapSql;    	
    }
    
    private Map<String,Object> deleteDsExeApiSrcBySrc(){
		Map<String,Object> mapSql =  new HashMap<String,Object>();
		
		StringBuilder sb = new StringBuilder();
    	
		sb.append("delete from cbap$_exe_api_src where exe_num = ? and usr_id = ? and proj_id = ? and job_id = ? and src_id = ?");
		
    	// SQL 등록
    	mapSql.put("SQL", sb.toString());
    	
    	// SQL 파라미터정보 등록
    	List<HashMap<String,String>> lstPrm = new ArrayList<HashMap<String,String>>();
    	lstPrm.add(getSqlParamMap("EXE_NUM", "STRING"));
    	lstPrm.add(getSqlParamMap("USR_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("PROJ_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("JOB_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_ID", "STRING"));
    	
    	mapSql.put("PRM", lstPrm);
    	
    	return mapSql;    	
    }
    
    private Map<String,Object> insertDsExeApiSrc(){
		Map<String,Object> mapSql =  new HashMap<String,Object>();
		
		StringBuilder sb = new StringBuilder();
    	
		sb.append("insert into cbap$_exe_api_src");
		sb.append("	(exe_num, usr_id, proj_id, job_id, src_id, src_num, src_url, src_position");
		sb.append("	, pos_proj_id, pos_job_id, pos_src_id, pos_src_num, pos_oup_id, pos_row_num, pos_oup_key");
		sb.append("	, exe_state, exe_log, str_time, rgst_id, rgst_dt) values");
		sb.append("	( ?, ?, ?, ?, ?, ?, ?, ?");
		sb.append("	, regexp_substr(?, '[^.]+', 1, 1), regexp_substr(?, '[^.]+', 1, 2), regexp_substr(?, '[^.]+', 1, 3)");
		sb.append("	, regexp_substr(?, '[^.]+', 1, 4), regexp_substr(?, '[^.]+', 1, 5), regexp_substr(?, '[^.]+', 1, 6)");
		sb.append("	, regexp_substr(?, '[^.]+', 1, 7)");
		sb.append("	, ?, ?, SYSTIMESTAMP, ?, SYSDATE )");
		
    	// SQL 등록
    	mapSql.put("SQL", sb.toString());
    	
    	// SQL 파라미터정보 등록
    	List<HashMap<String,String>> lstPrm = new ArrayList<HashMap<String,String>>();
    	lstPrm.add(getSqlParamMap("EXE_NUM", "STRING"));
    	lstPrm.add(getSqlParamMap("USR_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("PROJ_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("JOB_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_NUM", "INTEGER"));
    	lstPrm.add(getSqlParamMap("SRC_URL", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_POSITION", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_POSITION", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_POSITION", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_POSITION", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_POSITION", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_POSITION", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_POSITION", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_POSITION", "STRING"));
    	lstPrm.add(getSqlParamMap("EXE_STATE", "STRING"));
    	lstPrm.add(getSqlParamMap("EXE_LOG", "STRING"));
    	lstPrm.add(getSqlParamMap("USR_ID", "STRING"));
    	
    	mapSql.put("PRM", lstPrm);
    	
    	return mapSql;    	
    }   
 
    private Map<String,Object> insertDsExeApiInp(){
		Map<String,Object> mapSql =  new HashMap<String,Object>();
		
		StringBuilder sb = new StringBuilder();
		
		sb.append("insert into cbap$_exe_api_inp (exe_num, usr_id, proj_id, job_id, src_id, src_num, inp_id, inp_key, inp_val");
		sb.append(" , exe_state, exe_log, str_time, rgst_id, rgst_dt) values");
		sb.append(" (?,?,?,?,?,?,?,?,?");
		sb.append(" ,?,?,SYSTIMESTAMP, ?, SYSDATE)");
		
    	// SQL 등록
    	mapSql.put("SQL", sb.toString());
    	
    	// SQL 파라미터정보 등록
    	List<HashMap<String,String>> lstPrm = new ArrayList<HashMap<String,String>>();
    	lstPrm.add(getSqlParamMap("EXE_NUM", "STRING"));
    	lstPrm.add(getSqlParamMap("USR_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("PROJ_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("JOB_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_NUM", "INTEGER"));
    	lstPrm.add(getSqlParamMap("INP_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("INP_KEY", "STRING"));
    	lstPrm.add(getSqlParamMap("INP_VAL", "STRING"));
    	lstPrm.add(getSqlParamMap("EXE_STATE", "STRING"));
    	lstPrm.add(getSqlParamMap("EXE_LOG", "STRING"));
    	lstPrm.add(getSqlParamMap("USR_ID", "STRING"));
    	
    	mapSql.put("PRM", lstPrm);
    	
    	return mapSql;    	
    }   

    private Map<String,Object> insertDsExeApiItem(){
		Map<String,Object> mapSql =  new HashMap<String,Object>();
		
		StringBuilder sb = new StringBuilder();
		
		sb.append("insert into cbap$_exe_api_oup (exe_num, usr_id, proj_id, job_id, src_id, src_num, oup_id, row_num, oup_key, oup_val, oup_val_position");
		sb.append("	,exe_state, exe_log, exe_time, rgst_id, rgst_dt) values");
		sb.append(" (?,?,?,?,?,?,?,?,?,?,?||'.'||?||'.'||?||'.'||?||'.'||?");
		sb.append(" ,?,?,SYSTIMESTAMP, ?, SYSDATE)");
		
    	// SQL 등록
    	mapSql.put("SQL", sb.toString());
    	
    	// SQL 파라미터정보 등록
    	List<HashMap<String,String>> lstPrm = new ArrayList<HashMap<String,String>>();
    	lstPrm.add(getSqlParamMap("EXE_NUM", "STRING"));
    	lstPrm.add(getSqlParamMap("USR_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("PROJ_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("JOB_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_NUM", "INTEGER"));    	
    	lstPrm.add(getSqlParamMap("OUP_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("ROW_NUM", "INTEGER"));
    	lstPrm.add(getSqlParamMap("OUP_KEY", "STRING"));
    	lstPrm.add(getSqlParamMap("OUP_VAL", "CLOB"));
    	lstPrm.add(getSqlParamMap("PROJ_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("JOB_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("OUP_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("OUP_KEY", "STRING"));
    	lstPrm.add(getSqlParamMap("EXE_STATE", "STRING"));
    	lstPrm.add(getSqlParamMap("EXE_LOG", "STRING"));
    	lstPrm.add(getSqlParamMap("USR_ID", "STRING"));
    	
    	mapSql.put("PRM", lstPrm);
    	
    	return mapSql;    	
    }   

    private Map<String,Object> selectDsApiOutputList(){
    	
    	Map<String,Object> mapSql =  new HashMap<String,Object>();
    	
    	StringBuilder sb = new StringBuilder();
    	
    	sb.append("select usr_id");
    	sb.append("     , proj_id");
    	sb.append("     , job_id");
    	sb.append("     , src_id");
    	sb.append("     , oup_id");
    	sb.append("     , oup_nm");
    	sb.append("     , oup_key");
    	sb.append("     , oup_div");
    	sb.append("     , oup_type");
    	sb.append("     , oup_exp");
    	sb.append("     , oup_desc");
    	sb.append("     , use_yn");
    	sb.append("     , disp_ord");
    	sb.append("  from cbap$_api_oup");
    	sb.append(" where usr_id = ?");
    	sb.append("   and proj_id = ?");
    	sb.append("   and job_id = ?");
    	sb.append("   and src_id = ?");
    	sb.append("   and use_yn = ?");
    	sb.append(" order by disp_ord");
		
    	// SQL 등록
    	mapSql.put("SQL", sb.toString());
    	
    	// SQL 파라미터정보 등록
    	List<HashMap<String,String>> lstPrm = new ArrayList<HashMap<String,String>>();
    	lstPrm.add(getSqlParamMap("USR_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("PROJ_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("JOB_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("USE_YN", "STRING"));
    	
    	mapSql.put("PRM", lstPrm);
    	
    	return mapSql;
    }
    
    private Map<String,Object> updateDsExeApiSrcEnd(){
		Map<String,Object> mapSql =  new HashMap<String,Object>();
		
		StringBuilder sb = new StringBuilder();
		
		sb.append("update cbap$_exe_api_src");
		sb.append("   set success_oup_cnt = ?");
		sb.append("     , fail_oup_cnt = ?");
		sb.append("     , exe_state = ?");
		sb.append("     , exe_log = ?");
		sb.append("     , end_time = SYSTIMESTAMP");
		sb.append(" where exe_num = ?");
		sb.append("   and usr_id = ?");
		sb.append("   and proj_id = ?");
		sb.append("   and job_id = ?");
		sb.append("   and src_id = ?");
		sb.append("   and src_num = ?");		
		
    	// SQL 등록
    	mapSql.put("SQL", sb.toString());
    	
    	// SQL 파라미터정보 등록
    	List<HashMap<String,String>> lstPrm = new ArrayList<HashMap<String,String>>();
    	lstPrm.add(getSqlParamMap("SUCCESS_OUP_CNT", "STRING"));
    	lstPrm.add(getSqlParamMap("FAIL_OUP_CNT", "STRING"));
    	lstPrm.add(getSqlParamMap("EXE_STATE", "STRING"));
    	lstPrm.add(getSqlParamMap("EXE_LOG", "STRING"));
    	lstPrm.add(getSqlParamMap("EXE_NUM", "STRING"));    	
    	lstPrm.add(getSqlParamMap("USR_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("PROJ_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("JOB_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_NUM", "INTEGER"));
    	
    	mapSql.put("PRM", lstPrm);
    	
    	return mapSql;    	
    }

    private Map<String,Object> updateDsExeApiJob(){
		Map<String,Object> mapSql =  new HashMap<String,Object>();
		
		StringBuilder sb = new StringBuilder();
		
		sb.append("update cbap$_exe_api_job");
		sb.append("   set exe_state = ?");
		sb.append("     , exe_log = ?");
		sb.append("     , end_time = SYSTIMESTAMP");
		sb.append(" where exe_num = ?");
		sb.append("   and usr_id = ?");
		sb.append("   and proj_id = ?");
		sb.append("   and job_id = ?");
		
    	// SQL 등록
    	mapSql.put("SQL", sb.toString());
    	
    	// SQL 파라미터정보 등록
    	List<HashMap<String,String>> lstPrm = new ArrayList<HashMap<String,String>>();
    	lstPrm.add(getSqlParamMap("EXE_STATE", "STRING"));
    	lstPrm.add(getSqlParamMap("EXE_LOG", "STRING"));
    	lstPrm.add(getSqlParamMap("EXE_NUM", "STRING"));    	
    	lstPrm.add(getSqlParamMap("USR_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("PROJ_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("JOB_ID", "STRING"));
    	
    	mapSql.put("PRM", lstPrm);
    	
    	return mapSql;    	
    }    

    
    
    ////////////////////////////////////////////////////

    private Map<String,Object> selectDsExeUrlVal(){
    	
    	Map<String,Object> mapSql =  new HashMap<String,Object>();
    	
    	StringBuilder sb = new StringBuilder();
    	
    	sb.append("select /*+ ordered */");
    	sb.append("       t0.src_val");
    	sb.append("     , t0.src_encode");
    	sb.append("     , t0.prm1_key, t0.prm1_typ, t0.prm1_val, t0.prm1_inc");
    	sb.append("     , t0.prm2_key, t0.prm2_typ, t0.prm2_val, t0.prm2_inc");
    	sb.append("     , t0.prm3_key, t0.prm3_typ, t0.prm3_val, t0.prm3_inc");
    	sb.append("     , t0.prm4_key, t0.prm4_typ, t0.prm4_val, t0.prm4_inc");
    	sb.append("     , t0.prm5_key, t0.prm5_typ, t0.prm5_val, t0.prm5_inc");
    	sb.append("     , nvl2(t1.item_key, t1.proj_id || '.' || t1.job_id || '.' || t1.src_id || '.' || t1.src_num || '.' || t1.tgt_id || '.' || t1.row_num || '.' || t1.item_key,'') as src_position");
    	sb.append("     , DECODE(t0.src_typ_cd, 'INPUT', t0.src_val,'OTHER',nvl(to_char(t4.oup_val),?) ,nvl(to_char(t1.item_val),?)) as url_val");
    	sb.append("     , nvl(to_char(t2.item_val),?) as loop_block_cnt_val");
    	sb.append("     , nvl(to_char(t3.item_val),?) as loop_cnt_val");
    	sb.append("  from cbap$_crw_src t0");
    	sb.append("     , cbap$_exe_crw_itm t1");
    	sb.append("     , cbap$_exe_crw_itm t2");
    	sb.append("     , cbap$_exe_crw_itm t3");
    	sb.append("     , cbap$_exe_api_oup t4");
    	sb.append(" where t0.usr_id  = ?");
    	sb.append("   and t0.proj_id = ?");
    	sb.append("   and t0.job_id  = ?");
    	sb.append("   and t0.src_id  = ?");
    	sb.append("   and t1.exe_num(+) = ?");
    	sb.append("   and t1.usr_id(+)  = t0.usr_id");
    	sb.append("   and t1.item_val_position(+) = ?");
    	sb.append("   and t2.exe_num(+) = ?");
    	sb.append("   and t2.usr_id(+)  = DECODE(?,'N',?,t1.usr_id)");
    	sb.append("   and t2.item_val_position(+) = ?");
    	sb.append("   and t2.src_num(+) = DECODE(?,'N',1,t1.src_num)");
    	sb.append("   and t2.row_num(+) = DECODE(?,'N',1,t1.row_num)");
    	sb.append("   and t3.exe_num(+) = ?");
    	sb.append("   and t3.usr_id(+)  = DECODE(?,'N',?,t1.usr_id)");
    	sb.append("   and t3.item_val_position(+) = ?");
    	sb.append("   and t3.src_num(+) = DECODE(?,'N',1,t1.src_num)");
    	sb.append("   and t3.row_num(+) = DECODE(?,'N',1,t1.row_num)");
    	sb.append("   and t4.exe_num(+) = ?");
    	sb.append("   and t4.usr_id(+)  = t0.usr_id");
    	sb.append("   and t4.oup_val_position(+) = ?");
    	sb.append(" order by t1.src_num, t1.row_num");
		
    	// SQL 등록
    	mapSql.put("SQL", sb.toString());
    	
    	// SQL 파라미터정보 등록
    	List<HashMap<String,String>> lstPrm = new ArrayList<HashMap<String,String>>();
    	lstPrm.add(getSqlParamMap("SRC_VAL", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_VAL", "STRING"));
    	lstPrm.add(getSqlParamMap("LOOP_BLOCK_CNT", "STRING"));
    	lstPrm.add(getSqlParamMap("LOOP_CNT", "STRING"));
    	lstPrm.add(getSqlParamMap("USR_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("PROJ_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("JOB_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("EXE_NUM", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_VAL", "STRING"));
    	lstPrm.add(getSqlParamMap("EXE_NUM", "STRING"));    	
    	lstPrm.add(getSqlParamMap("LOOP_BLOCK_CNT_AUTO", "STRING"));
		lstPrm.add(getSqlParamMap("USR_ID", "STRING"));
		lstPrm.add(getSqlParamMap("LOOP_BLOCK_CNT", "STRING"));
		lstPrm.add(getSqlParamMap("LOOP_BLOCK_CNT_AUTO", "STRING"));
		lstPrm.add(getSqlParamMap("LOOP_BLOCK_CNT_AUTO", "STRING"));
		lstPrm.add(getSqlParamMap("EXE_NUM", "STRING"));
		lstPrm.add(getSqlParamMap("LOOP_CNT_AUTO", "STRING"));
		lstPrm.add(getSqlParamMap("USR_ID", "STRING"));
		lstPrm.add(getSqlParamMap("LOOP_CNT", "STRING"));
		lstPrm.add(getSqlParamMap("LOOP_CNT_AUTO", "STRING"));
		lstPrm.add(getSqlParamMap("LOOP_CNT_AUTO", "STRING"));
		lstPrm.add(getSqlParamMap("EXE_NUM", "STRING"));
		lstPrm.add(getSqlParamMap("SRC_VAL", "STRING"));

    	mapSql.put("PRM", lstPrm);
    	
    	return mapSql;
    }
    
    private Map<String,Object> selectExeCrwExecuteYn(){
    	
    	Map<String,Object> mapSql =  new HashMap<String,Object>();
    	
    	StringBuilder sb = new StringBuilder();
    	
    	sb.append("select exe_state");
    	sb.append("     , nvl2(end_time,'Y','N') as end_yn");
    	sb.append("  from cbap$_exe_crw_job t");
    	sb.append(" where t.exe_num = ?");
    	sb.append("   and t.usr_id = ?");
    	sb.append("   and t.proj_id = ?");
    	sb.append("   and t.job_id in (:JOB_ID_LST)");
		
    	// SQL 등록
    	mapSql.put("SQL", sb.toString());
    	
    	// SQL 파라미터정보 등록
    	List<HashMap<String,String>> lstPrm = new ArrayList<HashMap<String,String>>();
    	lstPrm.add(getSqlParamMap("EXE_NUM", "STRING"));    	
		lstPrm.add(getSqlParamMap("USR_ID", "STRING"));
		lstPrm.add(getSqlParamMap("PROJ_ID", "STRING"));

    	mapSql.put("PRM", lstPrm);
    	
    	// SQL 파라미터정보 등록(동적쿼리)
    	List<HashMap<String,String>> lstPrl = new ArrayList<HashMap<String,String>>();
    	lstPrl.add(getSqlParamMap("JOB_ID_LST", ":JOB_ID_LST"));
    	mapSql.put("PRL", lstPrl);
    	
    	return mapSql;
    }
    
    private Map<String,Object> selectDsJobList(){
    	
    	Map<String,Object> mapSql =  new HashMap<String,Object>();
    	
    	StringBuilder sb = new StringBuilder();
    	
    	sb.append("select usr_id");
    	sb.append("     , proj_id");
    	sb.append("     , job_id");
    	sb.append("     , job_nm ");
    	sb.append("     , disp_ord ");
    	sb.append("  from cbap$_crw_job");
    	sb.append(" where usr_id = ?");
    	sb.append("   and proj_id = ?");
    	sb.append("   and job_id in (:JOB_ID_LST)");
    	sb.append(" order by disp_ord");
    	// SQL 등록
    	mapSql.put("SQL", sb.toString());
    	
    	// SQL 파라미터정보 등록
    	List<HashMap<String,String>> lstPrm = new ArrayList<HashMap<String,String>>();
		lstPrm.add(getSqlParamMap("USR_ID", "STRING"));
		lstPrm.add(getSqlParamMap("PROJ_ID", "STRING"));

    	mapSql.put("PRM", lstPrm);
    	
    	// SQL 파라미터정보 등록(동적쿼리)
    	List<HashMap<String,String>> lstPrl = new ArrayList<HashMap<String,String>>();
    	lstPrl.add(getSqlParamMap("JOB_ID_LST", ":JOB_ID_LST"));
    	mapSql.put("PRL", lstPrl);
    	
    	return mapSql;
    }

    private Map<String,Object> deleteDsExeJob(){
		Map<String,Object> mapSql =  new HashMap<String,Object>();
		
		StringBuilder sb = new StringBuilder();
		
		sb.append("delete from cbap$_exe_crw_job where exe_num = ? and usr_id = ? and proj_id = ? and job_id = ?");
		
    	// SQL 등록
    	mapSql.put("SQL", sb.toString());
    	
    	// SQL 파라미터정보 등록
    	List<HashMap<String,String>> lstPrm = new ArrayList<HashMap<String,String>>();
    	lstPrm.add(getSqlParamMap("EXE_NUM", "STRING"));    	
    	lstPrm.add(getSqlParamMap("USR_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("PROJ_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("JOB_ID", "STRING"));
    	
    	mapSql.put("PRM", lstPrm);
    	
    	return mapSql;    	
    }  

    private Map<String,Object> insertDsExeJob(){
		Map<String,Object> mapSql =  new HashMap<String,Object>();
		
		StringBuilder sb = new StringBuilder();
		
		sb.append("insert into cbap$_exe_crw_job (exe_num, usr_id, proj_id, job_id, exe_state, exe_log, str_time, rgst_id, rgst_dt) values");
		sb.append(" (?,?,?,?,?,?,SYSTIMESTAMP, ?, SYSDATE)");
		
    	// SQL 등록
    	mapSql.put("SQL", sb.toString());
    	
    	// SQL 파라미터정보 등록
    	List<HashMap<String,String>> lstPrm = new ArrayList<HashMap<String,String>>();
    	lstPrm.add(getSqlParamMap("EXE_NUM", "STRING"));    	
    	lstPrm.add(getSqlParamMap("USR_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("PROJ_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("JOB_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("EXE_STATE", "STRING"));
    	lstPrm.add(getSqlParamMap("EXE_LOG", "STRING"));
    	lstPrm.add(getSqlParamMap("USR_ID", "STRING"));
    	
    	mapSql.put("PRM", lstPrm);
    	
    	return mapSql;    	
    }  

    private Map<String,Object> selectDsSourceList(){
    	
    	Map<String,Object> mapSql =  new HashMap<String,Object>();
    	
    	StringBuilder sb = new StringBuilder();
    	
    	sb.append("select usr_id");
    	sb.append("     , proj_id, job_id, src_id, src_nm ");
    	sb.append("     , src_div_cd");
    	sb.append("     , src_typ_cd");
    	sb.append("     , src_encode");
    	sb.append("     , src_val");
    	sb.append("     , src_val_position");
    	sb.append("     , src_save_type");
    	sb.append("     , delay_time");
    	sb.append("     , loop_yn, loop_block_cnt, loop_block_cnt_auto, loop_cnt, loop_cnt_auto ");
    	sb.append("     , prm1_key, prm1_typ, prm1_val, prm1_inc ");
    	sb.append("     , prm2_key, prm2_typ, prm2_val, prm2_inc ");
    	sb.append("     , prm3_key, prm3_typ, prm3_val, prm3_inc ");
    	sb.append("     , prm4_key, prm4_typ, prm4_val, prm4_inc ");
    	sb.append("     , prm5_key, prm5_typ, prm5_val, prm5_inc ");
    	sb.append("     , disp_ord ");
    	sb.append("  from cbap$_crw_src ");
    	sb.append(" where usr_id = ?");
    	sb.append("   and proj_id = ?");
    	sb.append("   and job_id = ?");
    	sb.append(" order by disp_ord");

    	// SQL 등록
    	mapSql.put("SQL", sb.toString());
    	
    	// SQL 파라미터정보 등록
    	List<HashMap<String,String>> lstPrm = new ArrayList<HashMap<String,String>>();
		lstPrm.add(getSqlParamMap("USR_ID", "STRING"));
		lstPrm.add(getSqlParamMap("PROJ_ID", "STRING"));
		lstPrm.add(getSqlParamMap("JOB_ID", "STRING"));

    	mapSql.put("PRM", lstPrm);
    	
    	return mapSql;
    }
 
    private Map<String,Object> selectDsTargetList(){
    	
    	Map<String,Object> mapSql =  new HashMap<String,Object>();
    	
    	StringBuilder sb = new StringBuilder();
    	
    	sb.append("select usr_id");
    	sb.append("     , proj_id");
    	sb.append("     , job_id");
    	sb.append("     , src_id");
    	sb.append("     , tgt_id");
    	sb.append("     , tgt_nm");
    	sb.append("     , tgt_find_type");
    	sb.append("     , tgt_find_val");
    	sb.append("     , tgt_rep_val");
    	sb.append("     , tgt_save_type");
    	sb.append("     , tgt_save_val");
    	sb.append("     , disp_ord");
    	sb.append("  from cbap$_crw_tgt");
    	sb.append(" where usr_id = ?");
    	sb.append("   and proj_id = ?");
    	sb.append("   and job_id = ?");
    	sb.append("   and src_id = ?");
    	sb.append(" order by disp_ord");

    	// SQL 등록
    	mapSql.put("SQL", sb.toString());
    	
    	// SQL 파라미터정보 등록
    	List<HashMap<String,String>> lstPrm = new ArrayList<HashMap<String,String>>();
		lstPrm.add(getSqlParamMap("USR_ID", "STRING"));
		lstPrm.add(getSqlParamMap("PROJ_ID", "STRING"));
		lstPrm.add(getSqlParamMap("JOB_ID", "STRING"));
		lstPrm.add(getSqlParamMap("SRC_ID", "STRING"));

    	mapSql.put("PRM", lstPrm);
    	
    	return mapSql;
    }
    
    private Map<String,Object> deleteDsExeItemBySrc(){
		Map<String,Object> mapSql =  new HashMap<String,Object>();
		
		StringBuilder sb = new StringBuilder();
		
		sb.append("delete from cbap$_exe_crw_itm where exe_num = ? and usr_id = ? and proj_id = ? and job_id = ? and src_id = ?");
		
    	// SQL 등록
    	mapSql.put("SQL", sb.toString());
    	
    	// SQL 파라미터정보 등록
    	List<HashMap<String,String>> lstPrm = new ArrayList<HashMap<String,String>>();
    	lstPrm.add(getSqlParamMap("EXE_NUM", "STRING"));    	
    	lstPrm.add(getSqlParamMap("USR_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("PROJ_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("JOB_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_ID", "STRING"));
    	
    	mapSql.put("PRM", lstPrm);
    	
    	return mapSql;    	
    }  
 
    private Map<String,Object> deleteDsExeTgtBySrc(){
		Map<String,Object> mapSql =  new HashMap<String,Object>();
		
		StringBuilder sb = new StringBuilder();
		
		sb.append("delete from cbap$_exe_crw_tgt where exe_num = ? and usr_id = ? and proj_id = ? and job_id = ? and src_id = ?");
		
    	// SQL 등록
    	mapSql.put("SQL", sb.toString());
    	
    	// SQL 파라미터정보 등록
    	List<HashMap<String,String>> lstPrm = new ArrayList<HashMap<String,String>>();
    	lstPrm.add(getSqlParamMap("EXE_NUM", "STRING"));    	
    	lstPrm.add(getSqlParamMap("USR_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("PROJ_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("JOB_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_ID", "STRING"));
    	
    	mapSql.put("PRM", lstPrm);
    	
    	return mapSql;    	
    }      
    
    private Map<String,Object> deleteDsExeSrcBySrc(){
		Map<String,Object> mapSql =  new HashMap<String,Object>();
		
		StringBuilder sb = new StringBuilder();
		
		sb.append("delete from cbap$_exe_crw_src where exe_num = ? and usr_id = ? and proj_id = ? and job_id = ? and src_id = ?");
		
    	// SQL 등록
    	mapSql.put("SQL", sb.toString());
    	
    	// SQL 파라미터정보 등록
    	List<HashMap<String,String>> lstPrm = new ArrayList<HashMap<String,String>>();
    	lstPrm.add(getSqlParamMap("EXE_NUM", "STRING"));    	
    	lstPrm.add(getSqlParamMap("USR_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("PROJ_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("JOB_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_ID", "STRING"));
    	
    	mapSql.put("PRM", lstPrm);
    	
    	return mapSql;    	
    }
    
    private Map<String,Object> insertDsExeSrc(){
		Map<String,Object> mapSql =  new HashMap<String,Object>();
		
		StringBuilder sb = new StringBuilder();
		
		sb.append("insert into cbap$_exe_crw_src");
		sb.append(" (exe_num, usr_id, proj_id, job_id, src_id, src_num, src_url, src_position");
		sb.append(" , pos_proj_id, pos_job_id, pos_src_id, pos_src_num, pos_tgt_id, pos_row_num, pos_item_key, pos_page_no");
		sb.append(" , exe_state, exe_log, rgst_id, rgst_dt) values");
		sb.append(" ( ?, ?, ?, ?, ?, ?, ?, ?");
		sb.append(" , regexp_substr(?, '[^.]+', 1, 1), regexp_substr(?, '[^.]+', 1, 2), regexp_substr(?, '[^.]+', 1, 3)");
		sb.append(" , regexp_substr(?, '[^.]+', 1, 4), regexp_substr(?, '[^.]+', 1, 5), regexp_substr(?, '[^.]+', 1, 6)");
		sb.append(" , regexp_substr(?, '[^.]+', 1, 7), regexp_substr(?, '[^.]+', 1, 8)");
		sb.append(" , ?, ?, ?, SYSDATE )");
		
    	// SQL 등록
    	mapSql.put("SQL", sb.toString());
    	
    	// SQL 파라미터정보 등록
    	List<HashMap<String,String>> lstPrm = new ArrayList<HashMap<String,String>>();
    	lstPrm.add(getSqlParamMap("EXE_NUM", "STRING"));
    	lstPrm.add(getSqlParamMap("USR_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("PROJ_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("JOB_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_NUM", "INTEGER"));
    	lstPrm.add(getSqlParamMap("SRC_URL", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_POSITION", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_POSITION", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_POSITION", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_POSITION", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_POSITION", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_POSITION", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_POSITION", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_POSITION", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_POSITION", "STRING"));
    	lstPrm.add(getSqlParamMap("EXE_STATE", "STRING"));
    	lstPrm.add(getSqlParamMap("EXE_LOG", "STRING"));
    	lstPrm.add(getSqlParamMap("USR_ID", "STRING"));
    	
    	mapSql.put("PRM", lstPrm);
    	
    	return mapSql;    	
    }  
 
    private Map<String,Object> updateDsExeSrcStart(){
		Map<String,Object> mapSql =  new HashMap<String,Object>();
		
		StringBuilder sb = new StringBuilder();
		
		sb.append("update cbap$_exe_crw_src");
		sb.append("   set src_content = ?");
		sb.append("     , exe_state = ?");
		sb.append("     , exe_log = ?");
		sb.append("     , str_time = SYSTIMESTAMP");
		sb.append(" where exe_num = ?");
		sb.append("   and usr_id = ?");
		sb.append("   and proj_id = ?");
		sb.append("   and job_id = ?");
		sb.append("   and src_id = ?");
		sb.append("   and src_num = ?");
		
    	// SQL 등록
    	mapSql.put("SQL", sb.toString());
    	
    	// SQL 파라미터정보 등록
    	List<HashMap<String,String>> lstPrm = new ArrayList<HashMap<String,String>>();
    	lstPrm.add(getSqlParamMap("SRC_CONTENT", "CLOB"));
    	lstPrm.add(getSqlParamMap("EXE_STATE", "STRING"));
    	lstPrm.add(getSqlParamMap("EXE_LOG", "STRING"));    	
    	lstPrm.add(getSqlParamMap("EXE_NUM", "STRING"));
    	lstPrm.add(getSqlParamMap("USR_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("PROJ_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("JOB_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_NUM", "INTEGER"));
    	
    	mapSql.put("PRM", lstPrm);
    	
    	return mapSql;    	
    }  
 
    private Map<String,Object> insertDsExeTgt(){
		Map<String,Object> mapSql =  new HashMap<String,Object>();
		
		StringBuilder sb = new StringBuilder();
		
		sb.append("insert into cbap$_exe_crw_tgt (exe_num, usr_id, proj_id, job_id, src_id, src_num, tgt_id, tgt_save_val");
		sb.append(" , itm_cnt, exe_state, exe_log, str_time, rgst_id, rgst_dt) values");
		sb.append(" (?,?,?,?,?,?,?,?");
		sb.append(" ,0, ?,?,SYSTIMESTAMP, ?, SYSDATE)");
		
    	// SQL 등록
    	mapSql.put("SQL", sb.toString());
    	
    	// SQL 파라미터정보 등록
    	List<HashMap<String,String>> lstPrm = new ArrayList<HashMap<String,String>>();
    	lstPrm.add(getSqlParamMap("EXE_NUM", "STRING"));
    	lstPrm.add(getSqlParamMap("USR_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("PROJ_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("JOB_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_NUM", "INTEGER"));
    	lstPrm.add(getSqlParamMap("TGT_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("TGT_SAVE_VAL", "STRING"));
    	lstPrm.add(getSqlParamMap("EXE_STATE", "STRING"));
    	lstPrm.add(getSqlParamMap("EXE_LOG", "STRING"));
    	lstPrm.add(getSqlParamMap("USR_ID", "STRING"));
    	
    	mapSql.put("PRM", lstPrm);
    	
    	return mapSql;    	
    } 
    
    private Map<String,Object> insertDsExeItem(){
		Map<String,Object> mapSql =  new HashMap<String,Object>();
		
		StringBuilder sb = new StringBuilder();
		
		sb.append("insert into cbap$_exe_crw_itm (exe_num, usr_id, proj_id, job_id, src_id, src_num, tgt_id, row_num, item_key, item_nm, item_val, item_val_position");
		sb.append("	,exe_state, exe_log, exe_time, rgst_id, rgst_dt) values");
		sb.append(" (?,?,?,?,?,?,?,?,?,?,?,?||'.'||?||'.'||?||'.'||?||'.'||?");
		sb.append(" ,?,?,SYSTIMESTAMP, ?, SYSDATE)");
		
    	// SQL 등록
    	mapSql.put("SQL", sb.toString());
    	
    	// SQL 파라미터정보 등록
    	List<HashMap<String,String>> lstPrm = new ArrayList<HashMap<String,String>>();
    	lstPrm.add(getSqlParamMap("EXE_NUM", "STRING"));
    	lstPrm.add(getSqlParamMap("USR_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("PROJ_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("JOB_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_NUM", "INTEGER"));
    	lstPrm.add(getSqlParamMap("TGT_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("ROW_NUM", "INTEGER"));
    	lstPrm.add(getSqlParamMap("ITEM_KEY", "STRING"));
    	lstPrm.add(getSqlParamMap("ITEM_NM", "STRING"));
    	lstPrm.add(getSqlParamMap("ITEM_VAL", "CLOB"));
    	lstPrm.add(getSqlParamMap("PROJ_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("JOB_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("TGT_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("ITEM_KEY", "STRING"));    	
    	lstPrm.add(getSqlParamMap("EXE_STATE", "STRING"));
    	lstPrm.add(getSqlParamMap("EXE_LOG", "STRING"));
    	lstPrm.add(getSqlParamMap("USR_ID", "STRING"));
    	
    	mapSql.put("PRM", lstPrm);
    	
    	return mapSql;    	
    } 
    
    private Map<String,Object> updateDsExeTgt(){
		Map<String,Object> mapSql =  new HashMap<String,Object>();
		
		StringBuilder sb = new StringBuilder();
		
		sb.append("update cbap$_exe_crw_tgt");
		sb.append("   set itm_cnt = ?");
		sb.append("     , exe_state = ?");
		sb.append("     , exe_log = ?");
		sb.append("     , end_time = SYSTIMESTAMP");
		sb.append(" where exe_num = ?");
		sb.append("   and usr_id = ?");
		sb.append("   and proj_id = ?");
		sb.append("   and job_id = ?");
		sb.append("   and src_id = ?");
		sb.append("   and src_num = ?");
		sb.append("   and tgt_id = ?");
		
    	// SQL 등록
    	mapSql.put("SQL", sb.toString());
    	
    	// SQL 파라미터정보 등록
    	List<HashMap<String,String>> lstPrm = new ArrayList<HashMap<String,String>>();
    	lstPrm.add(getSqlParamMap("ITM_CNT", "STRING"));
    	lstPrm.add(getSqlParamMap("EXE_STATE", "STRING"));
    	lstPrm.add(getSqlParamMap("EXE_LOG", "STRING"));
    	lstPrm.add(getSqlParamMap("EXE_NUM", "STRING"));
    	lstPrm.add(getSqlParamMap("USR_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("PROJ_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("JOB_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_NUM", "INTEGER"));
    	lstPrm.add(getSqlParamMap("TGT_ID", "STRING"));
    	
    	mapSql.put("PRM", lstPrm);
    	
    	return mapSql;    	
    }    

    private Map<String,Object> updateDsExeSrcEnd(){
		Map<String,Object> mapSql =  new HashMap<String,Object>();
		
		StringBuilder sb = new StringBuilder();
		
		sb.append("update cbap$_exe_crw_src");
		sb.append("   set success_tgt_cnt = ?");
		sb.append("     , fail_tgt_cnt = ?");
		sb.append("     , exe_state = ?");
		sb.append("     , exe_log = ?");
		sb.append("     , end_time = SYSTIMESTAMP");
		sb.append(" where exe_num = ?");
		sb.append("   and usr_id = ?");
		sb.append("   and proj_id = ?");
		sb.append("   and job_id = ?");
		sb.append("   and src_id = ?");
		sb.append("   and src_num = ?");
		
    	// SQL 등록
    	mapSql.put("SQL", sb.toString());
    	
    	// SQL 파라미터정보 등록
    	List<HashMap<String,String>> lstPrm = new ArrayList<HashMap<String,String>>();
    	lstPrm.add(getSqlParamMap("SUCCESS_TGT_CNT", "STRING"));
    	lstPrm.add(getSqlParamMap("FAIL_TGT_CNT", "STRING"));
    	lstPrm.add(getSqlParamMap("EXE_STATE", "STRING"));
    	lstPrm.add(getSqlParamMap("EXE_LOG", "STRING"));
    	lstPrm.add(getSqlParamMap("EXE_NUM", "STRING"));
    	lstPrm.add(getSqlParamMap("USR_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("PROJ_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("JOB_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("SRC_NUM", "INTEGER"));
    	
    	mapSql.put("PRM", lstPrm);
    	
    	return mapSql;    	
    }

    private Map<String,Object> updateDsExeJob(){
		Map<String,Object> mapSql =  new HashMap<String,Object>();
		
		StringBuilder sb = new StringBuilder();
		
		sb.append("update cbap$_exe_crw_job");
		sb.append("   set exe_state = ?");
		sb.append("     , exe_log = ?");
		sb.append("     , end_time = SYSTIMESTAMP");
		sb.append(" where exe_num = ?");
		sb.append("   and usr_id = ?");
		sb.append("   and proj_id = ?");
		sb.append("   and job_id = ?");
		
    	// SQL 등록
    	mapSql.put("SQL", sb.toString());
    	
    	// SQL 파라미터정보 등록
    	List<HashMap<String,String>> lstPrm = new ArrayList<HashMap<String,String>>();
    	lstPrm.add(getSqlParamMap("EXE_STATE", "STRING"));
    	lstPrm.add(getSqlParamMap("EXE_LOG", "STRING"));
    	lstPrm.add(getSqlParamMap("EXE_NUM", "STRING"));
    	lstPrm.add(getSqlParamMap("USR_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("PROJ_ID", "STRING"));
    	lstPrm.add(getSqlParamMap("JOB_ID", "STRING"));
    	
    	mapSql.put("PRM", lstPrm);
    	
    	return mapSql;    	
    }
    
}