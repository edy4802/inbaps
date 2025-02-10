package inbaps.cbap.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import inbaps.cbap.dao.CbapDAO;
import inbaps.cbap.openapi.CommonOpenApi;
import inbaps.cbap.security.CustomUserDetails;
import inbaps.cbap.service.CbapService;
import inbaps.cbap.service.OpenapiService;
import inbaps.cbap.service.SpiderService;
import inbaps.cbap.spider.CommonSpider;
import inbaps.common.common.CommandMap;

@Controller
public class CbapController {
    Logger log = Logger.getLogger(this.getClass());

    @Resource(name="cbapService")
    private CbapService cbapService;
    
    @Resource(name="openapiService")
    private OpenapiService openapiService;
    
    @Resource(name="spiderService")
    private SpiderService spiderService;
    
    /*
     * 아래의 순서로 코딩을 작성한다.
     * Controller -> Service -> ServiceImpl -> DAO -> SQL(XML) -> JSP
     */ 
    
    @RequestMapping(value="/datasearch/login.do")
    public ModelAndView login(HttpSession session) throws Exception{
    	ModelAndView mv = new ModelAndView("/login");
        
    	log.info(String.format("Welcome login! {%s}", session.getId()));
    	
        return mv;
    }
    
    @RequestMapping(value="/datasearch/login_duplicate.do")
    public ModelAndView login_duplicate(HttpSession session) throws Exception{
    	ModelAndView mv = new ModelAndView("/login_duplicate");
        
    	log.info("Welcome login_duplicate!");
    	
        return mv;
    }      
    
    @RequestMapping(value="/datasearch/login_success.do")
    public ModelAndView login_success(HttpSession session) throws Exception{
    	ModelAndView mv = new ModelAndView("/main");
    	
    	CustomUserDetails userDetails = (CustomUserDetails)SecurityContextHolder.getContext().getAuthentication().getDetails();
        
    	log.info(String.format("Welcome login_success! {%s}, {%s}", session.getId(), userDetails.getUserId() + "/" + userDetails.getUserPw()));
    	
    	session.setAttribute("userLoginInfo", userDetails);
		
        return mv;
    } 

    @RequestMapping(value="/datasearch/logout.do")
    public ModelAndView logout(HttpSession session) throws Exception{
    	ModelAndView mv = new ModelAndView("/login");
    	
    	try{
        	CustomUserDetails userDetails = (CustomUserDetails)session.getAttribute("userLoginInfo");
        	
        	log.info(String.format("Welcome logout! {%s}, {%s}", session.getId(), userDetails.getUserId()));
        	
        	session.invalidate();
    		
    	}catch(Exception ex){
    		session.invalidate();
    	}
        
        return mv;
    }
    
    @RequestMapping(value="/datasearch/selectLogin.do")
    public ModelAndView selectLogin(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        List<Map<String,Object>> list = cbapService.selectLogin(commandMap.getMap());
        mv.addObject("rows", list);
        
        return mv;
    }
    
    @RequestMapping(value="/datasearch/openMain.do")
    public ModelAndView openMain(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("/main");
        
        mv.addObject("menulink", "openMain");
        return mv;
    }
    
    @RequestMapping(value="/datasearch/openLogin.do")
    public ModelAndView openLogin(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("/login");
        
        return mv;
    }    
    
    @RequestMapping(value="/datasearch/openDataSearch.do")
    public ModelAndView openDataSearch(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("/ds/dsMain");
        
        mv.addObject("menulink", "openDataSearch");
        return mv;
    }
    
    @RequestMapping(value="/datasearch/openDsStep01.do")
    public ModelAndView openDsStep01(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("/ds/dsStep01");
        
        mv.addObject("menulink", "openDsStep01");
        return mv;
    } 
    
    @RequestMapping(value="/datasearch/openDsStep02.do")
    public ModelAndView openDsStep02(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("/ds/dsStep02");
        
        mv.addObject("menulink", "openDsStep02");
        return mv;
    } 
    
    @RequestMapping(value="/datasearch/openDsStep03.do")
    public ModelAndView openDsStep03(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("/ds/dsStep03");
        
        mv.addObject("menulink", "openDsStep03");
        return mv;
    } 
    
    @RequestMapping(value="/datasearch/openDsStep04.do")
    public ModelAndView openDsStep04(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("/ds/dsStep04");
        
        mv.addObject("menulink", "openDsStep04");
        return mv;
    } 
    
    @RequestMapping(value="/datasearch/openDsStep05.do")
    public ModelAndView openDsStep05(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("/ds/dsStep05");
        
        mv.addObject("menulink", "openDsStep05");
        return mv;
    }
    
    @RequestMapping(value="/datasearch/openDsStep06.do")
    public ModelAndView openDsStep06(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("/ds/dsStep06");
        
        mv.addObject("menulink", "openDsStep06");
        return mv;
    }

    @RequestMapping(value="/datasearch/selectDsProjectList.do")
    public ModelAndView selectDsProjectList(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        /* 노페이징 리스트 처리 */
        List<Map<String,Object>> list = cbapService.selectDsProjectList(commandMap.getMap());
        mv.addObject("rows", list);
         
        return mv;
    } 

    @RequestMapping(value="/datasearch/insDsProjectInfo.do")
    public ModelAndView insDsProjectInfo(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        cbapService.insertDsProjectInfo(commandMap.getMap());
         
        return mv;
    } 
    
    @RequestMapping(value="/datasearch/delDsProjectInfo.do")
    public ModelAndView delDsProjectInfo(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        cbapService.deleteDsProjectInfo(commandMap.getMap());
         
        return mv;
    }     

