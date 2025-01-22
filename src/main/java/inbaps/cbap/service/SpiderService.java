package inbaps.cbap.service;

import java.util.List;
import java.util.Map;

public interface SpiderService {
	
	/* CRAWLING 관련 SELECT 쿼리 */
	List<Map<String, Object>> selectDsSourceList(Map<String, Object> map) throws Exception;
	List<Map<String, Object>> selectDsTargetList(Map<String, Object> map) throws Exception;
	List<Map<String, Object>> selectDsExeUrlVal(Map<String, Object> map) throws Exception;
	List<Map<String, Object>> selectDsJobList(Map<String, Object> map) throws Exception;
	List<Map<String, Object>> selectExeCrwExecuteYn(Map<String, Object> map) throws Exception;
	
	/* CBAP$_EXE_CRW_JOB CUD */
	void deleteDsExeJob(Map<String, Object> map) throws Exception;
	void insertDsExeJob(Map<String, Object> map) throws Exception;
	void updateDsExeJob(Map<String, Object> map) throws Exception;
	void updateDsExeJobStop(Map<String, Object> map) throws Exception;
	
	/* CBAP$_EXE_CRW_SRC CUD */
	void deleteDsExeSrcByJob(Map<String, Object> map) throws Exception;
	void deleteDsExeSrcBySrc(Map<String, Object> map) throws Exception;
	void deleteDsExeSrcBySrcNum(Map<String, Object> map) throws Exception;
	void insertDsExeSrc(Map<String, Object> map) throws Exception;
	void updateDsExeSrcStart(Map<String, Object> map) throws Exception;
	void updateDsExeSrcEnd(Map<String, Object> map) throws Exception;
	void updateDsExeSrcStop(Map<String, Object> map) throws Exception;

	/* CBAP$_EXE_CRW_TGT CUD */
	void deleteDsExeTgtByJob(Map<String, Object> map) throws Exception;
	void deleteDsExeTgtBySrc(Map<String, Object> map) throws Exception;
	void deleteDsExeTgtByTgt(Map<String, Object> map) throws Exception;
	void deleteDsExeTgtBySrcNumTgt(Map<String, Object> map) throws Exception;
	void insertDsExeTgt(Map<String, Object> map) throws Exception;
	void updateDsExeTgt(Map<String, Object> map) throws Exception;
	
	/* CBAP$_EXE_CRW_ITM CUD  */
	void deleteDsExeItemByJob(Map<String, Object> map) throws Exception;
	void deleteDsExeItemBySrc(Map<String, Object> map) throws Exception;
	void deleteDsExeItemByTgt(Map<String, Object> map) throws Exception;
	void deleteDsExeItemBySrcNumTgt(Map<String, Object> map) throws Exception;
	void insertDsExeItem(Map<String, Object> map) throws Exception;	
}
