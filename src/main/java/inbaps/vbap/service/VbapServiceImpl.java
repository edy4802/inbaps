package inbaps.vbap.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import inbaps.vbap.dao.VbapDAO;

@Service("vbapService")
public class VbapServiceImpl implements VbapService{
	Logger log = Logger.getLogger(this.getClass());
	
    @Resource(name="vbapDAO")
    private VbapDAO vbapDAO;	

	@Override
	public List<Map<String, Object>> openVwMainSub01Data(Map<String, Object> map) throws Exception {
		return vbapDAO.openVwMainSub01Data(map);
	}
	
	@Override
	public List<Map<String, Object>> openVwMainSub01Link(Map<String, Object> map) throws Exception {
		return vbapDAO.openVwMainSub01Link(map);
	}	

}