    @RequestMapping(value="/datasearch/saveDsProjectInfo.do")
    public ModelAndView saveDsProjectInfo(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        cbapService.updateDsProjectInfo(commandMap.getMap());
         
        return mv;
    }  
    
    @RequestMapping(value="/datasearch/openDrawDatasetAPI.do")
    public ModelAndView openDrawDatasetAPI(CommandMap commandMap) throws Exception{
    	ModelAndView mv = new ModelAndView("jsonView");
    	Map<String,Object> map = commandMap.getMap();
    	String oupId = cbapService.selectOupId(map);
    	if(!oupId.equals("") || !oupId.equals(null)) {
    		map.put("OUP_ID", oupId);
    	}
    	List<Map<String,Object>> headerList = cbapService.selectOupKeyList(map);
    	map.put("OUP_KEYS", headerList);
    	
    	mv.addObject("headerList", headerList);
    	mv.addObject("data", cbapService.openDrawDatasetAPI(map));
    	return mv;
    }  
    
    @RequestMapping(value="/datasearch/selectDsJobList.do")
    public ModelAndView selectDsJobList(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        /* 노페이징 리스트 처리 */
        List<Map<String,Object>> list = spiderService.selectDsJobList(commandMap.getMap());
        mv.addObject("rows", list);
         
        return mv;
    }
    
    @RequestMapping(value="/datasearch/selectDsApiJobList.do")
    public ModelAndView selectDsApiJobList(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        /* 노페이징 리스트 처리 */
        List<Map<String,Object>> list = cbapService.selectDsApiJobList(commandMap.getMap());
        mv.addObject("rows", list);
         
        return mv;
    }
    
    @RequestMapping(value="/datasearch/insDsJobInfo.do")
    public ModelAndView insDsJobInfo(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        cbapService.insertDsJobInfo(commandMap.getMap());
         
        return mv;
    }  
    
    @RequestMapping(value="/datasearch/insDsApiJobInfo.do")
    public ModelAndView insDsApiJobInfo(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        cbapService.insertDsApiJobInfo(commandMap.getMap());
         
        return mv;
    }  
    
    @RequestMapping(value="/datasearch/delDsJobInfo.do")
    public ModelAndView delDsJobInfo(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        cbapService.deleteDsJobInfo(commandMap.getMap());
         
        return mv;
    }

    @RequestMapping(value="/datasearch/delDsApiJobInfo.do")
    public ModelAndView delDsApiJobInfo(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        cbapService.deleteDsApiJobInfo(commandMap.getMap());
         
        return mv;
    }
    
    @RequestMapping(value="/datasearch/saveDsJobInfo.do")
    public ModelAndView saveDsJobInfo(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        cbapService.updateDsJobInfo(commandMap.getMap());
         
        return mv;
    }   
    
    @RequestMapping(value="/datasearch/saveDsApiJobInfo.do")
    public ModelAndView saveDsApiJobInfo(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        cbapService.updateDsApiJobInfo(commandMap.getMap());
         
        return mv;
    }     

    
    @RequestMapping(value="/datasearch/selectDsSourceList.do")
    public ModelAndView selectDsSourceList(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        /* 노페이징 리스트 처리 */
        List<Map<String,Object>> list = spiderService.selectDsSourceList(commandMap.getMap());
        mv.addObject("rows", list);
         
        return mv;
    } 
    
    @RequestMapping(value="/datasearch/selectDsApiSourceList.do")
    public ModelAndView selectDsApiSourceList(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        /* 노페이징 리스트 처리 */
        List<Map<String,Object>> list = openapiService.selectDsApiSourceList(commandMap.getMap());
        mv.addObject("rows", list);
         
        return mv;
    } 
    
    @RequestMapping(value="/datasearch/insDsSourceInfo.do")
    public ModelAndView insDsSourceInfo(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        cbapService.insertDsSourceInfo(commandMap.getMap());
         
        return mv;
    }  
    
    @RequestMapping(value="/datasearch/insDsApiSourceInfo.do")
    public ModelAndView insDsApiSourceInfo(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        cbapService.insertDsApiSourceInfo(commandMap.getMap());
         
        return mv;
    }    
    
    @RequestMapping(value="/datasearch/delDsSourceInfo.do")
    public ModelAndView delDsSourceInfo(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        cbapService.deleteDsSourceInfo(commandMap.getMap());
         
        return mv;
    }    
    
    @RequestMapping(value="/datasearch/delDsApiSourceInfo.do")
    public ModelAndView delDsApiSourceInfo(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        cbapService.deleteDsApiSourceInfo(commandMap.getMap());
         
        return mv;
    }    
    
    @RequestMapping(value="/datasearch/saveDsSourceInfo.do")
    public ModelAndView saveDsSourceInfo(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        cbapService.updateDsSourceInfo(commandMap.getMap());
         
        return mv;
    }     
    
    @RequestMapping(value="/datasearch/saveDsApiSourceInfo.do")
    public ModelAndView saveDsApiSourceInfo(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        cbapService.updateDsApiSourceInfo(commandMap.getMap());
         
        return mv;
    }    
    
    @RequestMapping(value="/datasearch/selectDsTargetList.do")
    public ModelAndView selectDsTargetList(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        /* 노페이징 리스트 처리 */
        List<Map<String,Object>> list = spiderService.selectDsTargetList(commandMap.getMap());
        mv.addObject("rows", list);
         
        return mv;
    }
    
