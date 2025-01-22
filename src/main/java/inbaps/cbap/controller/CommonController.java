package inbaps.cbap.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import inbaps.cbap.service.CbapService;
import inbaps.common.common.CommandMap;

@Controller
public class CommonController {
    Logger log = Logger.getLogger(this.getClass());

    @Resource(name="cbapService")
    private CbapService cbapService;
    
    /*
     * 아래의 순서로 코딩을 작성한다.
     * Controller -> Service -> ServiceImpl -> DAO -> SQL(XML) -> JSP
     */ 
    
    @RequestMapping(value="/datasearch/goPage.do")
    public ModelAndView goPage(CommandMap commandMap) throws Exception{
    	String page = "";
    	String menulink = "";
		if(commandMap.isEmpty() == false){		        	
        	if(commandMap.containsKey("PAGE")) 
        	{
        		page = (String)commandMap.get("PAGE");
        	}
        	if(commandMap.containsKey("MENULINK")) 
        	{
        		menulink = (String)commandMap.get("MENULINK");
        	}
	    }
    	ModelAndView mv = new ModelAndView(page);
    	
    	if(menulink != ""){
    		mv.addObject("menulink", menulink);
    	}
    	
        return mv;
    }
    
    @RequestMapping(value="/datasearch/selectJsonView.do")
    public ModelAndView selectLogin(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        // 아래 Service -> ServiceImpl -> DAO 까지 공통 메소드를 작성하고 맨 마지막 SQL(XML) 부문만 파라미터 분기한다.
        List<Map<String,Object>> list = cbapService.selectLogin(commandMap.getMap());
        mv.addObject("rows", list);
        
        return mv;
    }

    @RequestMapping(value="/datasearch/transJsonView.do")
    public ModelAndView insDsProjectInfo(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        // 아래 Service -> ServiceImpl -> DAO 까지 공통 메소드를 작성하고 맨 마지막 SQL(XML) 부문만 파라미터 분기한다.
        cbapService.insertDsProjectInfo(commandMap.getMap());
         
        return mv;
    }
    
    @RequestMapping(value="/datasearch/getImage.do")
    public ModelAndView getImage(CommandMap commandMap){
		ModelAndView mv = new ModelAndView("/common/image");
    	
		mv.addObject("img", commandMap.get("IMG"));
		
    	return mv;
    }
    
}