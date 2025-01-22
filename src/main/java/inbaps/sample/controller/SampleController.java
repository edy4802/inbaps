package inbaps.sample.controller;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import inbaps.common.common.CommandMap;
import inbaps.sample.service.SampleService;

@Controller
public class SampleController {
    Logger log = Logger.getLogger(this.getClass());

    @Resource(name="sampleService")
    private SampleService sampleService;
    
    /*
     * 아래의 순서로 코딩을 작성한다.
     * Controller -> Service -> ServiceImpl -> DAO -> SQL(XML) -> JSP
     */

    @RequestMapping(value="/sample/openMain.do")
    public ModelAndView openMain(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("/main");
         
        return mv;
    }
    
    @RequestMapping(value="/sample/openDsStep01.do")
    public ModelAndView openDsStep01(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("/ds/dsStep01");
         
        return mv;
    }    
    
    @RequestMapping(value="/sample/openDataSearch.do")
    public ModelAndView openDataSearch(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("/ds/dsMain");
         
        return mv;
    }
    
    @RequestMapping(value="/sample/openRStudio.do")
    public ModelAndView openRStudio(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("/rt/rtMain");
         
        return mv;
    }

    @RequestMapping(value="/sample/openVisualization.do")
    public ModelAndView openVisualization(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("/vw/vwMain");
         
        return mv;
    }
    
    @RequestMapping(value="/sample/openBoardList.do")
    public ModelAndView openSampleBoardList(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("/sample/boardList");
        
        /* 페이징 리스트 처리 */
/*        Map<String,Object> resultMap = sampleService.selectBoardList(commandMap.getMap());        
        mv.addObject("paginationInfo", (PaginationInfo)resultMap.get("paginationInfo"));
        mv.addObject("list", resultMap.get("result"));*/
        
        /* 노페이징 리스트 처리 */
/*        List<Map<String,Object>> list = sampleService.selectBoardList(commandMap);
        mv.addObject("list", list);*/
         
        return mv;
    }
    
    @RequestMapping(value="/sample/selectBoardList.do")
    public ModelAndView selectSampleBoardList(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("jsonView");
        
        /* 페이징 리스트 처리 */
        List<Map<String,Object>> list = sampleService.selectBoardList(commandMap.getMap());
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
    
    @RequestMapping(value="/sample/testMapArgumentResolver.do")
    public ModelAndView testMapArgumentResolver(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("");
         
        if(commandMap.isEmpty() == false){
            Iterator<Entry<String,Object>> iterator = commandMap.getMap().entrySet().iterator();
            Entry<String,Object> entry = null;
            while(iterator.hasNext()){
                entry = iterator.next();
                log.debug("key : "+entry.getKey()+", value : "+entry.getValue());
            }
        }
        return mv;
    }    
    
    @RequestMapping(value="/sample/openBoardWrite.do")
    public ModelAndView openBoardWrite(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("/sample/boardWrite");
         
        return mv;
    }
    
    @RequestMapping(value="/sample/insertBoard.do")
    public ModelAndView insertBoard(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("redirect:/sample/openBoardList.do");
         
        sampleService.insertBoard(commandMap.getMap());
         
        return mv;
    }
    
    @RequestMapping(value="/sample/openBoardDetail.do")
    public ModelAndView openBoardDetail(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("/sample/boardDetail");
         
        Map<String,Object> map = sampleService.selectBoardDetail(commandMap.getMap());
        mv.addObject("map", map);
         
        return mv;
    }
    
    @RequestMapping(value="/sample/openBoardUpdate.do")
    public ModelAndView openBoardUpdate(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("/sample/boardUpdate");
         
        Map<String,Object> map = sampleService.selectBoardDetail(commandMap.getMap());
        mv.addObject("map", map);
         
        return mv;
    }
     
    @RequestMapping(value="/sample/updateBoard.do")
    public ModelAndView updateBoard(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("redirect:/sample/openBoardDetail.do");
         
        sampleService.updateBoard(commandMap.getMap());
         
        mv.addObject("IDX", commandMap.get("IDX"));
        return mv;
    }
    
    @RequestMapping(value="/sample/deleteBoard.do")
    public ModelAndView deleteBoard(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("redirect:/sample/openBoardList.do");
         
        sampleService.deleteBoard(commandMap.getMap());
         
        return mv;
    }    
}