    @RequestMapping(value="/datasearch/selectDsApiInputList.do")
    public ModelAndView selectDsApiInputList(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        /* 노페이징 리스트 처리 */
        List<Map<String,Object>> list = openapiService.selectDsApiInputList(commandMap.getMap());
        mv.addObject("rows", list);
         
        return mv;
    }
    
    @RequestMapping(value="/datasearch/selectDsApiOutputList.do")
    public ModelAndView selectDsApiOutputList(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        /* 노페이징 리스트 처리 */
        List<Map<String,Object>> list = openapiService.selectDsApiOutputList(commandMap.getMap());
        mv.addObject("rows", list);
         
        return mv;
    }
    
    @RequestMapping(value="/datasearch/insDsTargetInfo.do")
    public ModelAndView insDsTargetInfo(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        cbapService.insertDsTargetInfo(commandMap.getMap());
         
        return mv;
    }  
    
    @RequestMapping(value="/datasearch/insDsApiInputInfo.do")
    public ModelAndView insDsApiInputInfo(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        cbapService.insertDsApiInputInfo(commandMap.getMap());
         
        return mv;
    }
    
    @RequestMapping(value="/datasearch/insDsApiOutputInfo.do")
    public ModelAndView insDsApiOutputInfo(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        cbapService.insertDsApiOutputInfo(commandMap.getMap());
         
        return mv;
    }
    
    @RequestMapping(value="/datasearch/delDsTargetInfo.do")
    public ModelAndView delDsTargetInfo(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        cbapService.deleteDsTargetInfo(commandMap.getMap());
         
        return mv;
    }    
    
    @RequestMapping(value="/datasearch/delDsApiInputInfo.do")
    public ModelAndView delDsApiInputInfo(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        cbapService.deleteDsApiInputInfo(commandMap.getMap());
         
        return mv;
    } 
    
    @RequestMapping(value="/datasearch/delDsApiOutputInfo.do")
    public ModelAndView delDsApiOutputInfo(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        cbapService.deleteDsApiOutputInfo(commandMap.getMap());
         
        return mv;
    } 
    
    @RequestMapping(value="/datasearch/saveDsTargetInfo.do")
    public ModelAndView saveDsTargetInfo(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        cbapService.updateDsTargetInfo(commandMap.getMap());
         
        return mv;
    }     
    
    @RequestMapping(value="/datasearch/saveDsApiInputInfo.do")
    public ModelAndView saveDsApiInputInfo(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        cbapService.updateDsApiInputInfo(commandMap.getMap());
         
        return mv;
    }

    @RequestMapping(value="/datasearch/saveDsApiOutputInfo.do")
    public ModelAndView saveDsApiOutputInfo(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        cbapService.updateDsApiOutputInfo(commandMap.getMap());
         
        return mv;
    }    
    
    @RequestMapping(value="/datasearch/selectDsExeItemVal.do")
    public ModelAndView selectDsExeItemVal(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        List<Map<String,Object>> list = cbapService.selectDsExeItemVal(commandMap.getMap());
        mv.addObject("rows", list);
         
        return mv;
    }
    
    @RequestMapping(value="/datasearch/selectDsExeItemValForApi.do")
    public ModelAndView selectDsExeItemValForApi(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        List<Map<String,Object>> list = cbapService.selectDsExeItemValForApi(commandMap.getMap());
        mv.addObject("rows", list);
         
        return mv;
    }
    
    @RequestMapping(value="/datasearch/selectDsExeApiItemVal.do")
    public ModelAndView selectDsExeApiItemVal(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        List<Map<String,Object>> list = cbapService.selectDsExeApiItemVal(commandMap.getMap());
        mv.addObject("rows", list);
         
        return mv;
    }    
    
    @RequestMapping(value="/datasearch/selectDsRegexView.do")
    public ModelAndView selectDsRegexView(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        List<Map<String,Object>> list = cbapService.selectDsRegexView(commandMap.getMap());
        mv.addObject("rows", list);
         
        return mv;
    } 
    
    
    @RequestMapping(value="/datasearch/goUrl.do")
    public ModelAndView goUrl(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        String url = "";
        String srcEncode = "";
        String srcSaveType = "";
        
        if(commandMap.isEmpty() == false){
            Iterator<Entry<String,Object>> iterator = commandMap.getMap().entrySet().iterator();
            Entry<String,Object> entry = null;
            
            while(iterator.hasNext()){
                entry = iterator.next();
                if("URL".equals(entry.getKey())){url = "" + entry.getValue();}
                if("SRC_ENCODE".equals(entry.getKey())){srcEncode = "" + entry.getValue();}
                if("SRC_SAVE_TYPE".equals(entry.getKey())){srcSaveType = "" + entry.getValue();}
                log.debug("key : "+entry.getKey()+", value : "+entry.getValue());
            }
        }
        
        //url =  URLDecoder.decode(url, "UTF-8");
        
        CommonSpider cSpider = new CommonSpider();        
        cSpider.setUrl(url);
        cSpider.setContent("");
        cSpider.setSrcEncode(srcEncode);
        cSpider.setSrcSaveType(srcSaveType);
        cSpider.sendGet();
        mv.addObject("result", cSpider.getContent());
         
        return mv;
    }  
    
