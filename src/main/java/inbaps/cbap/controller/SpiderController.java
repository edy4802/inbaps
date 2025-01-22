package inbaps.cbap.controller;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import inbaps.cbap.service.SpiderService;
import inbaps.cbap.spider.CommonSpider;
import inbaps.common.common.CommandMap;

@Controller
public class SpiderController {
    Logger log = Logger.getLogger(this.getClass());

    @Resource(name="spiderService")
    private SpiderService spiderService;
    
    /*
     * 아래의 순서로 코딩을 작성한다.
     * Controller -> Service -> ServiceImpl -> DAO -> SQL(XML) -> JSP
     */ 
    @RequestMapping(value="/cbap/spider/startCrawling.do")
    public ModelAndView startCrawling(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
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
		
		Map<String, Object> map = commandMap.getMap();
		
		/* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
    	/* 현재 실행중 상태이면 작업중지
    	/* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */		
		List<Map<String,Object>> jobExe = spiderService.selectExeCrwExecuteYn(map);
        
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
        }
        
        List<Map<String,Object>> lstJob = spiderService.selectDsJobList(map);
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
            spiderService.deleteDsExeJob(delExeJobMap);	  
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
            spiderService.insertDsExeJob(insExeJobMap);
            
            /* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
        	/* SOURCE LIST
        	/* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
            List<Map<String,Object>> lstSrc = spiderService.selectDsSourceList(map);
            
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
            	List<Map<String,Object>> lstTgt = spiderService.selectDsTargetList(srcMap);            

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
            	spiderService.deleteDsExeItemBySrc(delExeItmMap);
            	
                /* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
            	/* EXE TARGET DELETE
            	/* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
                Map<String, Object> delExeTgtMap = new HashMap<String,Object>();        
                delExeTgtMap.put("EXE_NUM",exeNum);
                delExeTgtMap.put("USR_ID",usrId);
                delExeTgtMap.put("PROJ_ID",projId);
                delExeTgtMap.put("JOB_ID",jobId);
                delExeTgtMap.put("SRC_ID",srcId);
                spiderService.deleteDsExeTgtBySrc(delExeTgtMap);
            	
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
            	spiderService.deleteDsExeSrcBySrc(delExeSrcMap);
            	
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
    	        	spiderService.insertDsExeSrc(insExeSrcMap); 	
                }      
                
                iSrcNum = 0;
                for(Map<String, Object> urlMap : lstUrl){
                	iSrcNum++;
                	
//                	log.debug("SRC_POSITION:" + urlMap.get("SRC_POSITION"));
//    				log.debug("EXE_URL:" + urlMap.get("EXE_URL"));
                	
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
    	            spiderService.updateDsExeSrcStart(updExeSrcMap);	            
    	            
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
    	            	spiderService.insertDsExeTgt(insExeTgtMap);	        	            	
    	            	
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
    		                    spiderService.insertDsExeItem(item);
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
    		            spiderService.updateDsExeTgt(updExeTgtMap);	
    	                
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
    	            spiderService.updateDsExeSrcEnd(updExeSrc2Map);
                    
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
            spiderService.updateDsExeJob(updExeJobMap);        
        }
        
        mv.addObject("state", "Completed");
        return mv;
    }     
    

    
    @RequestMapping(value="/cbap/spider/stopCrawling.do")
    public ModelAndView stopCrawling(CommandMap commandMap) throws Exception{
    	ModelAndView mv = new ModelAndView("jsonView");
        Map<String, Object> map = commandMap.getMap();
		
        /* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */
    	/* 현재 실행중 상태이면 작업중지
    	/* ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ */		
        spiderService.updateDsExeJobStop(map);		
        spiderService.updateDsExeSrcStop(map);
		
    	mv.addObject("state", "Completed");
    	return mv;
    }

    
    private List<Map<String,Object>> getSourceContent(Map<String, Object> map) throws Exception{
    	List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();
    	
    	log.debug("==========getSourceContent()===========" );
    	for( Map.Entry<String, Object> elem : map.entrySet() ){
            log.debug(String.format("키 : %s, 값 : %s", elem.getKey(), elem.getValue()) );
        }
    	
		// SRC_ID 별 대상 URL 및 LOOP_BLOCK_CNT, LOOP_CNT 값을 반환
		List<Map<String,Object>> lstUrl = spiderService.selectDsExeUrlVal(map);
		
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
}