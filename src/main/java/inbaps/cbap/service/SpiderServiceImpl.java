package inbaps.cbap.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import inbaps.cbap.dao.SpiderDAO;


@Service("spiderService")
public class SpiderServiceImpl implements SpiderService{
	Logger log = Logger.getLogger(this.getClass());
	
    @Resource(name="spiderDAO")
    private SpiderDAO spiderDAO;	
    
    /* CRAWLING 관련 SELECT 쿼리 */
	@Override
	public List<Map<String, Object>> selectDsSourceList(Map<String, Object> map) throws Exception {
		return spiderDAO.selectDsSourceList(map);
	}
	@Override
	public List<Map<String, Object>> selectDsTargetList(Map<String, Object> map) throws Exception {
		return spiderDAO.selectDsTargetList(map);
	}
	@Override
	public List<Map<String, Object>> selectDsExeUrlVal(Map<String, Object> map) throws Exception {
		return spiderDAO.selectDsExeUrlVal(map);
	}
	@Override
	public List<Map<String, Object>> selectDsJobList(Map<String, Object> map) throws Exception {
		return spiderDAO.selectDsJobList(map);
	}    
	
	@Override
	public List<Map<String, Object>> selectExeCrwExecuteYn(Map<String, Object> map) throws Exception {
		return spiderDAO.selectExeCrwExecuteYn(map);
	}
	
	/* CBAP$_EXE_CRW_JOB CUD */
	@Override
	public void deleteDsExeJob(Map<String, Object> map) throws Exception {
		spiderDAO.deleteDsExeJob(map);
	}

	@Override
	public void insertDsExeJob(Map<String, Object> map) throws Exception {
		spiderDAO.insertDsExeJob(map);
	}
	
	@Override
	public void updateDsExeJob(Map<String, Object> map) throws Exception {
		spiderDAO.updateDsExeJob(map);
	}	
	
	@Override
	public void updateDsExeJobStop(Map<String, Object> map) throws Exception {
		spiderDAO.updateDsExeJobStop(map);
	}
	
	/* CBAP$_EXE_CRW_SRC CUD */
	@Override
	public void deleteDsExeSrcByJob(Map<String, Object> map) throws Exception {
		spiderDAO.deleteDsExeSrcByJob(map);
	}

	@Override
	public void deleteDsExeSrcBySrc(Map<String, Object> map) throws Exception {
		spiderDAO.deleteDsExeSrcBySrc(map);
	}
	
	@Override
	public void deleteDsExeSrcBySrcNum(Map<String, Object> map) throws Exception {
		spiderDAO.deleteDsExeSrcBySrcNum(map);
	}
	
	@Override
	public void insertDsExeSrc(Map<String, Object> map) throws Exception {
		spiderDAO.insertDsExeSrc(map);
	}

	@Override
	public void updateDsExeSrcStart(Map<String, Object> map) throws Exception {
		spiderDAO.updateDsExeSrcStart(map);
	}

	@Override
	public void updateDsExeSrcEnd(Map<String, Object> map) throws Exception {
		spiderDAO.updateDsExeSrcEnd(map);
	}
	
	@Override
	public void updateDsExeSrcStop(Map<String, Object> map) throws Exception {
		spiderDAO.updateDsExeSrcStop(map);
	}
	
	/* CBAP$_EXE_CRW_TGT CUD */
	@Override
	public void deleteDsExeTgtByJob(Map<String, Object> map) throws Exception {
		spiderDAO.deleteDsExeTgtByJob(map);
	}

	@Override
	public void deleteDsExeTgtBySrc(Map<String, Object> map) throws Exception {
		spiderDAO.deleteDsExeTgtBySrc(map);
	}
	
	@Override
	public void deleteDsExeTgtByTgt(Map<String, Object> map) throws Exception {
		spiderDAO.deleteDsExeTgtByTgt(map);
	}
	
	@Override
	public void deleteDsExeTgtBySrcNumTgt(Map<String, Object> map) throws Exception {
		spiderDAO.deleteDsExeTgtBySrcNumTgt(map);
	}

	@Override
	public void insertDsExeTgt(Map<String, Object> map) throws Exception {
		spiderDAO.insertDsExeTgt(map);
	}
	
	@Override
	public void updateDsExeTgt(Map<String, Object> map) throws Exception {
		spiderDAO.updateDsExeTgt(map);
	}	
	
	/* CBAP$_EXE_CRW_ITM CUD  */
	@Override
	public void deleteDsExeItemByJob(Map<String, Object> map) throws Exception {
		spiderDAO.deleteDsExeItemByJob(map);
	}

	@Override
	public void deleteDsExeItemBySrc(Map<String, Object> map) throws Exception {
		spiderDAO.deleteDsExeItemBySrc(map);
	}
	
	@Override
	public void deleteDsExeItemByTgt(Map<String, Object> map) throws Exception {
		spiderDAO.deleteDsExeItemByTgt(map);
	}
	
	@Override
	public void deleteDsExeItemBySrcNumTgt(Map<String, Object> map) throws Exception {
		spiderDAO.deleteDsExeItemBySrcNumTgt(map);
	}

	@Override
	public void insertDsExeItem(Map<String, Object> map) throws Exception {
		spiderDAO.insertDsExeItem(map);
	}    
}