    @SuppressWarnings("unchecked")
	@RequestMapping(value="/datasearch/runApi.do")
    public ModelAndView runApi(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        String url = "";
        String method = "";
        String outFormat = "";
        String xmlPrefix = "";
        String xmlNamespaceuri = "";
        String urlParam = "";
        /*
         * commandMap 파라미터 로그 확인
         */
        if(commandMap.isEmpty() == false){
        	
        	if(commandMap.containsKey("URL")) 
        	{
	        	url = (String)commandMap.get("URL");
        	}
        	if(commandMap.containsKey("URL_PARAM")) 
        	{
        		urlParam = (String)commandMap.get("URL_PARAM");
        	}
        	if(commandMap.containsKey("METHOD")) 
        	{
	        	method = (String)commandMap.get("METHOD");
        	}
        	if(commandMap.containsKey("OUT_FMT")) 
        	{
        		outFormat = (String)commandMap.get("OUT_FMT");
        	}
        	if(commandMap.containsKey("XML_PREFIX")) 
        	{
        		xmlPrefix = (String)commandMap.get("XML_PREFIX");
        	}
        	if(commandMap.containsKey("XML_NAMESPACEURI")) 
        	{
        		xmlNamespaceuri = (String)commandMap.get("XML_NAMESPACEURI");
        	}
        }
        
        Map<String,Object> mapUrlParam = new HashMap<String,Object>();
        Map<String,Object> mapReqParam = new HashMap<String,Object>();
        
        // 설정하기 화면에서는 파라미터로 받고, 수집하기에서는 DB에서 읽어와야 한다.
        String[] arrUrlParam = urlParam.split("&");
        for(int i=0; i<arrUrlParam.length; i++){
        	String[] arrKey = arrUrlParam[i].split("=");
        	mapUrlParam.put(arrKey[0], arrKey[1]);
        }
        
        List<Map<String,Object>> lstSrc = cbapService.selectDsApiInputRequestList(commandMap.getMap());
        String inpKey = "";
        String inpVal = "";
        for(Map<String, Object> srcMap : lstSrc){
        	if(srcMap.containsKey("INP_KEY")) 
        	{
        		inpKey = (String)srcMap.get("INP_KEY");
        	}else{
        		inpKey = "";
        	}
        	if(srcMap.containsKey("INP_VAL")) 
        	{
        		inpVal = (String)srcMap.get("INP_VAL");
        	}else{
        		inpVal = "";
        	}
        	mapReqParam.put(inpKey, inpVal);
        }        
        
        CommonOpenApi cOpenApi = new CommonOpenApi();        
        cOpenApi.setUrl(url);
        cOpenApi.setMethod(method);
        cOpenApi.setFormat(outFormat);
        cOpenApi.setUrlParam(mapUrlParam);
        cOpenApi.setRequestParam(mapReqParam);
        
        cOpenApi.sendRequest();
        
        Map<String,Object> xmlNode = new HashMap<String,Object>();
        List<Map<String,Object>> itemRoot = null;
        List<Map<String,Object>> itemList = null;
        
        List<Map<String,Object>> lstOup = openapiService.selectDsApiOutputList(commandMap.getMap());
        xmlNode = cOpenApi.getXmlNode(lstOup, xmlPrefix, xmlNamespaceuri);
        if(xmlNode.containsKey("ROOT")) 
    	{
        	itemRoot = (List<Map<String, Object>>) xmlNode.get("ROOT");
    	}
        if(xmlNode.containsKey("LIST")) 
    	{
        	itemList = (List<Map<String,Object>>)xmlNode.get("LIST");
    	}
		
        mv.addObject("result", cOpenApi.getContent());
        mv.addObject("itemRoot", itemRoot);
        mv.addObject("itemList", itemList);
         
        return mv;
    }    
    
