package inbaps.cbap.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import inbaps.cbap.dao.BatchDAO;


@Service("batchService")
public class BatchServiceImpl implements BatchService{
	Logger log = Logger.getLogger(this.getClass());
	
    @Resource(name="batchDAO")
    private BatchDAO batchDAO;	
    
    /* CRAWLING 관련 SELECT 쿼리 */
	@Override
	public List<Map<String, Object>> selectDsSourceList(Map<String, Object> map) throws Exception {
		return batchDAO.selectDsSourceList(map);
	}
	
	/* CBAP$_EXE_CRW_JOB CUD */
	@Override
	public void deleteDsExeJob(Map<String, Object> map) throws Exception {
		batchDAO.deleteDsExeJob(map);
	}

	@Override
	public void insertDsExeJob(Map<String, Object> map) throws Exception {
		batchDAO.insertDsExeJob(map);
	}
	
	@Override
	public void updateDsExeJob(Map<String, Object> map) throws Exception {
		batchDAO.updateDsExeJob(map);
	}
	
}
