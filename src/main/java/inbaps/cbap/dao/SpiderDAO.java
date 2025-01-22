package inbaps.cbap.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import inbaps.common.dao.AbstractDAO;

@Repository("spiderDAO")
public class SpiderDAO extends AbstractDAO {
	
	/* CRAWLING 관련 SELECT 쿼리 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectDsSourceList(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectPagingList("datasearch.selectDsSourceList", map);
	}	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectDsTargetList(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectPagingList("datasearch.selectDsTargetList", map);
	}	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectDsExeUrlVal(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectPagingList("datasearch.selectDsExeUrlVal", map);
	}	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectDsJobList(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectPagingList("datasearch.selectDsJobList", map);
	}
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectExeCrwExecuteYn(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectPagingList("datasearch.selectExeCrwExecuteYn", map);
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
	public void updateDsExeJobStop(Map<String, Object> map) throws Exception{
		update("datasearch.updateDsExeJobStop", map);
	}
	
	/* CBAP$_EXE_CRW_SRC CUD */
	public void deleteDsExeSrcByJob(Map<String, Object> map) throws Exception{
		update("datasearch.deleteDsExeSrcByJob", map);
	}
	public void deleteDsExeSrcBySrc(Map<String, Object> map) throws Exception{
		update("datasearch.deleteDsExeSrcBySrc", map);
	}
	public void deleteDsExeSrcBySrcNum(Map<String, Object> map) throws Exception{
		update("datasearch.deleteDsExeSrcBySrcNum", map);
	}
	public void insertDsExeSrc(Map<String, Object> map) throws Exception{
		update("datasearch.insertDsExeSrc", map);
	}
	public void updateDsExeSrcStart(Map<String, Object> map) throws Exception{
		update("datasearch.updateDsExeSrcStart", map);
	}
	public void updateDsExeSrcEnd(Map<String, Object> map) throws Exception{
		update("datasearch.updateDsExeSrcEnd", map);
	}	
	public void updateDsExeSrcStop(Map<String, Object> map) throws Exception{
		update("datasearch.updateDsExeSrcStop", map);
	}
	
	/* CBAP$_EXE_CRW_TGT CUD */
	public void deleteDsExeTgtByJob(Map<String, Object> map) throws Exception{
		update("datasearch.deleteDsExeTgtByJob", map);
	}
	public void deleteDsExeTgtBySrc(Map<String, Object> map) throws Exception{
		update("datasearch.deleteDsExeTgtBySrc", map);
	}
	public void deleteDsExeTgtByTgt(Map<String, Object> map) throws Exception{
		update("datasearch.deleteDsExeTgtByTgt", map);
	}
	public void deleteDsExeTgtBySrcNumTgt(Map<String, Object> map) throws Exception{
		update("datasearch.deleteDsExeTgtBySrcNumTgt", map);
	}
	public void insertDsExeTgt(Map<String, Object> map) throws Exception{
		update("datasearch.insertDsExeTgt", map);
	}
	public void updateDsExeTgt(Map<String, Object> map) throws Exception{
		update("datasearch.updateDsExeTgt", map);
	}

	/* CBAP$_EXE_CRW_ITM CUD  */
	public void deleteDsExeItemByJob(Map<String, Object> map) throws Exception{
		update("datasearch.deleteDsExeItemByJob", map);
	}
	public void deleteDsExeItemBySrc(Map<String, Object> map) throws Exception{
		update("datasearch.deleteDsExeItemBySrc", map);
	}
	public void deleteDsExeItemByTgt(Map<String, Object> map) throws Exception{
		update("datasearch.deleteDsExeItemByTgt", map);
	}
	public void deleteDsExeItemBySrcNumTgt(Map<String, Object> map) throws Exception{
		update("datasearch.deleteDsExeItemBySrcNumTgt", map);
	}
	public void insertDsExeItem(Map<String, Object> map) throws Exception{
		update("datasearch.insertDsExeItem", map);
	}	
}
