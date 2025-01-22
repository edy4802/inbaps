package inbaps.rbap.controller;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import inbaps.cbap.service.CbapService;
import inbaps.common.common.CommandMap;

@Controller
public class RbapController {
    Logger log = Logger.getLogger(this.getClass());

    @Resource(name="cbapService")
    private CbapService cbapService;
    
    /*
     * 아래의 순서로 코딩을 작성한다.
     * Controller -> Service -> ServiceImpl -> DAO -> SQL(XML) -> JSP
     */ 
    
    @RequestMapping(value="/rstudio/openRStudio.do")
    public ModelAndView openRStudio(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("/rt/rtMain");
        
        mv.addObject("menulink", "openRStudio");
        return mv;
    }
    
    @RequestMapping(value="/rstudio/openRtStep01.do")
    public ModelAndView openRtStep01(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("/rt/rtStep01");
        
        mv.addObject("menulink", "openRtStep01");
        return mv;
    }   
}