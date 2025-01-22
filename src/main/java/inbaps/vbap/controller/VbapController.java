package inbaps.vbap.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import inbaps.common.common.CommandMap;
import inbaps.vbap.service.VbapService;

@Controller
public class VbapController {
    Logger log = Logger.getLogger(this.getClass());

    @Resource(name="vbapService")
    private VbapService vbapService;
    
    /*
     * 아래의 순서로 코딩을 작성한다.
     * Controller -> Service -> ServiceImpl -> DAO -> SQL(XML) -> JSP
     */ 
    

    @RequestMapping(value="/visual/openVisualization.do")
    public ModelAndView openVisualization(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("/vw/vwMain");
         
        mv.addObject("menulink", "openVisualization");
        return mv;
    }
    
    @RequestMapping(value="/visual/openVwMainSub01.do")
    public ModelAndView openVwMainSub01(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("/vw/vwMainSub01");
        
        String dataId = "";
        /*
         * commandMap 파라미터 로그 확인
         */
        if(commandMap.isEmpty() == false){
        	
        	if(commandMap.containsKey("DATA_ID")) 
        	{
        		dataId = (String)commandMap.get("DATA_ID");
        	}
        }
        
        mv.addObject("menulink", "openVisualization");		
        mv.addObject("dataId", dataId);
        return mv;
    } 
    
    @RequestMapping(value="/visual/openVwMainSub01Data.do")
    public ModelAndView openVwMainSub01Data(CommandMap commandMap) throws Exception{
    	ModelAndView mv = new ModelAndView("jsonView");
        
		/*var data = {
			    "viewSet": {
			        "nodes": [
			            {"symbol": "가","size": 50,"id": 1,"bonds": 1},
			            {"symbol": "나","size": 30,"id": 2,"bonds": 1},
			            {"symbol": "다","size": 30,"id": 3,"bonds": 4},
			            {"symbol": "라","size": 30,"id": 4,"bonds": 4},
			            {"symbol": "마","size": 20,"id": 5,"bonds": 4},
			            {"symbol": "바","size": 20,"id": 6,"bonds": 4},
			            {"symbol": "사","size": 20,"id": 7,"bonds": 4}
			        ],
			        "links": [
			            {"source": 0,"target": 1,"id": "link1","bondType": 1},
			            {"source": 0,"target": 2,"id": "link2","bondType": 1},
			            {"source": 0,"target": 3,"id": "link3","bondType": 1},
			            {"source": 1,"target": 4,"id": "link4","bondType": 1},
			            {"source": 1,"target": 5,"id": "link5","bondType": 1},
			            {"source": 2,"target": 6,"id": "link6","bondType": 1}
			        ]
			    }
			};*/        	
    	
    	List<Map<String,Object>> nodes = vbapService.openVwMainSub01Data(commandMap.getMap());
    	
    	List<Map<String,Object>> links = vbapService.openVwMainSub01Link(commandMap.getMap());
    	
    	Map<String,Object> map = new HashMap<String,Object>();
    	map.put("nodes", nodes);
    	map.put("links", links);
        
        mv.addObject("viewSet", map);
        
        return mv;
    }
    
    @RequestMapping(value="/visual/openVwStep01.do")
    public ModelAndView openVwStep01(CommandMap commandMap) throws Exception{
        ModelAndView mv = new ModelAndView("/vw/vwStep01");
        
        mv.addObject("menulink", "openVwStep01");
        return mv;
    }   
}