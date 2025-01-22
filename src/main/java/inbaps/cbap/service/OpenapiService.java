package inbaps.cbap.service;

import java.util.List;
import java.util.Map;

public interface OpenapiService {
	
	/* API 관련 SELECT 쿼리 */
	List<Map<String, Object>> selectDsApiSourceList(Map<String, Object> map) throws Exception;
	List<Map<String, Object>> selectDsApiInputList(Map<String, Object> map) throws Exception;
	List<Map<String, Object>> selectDsApiOutputList(Map<String, Object> map) throws Exception;
	List<Map<String, Object>> selectDsExeApiResultList(Map<String, Object> map) throws Exception;	
	List<Map<String, Object>> selectExeApiExecuteYn(Map<String, Object> map) throws Exception;
	List<Map<String, Object>> selectDsApiInpValList(Map<String, Object> map) throws Exception;
	
	/* CBAP$_EXE_API_JOB CUD */
	void deleteDsExeApiJob(Map<String, Object> map) throws Exception;
	void insertDsExeApiJob(Map<String, Object> map) throws Exception;
	void updateDsExeApiJob(Map<String, Object> map) throws Exception;
	void updateDsExeApiJobStop(Map<String, Object> map) throws Exception;
	
	/* CBAP$_EXE_API_SRC CUD */
	void deleteDsExeApiSrcByJob(Map<String, Object> map) throws Exception;
	void deleteDsExeApiSrcBySrc(Map<String, Object> map) throws Exception;
	void deleteDsExeApiSrcBySrcNum(Map<String, Object> map) throws Exception;
	void insertDsExeApiSrc(Map<String, Object> map) throws Exception;
	void updateDsExeApiSrcStart(Map<String, Object> map) throws Exception;
	void updateDsExeApiSrcEnd(Map<String, Object> map) throws Exception;
	void updateDsExeApiSrcStop(Map<String, Object> map) throws Exception;
	
	/* CBAP$_EXE_API_INP CUD */
	void deleteDsExeApiInpByJob(Map<String, Object> map) throws Exception;
	void deleteDsExeApiInpBySrc(Map<String, Object> map) throws Exception;
	void deleteDsExeApiInpByInp(Map<String, Object> map) throws Exception;
	void deleteDsExeApiInpBySrcNumInp(Map<String, Object> map) throws Exception;
	void insertDsExeApiInp(Map<String, Object> map) throws Exception;
	void updateDsExeApiInp(Map<String, Object> map) throws Exception;
	
	/* CBAP$_EXE_API_ITM CUD  */
	void deleteDsExeApiItemByJob(Map<String, Object> map) throws Exception;
	void deleteDsExeApiItemBySrc(Map<String, Object> map) throws Exception;
	void insertDsExeApiItem(Map<String, Object> map) throws Exception;
	void insertDsExeApiItemFor(Map<String, Object> map) throws Exception;
	
}