    @RequestMapping(value="/datasearch/runRegex.do")
    public ModelAndView runRegex(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        String url = "";
        String content = "";
        String regex = "";
        String replaceRegex = "";
        String tgtFindType = "";
        String disptype = "";
        String tgtSaveVal = "";
        /*
         * commandMap 파라미터 로그 확인
         */
        if(commandMap.isEmpty() == false){
        	
        	if(commandMap.containsKey("URL")) 
        	{
	        	url = (String)commandMap.get("URL");
        	}
        	
        	if(commandMap.containsKey("CONTENT")) 
        	{
	        	content = (String)commandMap.get("CONTENT");
        	}
        	
        	if(commandMap.containsKey("REGEX")) 
        	{
	        	regex = (String)commandMap.get("REGEX");
        	}
        	
        	if(commandMap.containsKey("REPLACEREGEX"))
        	{
	        	replaceRegex = (String)commandMap.get("REPLACEREGEX");
        	}
        	
        	if(commandMap.containsKey("TGT_FIND_TYPE"))
        	{
        		tgtFindType = (String)commandMap.get("TGT_FIND_TYPE");
        	}
        	
        	if(commandMap.containsKey("DISPTYPE"))
        	{
        		disptype = (String)commandMap.get("DISPTYPE");
        	}
        	if(commandMap.containsKey("TGT_SAVE_VAL"))
        	{
        		tgtSaveVal = (String)commandMap.get("TGT_SAVE_VAL");
        	}
        }
        
        CommonSpider cSpider = new CommonSpider(); 
        cSpider.setUrl(url);
        cSpider.setContent(content);
        cSpider.setRegex(regex);
        cSpider.setReplaceRegex(replaceRegex);
        cSpider.setTgtFindType(tgtFindType);
        cSpider.setDisptype(disptype);
        cSpider.setTgtSaveVal(tgtSaveVal);
        List<Map<String, Object>> list = cSpider.getRegexMap();
        mv.addObject("result", list);
         
        return mv;
    } 
    
    
    @RequestMapping(value="/datasearch/runRegexSave.do")
    public ModelAndView runRegexSave(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
		String usrId = "";
		String projId = "";
		String jobId = "";
		String srcId = "";
		String tgtId = "";
		String url = "";
        String content = "";
        String regex = "";
        String replaceRegex = "";
        String tgtFindType = "";
        String tgtSaveVal = "";
        /*
         * commandMap 파라미터 로그 확인
         */
        if(commandMap.isEmpty() == false){
        	
        	if(commandMap.containsKey("USR_ID")) 
        	{
	        	usrId = (String)commandMap.get("USR_ID");
        	}
        	if(commandMap.containsKey("PROJ_ID")) 
        	{
        		projId = (String)commandMap.get("PROJ_ID");
        	}
        	if(commandMap.containsKey("JOB_ID")) 
        	{
	        	jobId = (String)commandMap.get("JOB_ID");
        	}
        	if(commandMap.containsKey("SRC_ID")) 
        	{
	        	srcId = (String)commandMap.get("SRC_ID");
        	}
        	if(commandMap.containsKey("TGT_ID")) 
        	{
	        	tgtId = (String)commandMap.get("TGT_ID");
        	}
        	
        	if(commandMap.containsKey("URL")) 
        	{
	        	url = (String)commandMap.get("URL");
        	}
        	
        	if(commandMap.containsKey("CONTENT")) 
        	{
	        	content = (String)commandMap.get("CONTENT");
        	}
        	
        	if(commandMap.containsKey("REGEX")) 
        	{
	        	regex = (String)commandMap.get("REGEX");
        	}
        	
        	if(commandMap.containsKey("REPLACEREGEX"))
        	{
	        	replaceRegex = (String)commandMap.get("REPLACEREGEX");
        	}
        	if(commandMap.containsKey("TGT_FIND_TYPE"))
        	{
        		tgtFindType = (String)commandMap.get("TGT_FIND_TYPE");
        	}
        	if(commandMap.containsKey("TGT_SAVE_VAL"))
        	{
        		tgtSaveVal = (String)commandMap.get("TGT_SAVE_VAL");
        	}
        }
        
        /* 기존에 저장된 동일한 조건의 실행결과가 존재하면 삭제한다. */
        Map<String, Object> delItem;
        delItem = new HashMap<String,Object>();
        
        delItem.put("EXE_NUM",0);
        delItem.put("USR_ID",usrId);
        delItem.put("PROJ_ID",projId);
        delItem.put("JOB_ID",jobId);
        delItem.put("SRC_ID",srcId);
        delItem.put("TGT_ID",tgtId);
        
        spiderService.deleteDsExeItemByTgt(delItem);        
        
        CommonSpider cSpider = new CommonSpider();
        cSpider.setUrl(url);
        cSpider.setContent(content);
        cSpider.setRegex(regex);
        cSpider.setReplaceRegex(replaceRegex);
        cSpider.setTgtFindType(tgtFindType);
        cSpider.setTgtSaveVal(tgtSaveVal);
        cSpider.setDisptype("MCH_GNM");
        List<Map<String, Object>> list = cSpider.getRegexMap();
        mv.addObject("result", list);
        
        Map<String, Object> item;
        
        int rowNum = 0;
        for(Map<String, Object> map : list) {
        	rowNum ++;
        	for( String key : map.keySet() ){
                log.debug("key=" + key + ",value=" + map.get(key));
                
                item = new HashMap<String,Object>();
                
                item.put("EXE_NUM",0);
                item.put("USR_ID",usrId);
                item.put("PROJ_ID",projId);
                item.put("JOB_ID",jobId);
                item.put("SRC_ID",srcId);
                item.put("SRC_NUM",1);
                item.put("TGT_ID",tgtId);
                item.put("ROW_NUM",rowNum);                
                item.put("ITEM_KEY",key);
                item.put("ITEM_NM",key);
                item.put("ITEM_VAL",map.get(key));
                item.put("EXE_STATE","S02");
                item.put("EXE_LOG","");
                
                spiderService.insertDsExeItem(item);
            } 
        }
         
        return mv;
    }     
    
    @RequestMapping(value="/datasearch/selectDsSrcTgtList.do")
    public ModelAndView selectDsSrcTgtList(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        List<Map<String,Object>> list = cbapService.selectDsSrcTgtList(commandMap.getMap());
        mv.addObject("rows", list);
         
        return mv;
    } 
    

    @RequestMapping(value="/datasearch/selectCrawlingState.do")
    public ModelAndView selectCrawlingState(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        List<Map<String,Object>> list = cbapService.selectDsSrcTgtList(commandMap.getMap());
        mv.addObject("rows", list);
        
        return mv;
    }  
    
    @RequestMapping(value="/datasearch/selectDsTempJobList.do")
    public ModelAndView selectDsTempJobList(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        List<Map<String,Object>> list = cbapService.selectDsTempJobList(commandMap.getMap());
        mv.addObject("rows", list);
        
        return mv;
    }
    
    @RequestMapping(value="/datasearch/selectDsTempApiInpValList.do")
    public ModelAndView selectDsTempApiInpValList(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        List<Map<String,Object>> list = cbapService.selectDsTempApiInpValList(commandMap.getMap());
        mv.addObject("rows", list);
        
        return mv;
    } 
    
    @RequestMapping(value="/datasearch/selectDsTempApiJobList.do")
    public ModelAndView selectDsTempApiJobList(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        List<Map<String,Object>> list = cbapService.selectDsTempApiJobList(commandMap.getMap());
        mv.addObject("rows", list);
        
        return mv;
    } 
    
