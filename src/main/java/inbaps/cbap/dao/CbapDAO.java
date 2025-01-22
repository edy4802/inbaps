package inbaps.cbap.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import inbaps.common.dao.AbstractDAO;

@Repository("cbapDAO")
public class CbapDAO extends AbstractDAO {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectLogin(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectPagingList("datasearch.selectLogin", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectDsProjectList(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectPagingList("datasearch.selectDsProjectList", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> openDrawDatasetAPI(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectPagingList("datasearch.openDrawDatasetAPI", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectOupKeyList(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectPagingList("datasearch.selectOupKeyList", map);
	}

	public void insertDsProjectInfo(Map<String, Object> map) throws Exception{
		update("datasearch.insertDsProjectInfo", map);
	}

	public void deleteDsProjectInfo(Map<String, Object> map) throws Exception{
		update("datasearch.deleteDsProjectInfo", map);
	}
	
	public void updateDsProjectInfo(Map<String, Object> map) throws Exception{
		update("datasearch.updateDsProjectInfo", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectDsApiJobList(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectPagingList("datasearch.selectDsApiJobList", map);
	}

	public void insertDsJobInfo(Map<String, Object> map) throws Exception{
		update("datasearch.insertDsJobInfo", map);
	}

	public void insertDsApiJobInfo(Map<String, Object> map) throws Exception{
		update("datasearch.insertDsApiJobInfo", map);
	}

	public void deleteDsJobInfo(Map<String, Object> map) throws Exception{
		update("datasearch.deleteDsJobInfo", map);
	}	
	
	public void deleteDsApiJobInfo(Map<String, Object> map) throws Exception{
		update("datasearch.deleteDsApiJobInfo", map);
	}	
	
	public void deleteDsJobAllByProject(Map<String, Object> map) throws Exception{
		update("datasearch.deleteDsJobAllByProject", map);
	}

	public void deleteDsApiJobAllByProject(Map<String, Object> map) throws Exception{
		update("datasearch.deleteDsApiJobAllByProject", map);
	}

	public void updateDsJobInfo(Map<String, Object> map) throws Exception{
		update("datasearch.updateDsJobInfo", map);
	}	
	
	public void updateDsApiJobInfo(Map<String, Object> map) throws Exception{
		update("datasearch.updateDsApiJobInfo", map);
	}	
	
	public void insertDsSourceInfo(Map<String, Object> map) throws Exception{
		update("datasearch.insertDsSourceInfo", map);
	}
	
	public void insertDsApiSourceInfo(Map<String, Object> map) throws Exception{
		update("datasearch.insertDsApiSourceInfo", map);
	}	
	
	public void deleteDsSourceInfo(Map<String, Object> map) throws Exception{
		update("datasearch.deleteDsSourceInfo", map);
	}
	
	public void deleteDsSourceAllByProject(Map<String, Object> map) throws Exception{
		update("datasearch.deleteDsSourceAllByProject", map);
	}	

	public void deleteDsSourceAllByJob(Map<String, Object> map) throws Exception{
		update("datasearch.deleteDsSourceAllByJob", map);
	}
	
	public void updateDsSourceInfo(Map<String, Object> map) throws Exception{
		update("datasearch.updateDsSourceInfo", map);
	}
	
	public void updateDsApiSourceInfo(Map<String, Object> map) throws Exception{
		update("datasearch.updateDsApiSourceInfo", map);
	}	
	
	public void insertDsTargetInfo(Map<String, Object> map) throws Exception{
		update("datasearch.insertDsTargetInfo", map);
	}
	
	public void deleteDsTargetInfo(Map<String, Object> map) throws Exception{
		update("datasearch.deleteDsTargetInfo", map);
	}
	
	public void deleteDsTargetAllByProject(Map<String, Object> map) throws Exception{
		update("datasearch.deleteDsTargetAllByProject", map);
	}	

	public void deleteDsTargetAllByJob(Map<String, Object> map) throws Exception{
		update("datasearch.deleteDsTargetAllByJob", map);
	}

	public void deleteDsTargetAllBySource(Map<String, Object> map) throws Exception{
		update("datasearch.deleteDsTargetAllBySource", map);
	}
	
	public void updateDsTargetInfo(Map<String, Object> map) throws Exception{
		update("datasearch.updateDsTargetInfo", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectDsApiInputRequestList(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectPagingList("datasearch.selectDsApiInputRequestList", map);
	}
	
	public void insertDsApiInputInfo(Map<String, Object> map) throws Exception{
		update("datasearch.insertDsApiInputInfo", map);
	}
	
	public void insertDsApiOutputInfo(Map<String, Object> map) throws Exception{
		update("datasearch.insertDsApiOutputInfo", map);
	}
	
	
	public void deleteDsApiInputAllByProject(Map<String, Object> map) throws Exception{
		update("datasearch.deleteDsApiInputAllByProject", map);
	}
	
	public void deleteDsApiOutputAllByProject(Map<String, Object> map) throws Exception{
		update("datasearch.deleteDsApiOutputAllByProject", map);
	}

	public void deleteDsApiInputAllByJob(Map<String, Object> map) throws Exception{
		update("datasearch.deleteDsApiInputAllByJob", map);
	}
	
	public void deleteDsApiOutputAllByJob(Map<String, Object> map) throws Exception{
		update("datasearch.deleteDsApiOutputAllByJob", map);
	}

	public void deleteDsApiInputAllBySource(Map<String, Object> map) throws Exception{
		update("datasearch.deleteDsApiInputAllBySource", map);
	}
	
	public void deleteDsApiOutputAllBySource(Map<String, Object> map) throws Exception{
		update("datasearch.deleteDsApiOutputAllBySource", map);
	}
	
	public void deleteDsApiInputInfo(Map<String, Object> map) throws Exception{
		update("datasearch.deleteDsApiInputInfo", map);
	}
	
	public void deleteDsApiOutputInfo(Map<String, Object> map) throws Exception{
		update("datasearch.deleteDsApiOutputInfo", map);
	}
	
	public void updateDsApiOutputInfo(Map<String, Object> map) throws Exception{
		update("datasearch.updateDsApiOutputInfo", map);
	}
	
	public void updateDsApiInputInfo(Map<String, Object> map) throws Exception{
		update("datasearch.updateDsApiInputInfo", map);
	}
	
	public void deleteDsApiSourceAllByProject(Map<String, Object> map) throws Exception{
		update("datasearch.deleteDsApiSourceAllByProject", map);
	}

	public void deleteDsApiSourceAllByJob(Map<String, Object> map) throws Exception{
		update("datasearch.deleteDsApiSourceAllByJob", map);
	}
	
	public void deleteDsApiSourceInfo(Map<String, Object> map) throws Exception{
		update("datasearch.deleteDsApiSourceInfo", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectDsExeItemVal(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectPagingList("datasearch.selectDsExeItemVal", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectDsExeItemValForApi(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectPagingList("datasearch.selectDsExeItemValForApi", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectDsExeApiItemVal(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectPagingList("datasearch.selectDsExeApiItemVal", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectDsRegexView(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectPagingList("datasearch.selectDsRegexView", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectDsSrcTgtList(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectPagingList("datasearch.selectDsSrcTgtList", map);
	}
	


	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectDsTempJobList(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectPagingList("datasearch.selectDsTempJobList", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectDsTempApiInpValList(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectPagingList("datasearch.selectDsTempApiInpValList", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectDsTempApiJobList(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectPagingList("datasearch.selectDsTempApiJobList", map);
	}	
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectDsTempApiSrcList(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectPagingList("datasearch.selectDsTempApiSrcList", map);
	}	
	
	public void applyDsTempJobToSrc(Map<String, Object> map) throws Exception{
		update("datasearch.applyDsTempJobToSrc", map);
	}
	
	public void applyDsTempApiJobToSrc(Map<String, Object> map) throws Exception{
		update("datasearch.applyDsTempApiJobToSrc", map);
	}
	
	public void applyDsTempJobToTgt(Map<String, Object> map) throws Exception{
		update("datasearch.applyDsTempJobToTgt", map);
	}
	
	public void applyDsTempApiJobToInput(Map<String, Object> map) throws Exception{
		update("datasearch.applyDsTempApiJobToInput", map);
	}
	
	public void applyDsTempApiJobToOutput(Map<String, Object> map) throws Exception{
		update("datasearch.applyDsTempApiJobToOutput", map);
	}
	
	public void applyDsTempApiSourceToInput(Map<String, Object> map) throws Exception{
		update("datasearch.applyDsTempApiSourceToInput", map);
	}
	
	public void applyDsTempApiSourceToOutput(Map<String, Object> map) throws Exception{
		update("datasearch.applyDsTempApiSourceToOutput", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectDsReport1(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectPagingList("datasearch.selectDsReport1", map);
	}
	
	/* 배치예약 관련 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectDsBatResultList(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectPagingList("datasearch.selectDsBatResultList", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectDsBatJobList(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectPagingList("datasearch.selectDsBatJobList", map);
	}

	public void insDsBatJobInfo(Map<String, Object> map) throws Exception{
		update("datasearch.insDsBatJobInfo", map);
	}
	
	public void delDsBatJobInfo(Map<String, Object> map) throws Exception{
		update("datasearch.delDsBatJobInfo", map);
	}
	
	public void saveDsBatJobInfo(Map<String, Object> map) throws Exception{
		update("datasearch.saveDsBatJobInfo", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectDsBatJobPrmList(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectPagingList("datasearch.selectDsBatJobPrmList", map);
	}

	public void insDsBatJobPrmInfo(Map<String, Object> map) throws Exception{
		update("datasearch.insDsBatJobPrmInfo", map);
	}
	
	public void delDsBatJobPrmAllByBatJobInfo(Map<String, Object> map) throws Exception{
		update("datasearch.delDsBatJobPrmAllByBatJobInfo", map);
	}
	
	public void delDsBatJobPrmInfo(Map<String, Object> map) throws Exception{
		update("datasearch.delDsBatJobPrmInfo", map);
	}
	
	public void saveDsBatJobPrmInfo(Map<String, Object> map) throws Exception{
		update("datasearch.saveDsBatJobPrmInfo", map);
	}
	/*■■■■■■■■■■■■ 작업일:20170606 작업자:신한별 작업내용: 수집결과 미리보기.st ■■■■■■■■■■■■*/
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectDScrwPreview(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>) selectPagingList("datasearch.selectDScrwPreview", map);
	}
	public String selectDScrwImgPreview(Map<String, Object> map) {
		return (String) selectOne("datasearch.selectDScrwImgPreview", map);
	}
	/*■■■■■■■■■■■■ 작업일:20170606 작업자:신한별 작업내용: 수집결과 미리보기.ed ■■■■■■■■■■■■*/
	
	
	/* 아래는 예제 소스임 */

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectBoardList(Map<String, Object> map) {
		return (List<Map<String, Object>>)selectPagingList("datasearch.selectBoardList", map);
	}

	public String selectOupId(Map<String, Object> map) {
		return (String) selectOne("datasearch.selectOupId", map);
	}
	
}
