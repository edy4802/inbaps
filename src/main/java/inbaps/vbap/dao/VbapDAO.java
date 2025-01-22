package inbaps.vbap.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import inbaps.common.dao.AbstractDAO;

@Repository("vbapDAO")
public class VbapDAO extends AbstractDAO {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> openVwMainSub01Data(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectPagingList("visual.openVwMainSub01Data", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> openVwMainSub01Link(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectPagingList("visual.openVwMainSub01Link", map);
	}
}
