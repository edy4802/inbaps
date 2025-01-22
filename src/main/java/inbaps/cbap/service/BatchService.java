package inbaps.cbap.service;

import java.util.List;
import java.util.Map;

public interface BatchService {
	
	/* CRAWLING 관련 SELECT 쿼리 */
	List<Map<String, Object>> selectDsSourceList(Map<String, Object> map) throws Exception;
	
	/* CBAP$_EXE_CRW_JOB CUD */
	void deleteDsExeJob(Map<String, Object> map) throws Exception;
	void insertDsExeJob(Map<String, Object> map) throws Exception;
	void updateDsExeJob(Map<String, Object> map) throws Exception;	
}
