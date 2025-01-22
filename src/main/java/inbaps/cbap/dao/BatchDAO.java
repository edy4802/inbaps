package inbaps.cbap.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import inbaps.common.dao.AbstractDAO;

@Repository("batchDAO")
public class BatchDAO extends AbstractDAO {
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectDsSourceList(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectPagingList("datasearch.selectDsSourceList", map);
	}	
	
	/* CBAP$_EXE_CRW_JOB CUD */
	public void deleteDsExeJob(Map<String, Object> map) throws Exception{
		update("datasearch.deleteDsExeJob", map);
	}
	public void insertDsExeJob(Map<String, Object> map) throws Exception{
		update("datasearch.insertDsExeJob", map);
	}
	public void updateDsExeJob(Map<String, Object> map) throws Exception{
		update("datasearch.updateDsExeJob", map);
	}	
}
