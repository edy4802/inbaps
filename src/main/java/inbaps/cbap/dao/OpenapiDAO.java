package inbaps.cbap.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import inbaps.common.dao.AbstractDAO;

@Repository("openapiDAO")
public class OpenapiDAO extends AbstractDAO {
	
	/* API 관련 SELECT 쿼리 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectDsApiSourceList(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectPagingList("datasearch.selectDsApiSourceList", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectDsApiInputList(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectPagingList("datasearch.selectDsApiInputList", map);
	}	

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectDsApiOutputList(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectPagingList("datasearch.selectDsApiOutputList", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectDsExeApiResultList(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectPagingList("datasearch.selectDsExeApiResultList", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectExeApiExecuteYn(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectPagingList("datasearch.selectExeApiExecuteYn", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectDsApiInpValList(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectPagingList("datasearch.selectDsApiInpValList", map);
	}
	
	public void updateDsExeApiJobStop(Map<String, Object> map) throws Exception{
		update("datasearch.updateDsExeApiJobStop", map);
	}
	
	public void updateDsExeApiSrcStop(Map<String, Object> map) throws Exception{
		update("datasearch.updateDsExeApiSrcStop", map);
	}

	/* CBAP$_EXE_API_JOB CUD */
	public void deleteDsExeApiJob(Map<String, Object> map) throws Exception{
		update("datasearch.deleteDsExeApiJob", map);
	}
	public void insertDsExeApiJob(Map<String, Object> map) throws Exception{
		update("datasearch.insertDsExeApiJob", map);
	}
	public void updateDsExeApiJob(Map<String, Object> map) throws Exception{
		update("datasearch.updateDsExeApiJob", map);
	}
	
	/* CBAP$_EXE_API_SRC CUD */
	public void deleteDsExeApiSrcByJob(Map<String, Object> map) throws Exception{
		update("datasearch.deleteDsExeApiSrcByJob", map);
	}
	public void deleteDsExeApiSrcBySrc(Map<String, Object> map) throws Exception{
		update("datasearch.deleteDsExeApiSrcBySrc", map);
	}
	public void deleteDsExeApiSrcBySrcNum(Map<String, Object> map) throws Exception{
		update("datasearch.deleteDsExeApiSrcBySrcNum", map);
	}
	public void insertDsExeApiSrc(Map<String, Object> map) throws Exception{
		update("datasearch.insertDsExeApiSrc", map);
	}
	public void updateDsExeApiSrcStart(Map<String, Object> map) throws Exception{
		update("datasearch.updateDsExeApiSrcStart", map);
	}
	public void updateDsExeApiSrcEnd(Map<String, Object> map) throws Exception{
		update("datasearch.updateDsExeApiSrcEnd", map);
	}	
	
	/* CBAP$_EXE_API_INP CUD */
	public void deleteDsExeApiInpByJob(Map<String, Object> map) throws Exception{
		update("datasearch.deleteDsExeApiInpByJob", map);
	}
	public void deleteDsExeApiInpBySrc(Map<String, Object> map) throws Exception{
		update("datasearch.deleteDsExeApiInpBySrc", map);
	}
	public void deleteDsExeApiInpByInp(Map<String, Object> map) throws Exception{
		update("datasearch.deleteDsExeApiInpByInp", map);
	}
	public void deleteDsExeApiInpBySrcNumInp(Map<String, Object> map) throws Exception{
		update("datasearch.deleteDsExeApiInpBySrcNumInp", map);
	}
	public void insertDsExeApiInp(Map<String, Object> map) throws Exception{
		update("datasearch.insertDsExeApiInp", map);
	}
	public void updateDsExeApiInp(Map<String, Object> map) throws Exception{
		update("datasearch.updateDsExeApiInp", map);
	}
	
	/* CBAP$_EXE_API_ITM CUD  */
	public void deleteDsExeApiItemByJob(Map<String, Object> map) throws Exception{
		update("datasearch.deleteDsExeApiItemByJob", map);
	}
	public void deleteDsExeApiItemBySrc(Map<String, Object> map) throws Exception{
		update("datasearch.deleteDsExeApiItemBySrc", map);
	}
	public void insertDsExeApiItem(Map<String, Object> map) throws Exception{
		update("datasearch.insertDsExeApiItem", map);
	}
	public void insertDsExeApiItemFor(Map<String, Object> map) throws Exception{
		update("datasearch.insertDsExeApiItemFor", map);
	}
}
