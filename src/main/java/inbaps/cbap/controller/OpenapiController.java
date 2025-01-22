package inbaps.cbap.controller;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import inbaps.cbap.openapi.CommonOpenApi;
import inbaps.cbap.service.OpenapiService;
import inbaps.common.common.CommandMap;

@Controller
public class OpenapiController {
    Logger log = Logger.getLogger(this.getClass());
    
    @Resource(name="openapiService")
    private OpenapiService openapiService;
    
    /*
     * 아래의 순서로 코딩을 작성한다.
     * Controller -> Service -> ServiceImpl -> DAO -> SQL(XML) -> JSP
     */ 
    @RequestMapping(value="/cbap/openapi/startApi.do")
    public ModelAndView startApi(CommandMap commandMap) throws Exception{
    	ModelAndView mv = new ModelAndView("jsonView");
    	
    	Map<String, Object> map = commandMap.getMap();
        
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
		List<Map<String,Object>> jobExe = openapiService.selectExeApiExecuteYn(map);
        
        String jobEndYn = "";
        for(Map<String, Object> jobMap : jobExe){
        	if(jobMap.containsKey("END_YN")) 
        	{
        		jobEndYn = String.valueOf(jobMap.get("END_YN"));
        		if("N".equals(jobEndYn)){
        			mv.addObject("state", "Processing");
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
        openapiService.deleteDsExeApiJob(delExeJobMap);	  
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
        openapiService.insertDsExeApiJob(insExeJobMap);
        
        /* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
    	/* SOURCE LIST
    	/* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
        // 현재는 SRC_ID 파라미터가 존재하므로 한개의 SOURCE 를 반환함.
        List<Map<String,Object>> lstSrc = openapiService.selectDsApiSourceList(map);
        
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
            
            List<Map<String,Object>> lstInReq = openapiService.selectDsApiInputList(map);
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
            	if(prmDlm.isEmpty()){
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
            		if("URL".equals(inpType.toUpperCase()) && "FIX_MULT".equals(prmType.toUpperCase())){
        				// FIX_MULT 값의 키값 (전체 항목중에 최대 한개만 가능)
            			inpKeyMulti = inpKey;
            			arrInpVal = inpVal.split(prmDlm);
            			if("UTF8".equals(inpEncode.toUpperCase())){
	            			for(int j=0; j<arrInpVal.length; j++){
	            				arrInpVal[j] = java.net.URLEncoder.encode(arrInpVal[j],"UTF-8");	
	            			}
            			}
            		}
            		else if("URL".equals(inpType.toUpperCase()) && "DB_MULT".equals(prmType.toUpperCase())){
            			inpKeyMulti = inpKey;
            			Map<String, Object> selInpValMap = new HashMap<String,Object>();        
            			selInpValMap.put("USR_ID",usrId);
            			selInpValMap.put("INP_COND",inpVal);
                    	
                    	List<Map<String,Object>> lstInpVal = openapiService.selectDsApiInpValList(selInpValMap);
                    	int jj=0;
                    	if(lstInpVal.size()>0){
                    		arrInpVal = new String[lstInpVal.size()];
	                    	for(Map<String, Object> mapInpVal : lstInpVal) {
	                    		arrInpVal[jj] = (mapInpVal.get("INP_VAL")==null)?"":String.valueOf(mapInpVal.get("INP_VAL"));
	                    		jj++;
	                		}
                    	}
                    	if("UTF8".equals(inpEncode.toUpperCase())){
	            			for(int j=0; j<arrInpVal.length; j++){
	            				arrInpVal[j] = java.net.URLEncoder.encode(arrInpVal[j],"UTF-8");	
	            			}
            			}
            		}else{
	            		if("UTF8".equals(inpEncode.toUpperCase())){
	            			inpVal = java.net.URLEncoder.encode(inpVal,"UTF-8");
	            		}
            		}
            	}

            	if(reqMap.containsKey("STR_NUM")) 
            	{
            		strNum = reqMap.get("STR_NUM").toString();
            	}else{
            		strNum = "";
            	}
            	if(reqMap.containsKey("INC_NUM")) 
            	{
            		incNum = reqMap.get("INC_NUM").toString();
            	}else{
            		incNum = "";
            	}
            	
            	if("REQ".equals(inpType.toUpperCase())){
            		mapReqParam.put(inpKey, inpVal);
            	}else if("URL".equals(inpType.toUpperCase())){
            		mapUrlParam.put(inpKey, inpVal);
            		if("ADJ_LOOP".equals(prmType.toUpperCase())){
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
            openapiService.deleteDsExeApiItemBySrc(delExeItmMap);
            
            /* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
        	/* EXE INPUT DELETE
        	/* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
            Map<String, Object> delExeInpMap = new HashMap<String,Object>();        
            delExeInpMap.put("EXE_NUM",exeNum);
            delExeInpMap.put("USR_ID",usrId);
            delExeInpMap.put("PROJ_ID",projId);
            delExeInpMap.put("JOB_ID",jobId);
            delExeInpMap.put("SRC_ID",srcId);
            openapiService.deleteDsExeApiInpBySrc(delExeInpMap);
            
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
            openapiService.deleteDsExeApiSrcBySrc(delExeSrcMap);
            
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
            
            Map<String, Object> jsonMap = null;
            
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
	                openapiService.insertDsExeApiSrc(insExeSrcMap);
	                
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
        	                openapiService.insertDsExeApiInp(insExeInpMap);
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
	                itemAll.put("OUP_KEY",outFormat);
	                itemAll.put("OUP_VAL",cOpenApi.getContent());
	                itemAll.put("EXE_STATE","S02");
	                itemAll.put("EXE_LOG","");            
	                openapiService.insertDsExeApiItem(itemAll);
	        		
	        		xmlNode = new HashMap<String,Object>();
	        		jsonMap = new HashMap<String,Object>();
	                
	        		List<Map<String,Object>> lstOup = openapiService.selectDsApiOutputList(map);
	        		if(outFormat.equals("XML")) {
	        			xmlNode = cOpenApi.getXmlNode(lstOup, xmlPrefix , xmlNamespaceuri);
		                log.debug("xmlNode : " + xmlNode);
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
		                
		                lstRoot = new ArrayList<Map<String,Object>>();
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
			        		        
			        		        lstRoot.add(item);
			                    } 
			                }
			                if(lstRoot.size()>0){
				                rootIns = new HashMap<String,Object>();
				                rootIns.put("list", lstRoot);
				                openapiService.insertDsExeApiItemFor(rootIns);
			                }
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
			        		        
			        		        lstItem.add(item);
			                    } 
			                }
			                if(lstItem.size()>0){
				                itemIns = new HashMap<String,Object>();
				                itemIns.put("list", lstItem);
				                openapiService.insertDsExeApiItemFor(itemIns);
			                }
		        		}
	        		} else if(outFormat.equals("JSON")) {
	        			jsonMap = cOpenApi.getJsonNode(lstOup);
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
	                openapiService.updateDsExeApiSrcEnd(updExeSrc2Map);  
	                
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
        openapiService.updateDsExeApiJob(updExeJobMap);        
        
        mv.addObject("state", "Completed");
    	
    	return mv;
    }    
    
    @RequestMapping(value="/cbap/openapi/stopApi.do")
    public ModelAndView stopApi(CommandMap commandMap) throws Exception{
    	ModelAndView mv = new ModelAndView("jsonView");
    	
    	Map<String, Object> map = commandMap.getMap();
    	
        /* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
    	/* 현재 실행중 상태이면 작업중지
    	/* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */		
		openapiService.updateDsExeApiJobStop(map);		
		openapiService.updateDsExeApiSrcStop(map);
		
		mv.addObject("state", "Completed");
    	
    	return mv;
    }

}