    @RequestMapping(value="/datasearch/selectDsTempApiSrcList.do")
    public ModelAndView selectDsTempApiSrcList(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        List<Map<String,Object>> list = cbapService.selectDsTempApiSrcList(commandMap.getMap());
        mv.addObject("rows", list);
        
        return mv;
    }
    
    @RequestMapping(value="/datasearch/applyDsTempJob.do")
    public ModelAndView applyDsTempJob(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        cbapService.applyDsTempJob(commandMap.getMap());
         
        return mv;
    }
    
    @RequestMapping(value="/datasearch/applyDsTempApiJob.do")
    public ModelAndView applyDsTempApiJob(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        cbapService.applyDsTempApiJob(commandMap.getMap());
         
        return mv;
    }

    @RequestMapping(value="/datasearch/applyDsTempApiSrc.do")
    public ModelAndView applyDsTempApiSrc(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        cbapService.applyDsTempApiSrc(commandMap.getMap());
         
        return mv;
    }
    
    @RequestMapping(value="/datasearch/selectDsReport1.do")
    public ModelAndView selectDsReport1(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        List<Map<String,Object>> list = cbapService.selectDsReport1(commandMap.getMap());
        mv.addObject("rows", list);
        
        return mv;
    }
    
    @RequestMapping(value="/datasearch/selectDsReport2.do")
    public ModelAndView selectDsReport2(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        List<Map<String,Object>> list = cbapService.selectDsReport1(commandMap.getMap());
        mv.addObject("rows", list);
        
        return mv;
    }
    
