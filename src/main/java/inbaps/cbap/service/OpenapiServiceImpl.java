package inbaps.cbap.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import inbaps.cbap.dao.OpenapiDAO;


@Service("openapiService")
public class OpenapiServiceImpl implements OpenapiService{
	Logger log = Logger.getLogger(this.getClass());
	
    @Resource(name="openapiDAO")
    private OpenapiDAO openapiDAO;	
    
    /* API 관련 SELECT 쿼리 */
	@Override
	public List<Map<String, Object>> selectDsApiSourceList(Map<String, Object> map) throws Exception {
		return openapiDAO.selectDsApiSourceList(map);
	}
	
	@Override
	public List<Map<String, Object>> selectDsApiInputList(Map<String, Object> map) throws Exception {
		return openapiDAO.selectDsApiInputList(map);
	}	
	
	@Override
	public List<Map<String, Object>> selectDsApiOutputList(Map<String, Object> map) throws Exception {
		return openapiDAO.selectDsApiOutputList(map);
	}	

	@Override
	public List<Map<String, Object>> selectDsExeApiResultList(Map<String, Object> map) throws Exception {
		return openapiDAO.selectDsExeApiResultList(map);
	}

	@Override
	public List<Map<String, Object>> selectExeApiExecuteYn(Map<String, Object> map) throws Exception {
		return openapiDAO.selectExeApiExecuteYn(map);
	}
	
	@Override
	public List<Map<String, Object>> selectDsApiInpValList(Map<String, Object> map) throws Exception {
		return openapiDAO.selectDsApiInpValList(map);
	}
	
	/* CBAP$_EXE_API_JOB CUD */
	@Override
	public void deleteDsExeApiJob(Map<String, Object> map) throws Exception {
		openapiDAO.deleteDsExeApiJob(map);
	}

	@Override
	public void insertDsExeApiJob(Map<String, Object> map) throws Exception {
		openapiDAO.insertDsExeApiJob(map);
	}
	
	@Override
	public void updateDsExeApiJob(Map<String, Object> map) throws Exception {
		openapiDAO.updateDsExeApiJob(map);
	}	
	
	@Override
	public void updateDsExeApiJobStop(Map<String, Object> map) throws Exception {
		openapiDAO.updateDsExeApiJobStop(map);
	}
	
	/* CBAP$_EXE_API_SRC CUD */
	@Override
	public void deleteDsExeApiSrcByJob(Map<String, Object> map) throws Exception {
		openapiDAO.deleteDsExeApiSrcByJob(map);
	}

	@Override
	public void deleteDsExeApiSrcBySrc(Map<String, Object> map) throws Exception {
		openapiDAO.deleteDsExeApiSrcBySrc(map);
	}
	
	@Override
	public void deleteDsExeApiSrcBySrcNum(Map<String, Object> map) throws Exception {
		openapiDAO.deleteDsExeApiSrcBySrcNum(map);
	}
	
	@Override
	public void insertDsExeApiSrc(Map<String, Object> map) throws Exception {
		openapiDAO.insertDsExeApiSrc(map);
	}

	@Override
	public void updateDsExeApiSrcStart(Map<String, Object> map) throws Exception {
		openapiDAO.updateDsExeApiSrcStart(map);
	}

	@Override
	public void updateDsExeApiSrcEnd(Map<String, Object> map) throws Exception {
		openapiDAO.updateDsExeApiSrcEnd(map);
	}
	
	@Override
	public void updateDsExeApiSrcStop(Map<String, Object> map) throws Exception {
		openapiDAO.updateDsExeApiSrcStop(map);
	}
	
	/* CBAP$_EXE_API_INP CUD */
	@Override
	public void deleteDsExeApiInpByJob(Map<String, Object> map) throws Exception {
		openapiDAO.deleteDsExeApiInpByJob(map);
	}

	@Override
	public void deleteDsExeApiInpBySrc(Map<String, Object> map) throws Exception {
		openapiDAO.deleteDsExeApiInpBySrc(map);
	}
	
	@Override
	public void deleteDsExeApiInpByInp(Map<String, Object> map) throws Exception {
		openapiDAO.deleteDsExeApiInpByInp(map);
	}
	
	@Override
	public void deleteDsExeApiInpBySrcNumInp(Map<String, Object> map) throws Exception {
		openapiDAO.deleteDsExeApiInpBySrcNumInp(map);
	}

	@Override
	public void insertDsExeApiInp(Map<String, Object> map) throws Exception {
		openapiDAO.insertDsExeApiInp(map);
	}
	
	@Override
	public void updateDsExeApiInp(Map<String, Object> map) throws Exception {
		openapiDAO.updateDsExeApiInp(map);
	}
	
	/* CBAP$_EXE_API_ITM CUD  */
	@Override
	public void deleteDsExeApiItemByJob(Map<String, Object> map) throws Exception {
		openapiDAO.deleteDsExeApiItemByJob(map);
	}

	@Override
	public void deleteDsExeApiItemBySrc(Map<String, Object> map) throws Exception {
		openapiDAO.deleteDsExeApiItemBySrc(map);
	}

	@Override
	public void insertDsExeApiItem(Map<String, Object> map) throws Exception {
		openapiDAO.insertDsExeApiItem(map);
	}
	
	@Override
	public void insertDsExeApiItemFor(Map<String, Object> map) throws Exception {
		openapiDAO.insertDsExeApiItemFor(map);
	}


}