    @RequestMapping(value="/datasearch/selectDsReport3.do")
    public ModelAndView selectDsReport3(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        List<Map<String,Object>> list = cbapService.selectDsReport1(commandMap.getMap());
        mv.addObject("rows", list);
        
        return mv;
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
    
    private void deleteDsExeJob(Map<String, Object> map) throws Exception{
        
        //cbapService.deleteDsExeJob(map);
 
    }     

    /* map get test */
    private void mapGetTest(CommandMap commandMap){
        Map<String, Object> map = commandMap.getMap();
         
        // 방법1
        Iterator<String> keys = map.keySet().iterator();
        while( keys.hasNext() ){
            String key = keys.next();
            System.out.println( String.format("키 : %s, 값 : %s", key, map.get(key)) );
        }
         
        // 방법2
        for( Map.Entry<String, Object> elem : map.entrySet() ){
            System.out.println( String.format("키 : %s, 값 : %s", elem.getKey(), elem.getValue()) );
        }
         
        // 방법3
        for( String key : map.keySet() ){
            System.out.println( String.format("키 : %s, 값 : %s", key, map.get(key)) );
        }    	
    }
    
    @SuppressWarnings("unchecked")
	@RequestMapping(value="/datasearch/runApiSave.do")
    public ModelAndView runApiSave(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        String usrId = "";
		String projId = "";
		String jobId = "";
		String srcId = "";
        String url = "";
        String method = "";
        String outFormat = "";
        String xmlPrefix = "";
        String xmlNamespaceuri = "";
        String urlParam = "";
        /*
         * commandMap 파라미터 로그 확인
         */
        if(commandMap.isEmpty() == false){
        	if(commandMap.containsKey("USR_ID")) 
        	{
	        	usrId = (String)commandMap.get("USR_ID");
        	}
        	if(commandMap.containsKey("PROJ_ID")) 
        	{
        		projId = (String)commandMap.get("PROJ_ID");
        	}
        	if(commandMap.containsKey("JOB_ID")) 
        	{
	        	jobId = (String)commandMap.get("JOB_ID");
        	}
        	if(commandMap.containsKey("SRC_ID")) 
        	{
	        	srcId = (String)commandMap.get("SRC_ID");
        	}
        	if(commandMap.containsKey("URL")) 
        	{
	        	url = (String)commandMap.get("URL");
        	}
        	if(commandMap.containsKey("URL_PARAM")) 
        	{
        		urlParam = (String)commandMap.get("URL_PARAM");
        	}
        	if(commandMap.containsKey("METHOD")) 
        	{
	        	method = (String)commandMap.get("METHOD");
        	}
        	if(commandMap.containsKey("OUT_FMT")) 
        	{
        		outFormat = (String)commandMap.get("OUT_FMT");
        	}
        	if(commandMap.containsKey("XML_PREFIX")) 
        	{
        		xmlPrefix = (String)commandMap.get("XML_PREFIX");
        	}
        	if(commandMap.containsKey("XML_NAMESPACEURI")) 
        	{
        		xmlNamespaceuri = (String)commandMap.get("XML_NAMESPACEURI");
        	}
        }
        
        Map<String,Object> mapUrlParam = new HashMap<String,Object>();
        Map<String,Object> mapReqParam = new HashMap<String,Object>();
        
        // 설정하기 화면에서는 파라미터로 받고, 수집하기에서는 DB에서 읽어와야 한다.
        String[] arrUrlParam = urlParam.split("&");
        for(int i=0; i<arrUrlParam.length; i++){
//        	String[] arrKey = arrUrlParam[i].split("=");
//        	mapUrlParam.put(arrKey[0], arrKey[1]);
        	
//        	apiKey에 =문자 포함시 위 작업에서 삭제가 되어 인증키 에러가 발생
//        	아래 방식으로 수정 예정
        	int idx = arrUrlParam[i].indexOf("=");
        	String arrKey1 = arrUrlParam[i].substring(0, idx);
        	String arrKey2 = arrUrlParam[i].substring(idx + 1);
        	mapUrlParam.put(arrKey1, arrKey2);
        }
        
        // 이 부분을 쿼리로 바꿀것.
        
        List<Map<String,Object>> lstSrc = cbapService.selectDsApiInputRequestList(commandMap.getMap());
        String inpKey = "";
        String inpVal = "";
        for(Map<String, Object> srcMap : lstSrc){
        	if(srcMap.containsKey("INP_KEY")) 
        	{
        		inpKey = (String)srcMap.get("INP_KEY");
        	}else{
        		inpKey = "";
        	}
        	if(srcMap.containsKey("INP_VAL")) 
        	{
        		inpVal = (String)srcMap.get("INP_VAL");
        	}else{
        		inpVal = "";
        	}
        	mapReqParam.put(inpKey, inpVal);
        }
        
        /* 기존에 저장된 동일한 조건의 실행결과가 존재하면 삭제한다. */
        Map<String, Object> delItem;
        delItem = new HashMap<String,Object>();
        
        delItem.put("EXE_NUM",0);
        delItem.put("USR_ID",usrId);
        delItem.put("PROJ_ID",projId);
        delItem.put("JOB_ID",jobId);
        delItem.put("SRC_ID",srcId);
        
        openapiService.deleteDsExeApiItemBySrc(delItem);
        
        CommonOpenApi cOpenApi = new CommonOpenApi();        
        cOpenApi.setUrl(url);
        cOpenApi.setMethod(method);
        cOpenApi.setFormat(outFormat);
        cOpenApi.setUrlParam(mapUrlParam);
        cOpenApi.setRequestParam(mapReqParam);
        
        cOpenApi.sendRequest();
        
        Map<String, Object> itemAll = new HashMap<String,Object>();
        
        itemAll.put("EXE_NUM",0);
        itemAll.put("USR_ID",usrId);
        itemAll.put("PROJ_ID",projId);
        itemAll.put("JOB_ID",jobId);
        itemAll.put("SRC_ID",srcId);
        itemAll.put("SRC_NUM",1);
        itemAll.put("OUP_ID","O00000");
        itemAll.put("ROW_NUM",0);                
        itemAll.put("OUP_KEY",outFormat);
        itemAll.put("OUP_VAL",cOpenApi.getContent());
        itemAll.put("EXE_STATE","S02");
        itemAll.put("EXE_LOG","");
        
        openapiService.insertDsExeApiItem(itemAll);
        
        Map<String,Object> xmlNode = new HashMap<String,Object>();
        List<Map<String,Object>> itemRoot = null;
        List<Map<String,Object>> itemList = null;
        
        List<Map<String,Object>> lstOup = openapiService.selectDsApiOutputList(commandMap.getMap());
        xmlNode = cOpenApi.getXmlNode(lstOup, xmlPrefix, xmlNamespaceuri);
        String rootOupId = "";
        String listOupId = "";
        
        if(xmlNode.containsKey("ROOT")) 
    	{
        	itemRoot = (List<Map<String, Object>>) xmlNode.get("ROOT");
    	}
        if(xmlNode.containsKey("LIST")) 
    	{
        	itemList = (List<Map<String,Object>>)xmlNode.get("LIST");
    	}
        if(xmlNode.containsKey("ROOT_OUP_ID")){
        	rootOupId= (String)xmlNode.get("ROOT_OUP_ID");
        }
        if(xmlNode.containsKey("LIST_OUP_ID")){
        	listOupId= (String)xmlNode.get("LIST_OUP_ID");
        }
        
        List<Map<String,Object>> lstRoot = new ArrayList<Map<String,Object>>();        
        Map<String, Object> item = null;
        
        if(itemRoot != null){
	        for(Map<String, Object> node : itemRoot){        	
				for( String key : node.keySet() ){				
			        item = new HashMap<String,Object>();
			        
			        item.put("EXE_NUM",0);
			        item.put("USR_ID",usrId);
			        item.put("PROJ_ID",projId);
			        item.put("JOB_ID",jobId);
			        item.put("SRC_ID",srcId);
			        item.put("SRC_NUM",1);
			        item.put("OUP_ID",rootOupId);
			        item.put("ROW_NUM",0);                
			        item.put("OUP_KEY",key);
			        item.put("OUP_VAL",(node.get(key)==null)?"":node.get(key));
			        item.put("EXE_STATE","S02");
			        item.put("EXE_LOG","");
			        lstRoot.add(item);		        
	            } 
	        }
        }
        
        //lstItem
        if(lstRoot.size()>0){
	        Map<String, Object> rootIns = new HashMap<String,Object>();
	        rootIns.put("list", lstRoot);
	        openapiService.insertDsExeApiItemFor(rootIns);
        }
        
        List<Map<String,Object>> lstItem = new ArrayList<Map<String,Object>>();
        int iRowNum=0;
        if(itemList!= null)
        {
	        for(Map<String, Object> node : itemList){
				iRowNum++;
				for( String key : node.keySet() ){
					item = new HashMap<String,Object>();
			        
			        item.put("EXE_NUM",0);
			        item.put("USR_ID",usrId);
			        item.put("PROJ_ID",projId);
			        item.put("JOB_ID",jobId);
			        item.put("SRC_ID",srcId);
			        item.put("SRC_NUM",1);
			        item.put("OUP_ID",listOupId);
			        item.put("ROW_NUM",iRowNum);                
			        item.put("OUP_KEY",key);
			        item.put("OUP_VAL",(node.get(key)==null)?"":node.get(key));
			        item.put("EXE_STATE","S02");
			        item.put("EXE_LOG","");
			        
			        lstItem.add(item);
	            } 
	        }
        }
        
        if(lstItem.size()>0){
	        Map<String, Object> listIns = new HashMap<String,Object>();
	        listIns.put("list", lstItem);
	        openapiService.insertDsExeApiItemFor(listIns);
        }
         
        mv.addObject("result", cOpenApi.getContent());
        mv.addObject("itemRoot", itemRoot);
        mv.addObject("itemList", itemList);
        
        return mv;
    } 

    @RequestMapping(value="/datasearch/selectDsExeApiResultList.do")
    public ModelAndView selectDsExeApiResultList(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        List<Map<String,Object>> list = openapiService.selectDsExeApiResultList(commandMap.getMap());
        mv.addObject("rows", list);
         
        return mv;
    }
    
    /*
     * 배치예약 관련
     */
    
    @RequestMapping(value="/datasearch/selectDsBatResultList.do")
    public ModelAndView selectDsBatResultList(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        List<Map<String,Object>> list = cbapService.selectDsBatResultList(commandMap.getMap());
        mv.addObject("rows", list);
         
        return mv;
    }
    
    @RequestMapping(value="/datasearch/selectDsBatJobList.do")
    public ModelAndView selectDsBatJobList(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        /* 노페이징 리스트 처리 */
        List<Map<String,Object>> list = cbapService.selectDsBatJobList(commandMap.getMap());
        mv.addObject("rows", list);
         
        return mv;
    } 

    @RequestMapping(value="/datasearch/insDsBatJobInfo.do")
    public ModelAndView insDsBatJobInfo(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        cbapService.insDsBatJobInfo(commandMap.getMap());
         
        return mv;
    } 
    
    @RequestMapping(value="/datasearch/delDsBatJobInfo.do")
    public ModelAndView delDsBatJobInfo(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        cbapService.delDsBatJobInfo(commandMap.getMap());
         
        return mv;
    }     

    @RequestMapping(value="/datasearch/saveDsBatJobInfo.do")
    public ModelAndView saveDsBatJobInfo(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        cbapService.saveDsBatJobInfo(commandMap.getMap());
         
        return mv;
    }  
    
    @RequestMapping(value="/datasearch/selectDsBatJobPrmList.do")
    public ModelAndView selectDsBatJobPrmList(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        /* 노페이징 리스트 처리 */
        List<Map<String,Object>> list = cbapService.selectDsBatJobPrmList(commandMap.getMap());
        mv.addObject("rows", list);
         
        return mv;
    }
    
    @RequestMapping(value="/datasearch/insDsBatJobPrmInfo.do")
    public ModelAndView insDsBatJobPrmInfo(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        cbapService.insDsBatJobPrmInfo(commandMap.getMap());
         
        return mv;
    } 
    
    @RequestMapping(value="/datasearch/delDsBatJobPrmInfo.do")
    public ModelAndView delDsBatJobPrmInfo(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        cbapService.delDsBatJobPrmInfo(commandMap.getMap());
         
        return mv;
    }
    
    @RequestMapping(value="/datasearch/saveDsBatJobPrmInfo.do")
    public ModelAndView saveDsBatJobPrmInfo(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        cbapService.saveDsBatJobPrmInfo(commandMap.getMap());
         
        return mv;
    } 
    
    /*■■■■■■■■■■■■ 작업일:20170606 작업자:신한별 작업내용: 수집결과 미리보기.st ■■■■■■■■■■■■*/
    @RequestMapping(value="/datasearch/selectDScrwPreview.do")
    public ModelAndView selectDScrwPreview(CommandMap commandMap) throws Exception{
    	ModelAndView mv = new ModelAndView("jsonView");
    	
    	List<Map<String, Object>> list =  cbapService.selectDScrwPreview(commandMap.getMap());
    	mv.addObject("rows", list);
    	
    	return mv;
    }
    @RequestMapping(value="/datasearch/selectDScrwImgPreview.do")
    public ModelAndView selectDScrwImgPreview(CommandMap commandMap) throws Exception{
    	ModelAndView mv = new ModelAndView("jsonView");
    	
    	String imagePath =  cbapService.selectDScrwImgPreview(commandMap.getMap());
    	mv.addObject("IMG_PATH", imagePath);
    	
    	return mv;
    }
    /*■■■■■■■■■■■■ 작업일:20170606 작업자:신한별 작업내용: 수집결과 미리보기.ed ■■■■■■■■■■■■*/

/*
 * 아래는 예제 소스임
 * 
 */
        
    @RequestMapping(value="/datasearch/selectBoardList.do")
    public ModelAndView selectDsBoardList(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        /* 페이징 리스트 처리 */
        List<Map<String,Object>> list = cbapService.selectBoardList(commandMap.getMap());
        mv.addObject("rows", list);
        if(list.size() > 0){
            mv.addObject("records", list.get(0).get("TOTAL_COUNT"));
        }
        else{
            mv.addObject("records", 0);
        }
        mv.addObject("page", 10);
        mv.addObject("total", 8);
        
        
/*        Map<String,Object> resultMap = sampleService.selectBoardList(commandMap.getMap());        
        mv.addObject("paginationInfo", (PaginationInfo)resultMap.get("paginationInfo"));
        mv.addObject("list", resultMap.get("result"));*/
        
        /* 노페이징 리스트 처리 */
/*        List<Map<String,Object>> list = sampleService.selectBoardList(commandMap);
        mv.addObject("list", list);*/
         
        return mv;
    }  
}