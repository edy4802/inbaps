package inbaps.cbap.service;

import java.util.List;
import java.util.Map;

public interface CbapService {

	List<Map<String, Object>> selectLogin(Map<String, Object> map) throws Exception;
	
	List<Map<String, Object>> selectDsProjectList(Map<String, Object> map) throws Exception;
	
	List<Map<String, Object>> openDrawDatasetAPI(Map<String, Object> map) throws Exception;
	
	List<Map<String, Object>> selectOupKeyList(Map<String, Object> map) throws Exception;

	void insertDsProjectInfo(Map<String, Object> map) throws Exception;
	
	void deleteDsProjectInfo(Map<String, Object> map) throws Exception;
	
	void updateDsProjectInfo(Map<String, Object> map) throws Exception;
	
	List<Map<String, Object>> selectDsApiJobList(Map<String, Object> map) throws Exception;

	void insertDsJobInfo(Map<String, Object> map) throws Exception;
	
	void insertDsApiJobInfo(Map<String, Object> map) throws Exception;
	
	void deleteDsJobInfo(Map<String, Object> map) throws Exception;
	
	void deleteDsApiJobInfo(Map<String, Object> map) throws Exception;

	void updateDsJobInfo(Map<String, Object> map) throws Exception;
	
	void updateDsApiJobInfo(Map<String, Object> map) throws Exception;
	
	void insertDsSourceInfo(Map<String, Object> map) throws Exception;
	
	void insertDsApiSourceInfo(Map<String, Object> map) throws Exception;
	
	void deleteDsSourceInfo(Map<String, Object> map) throws Exception;
	
	void deleteDsApiSourceInfo(Map<String, Object> map) throws Exception;
	
	void updateDsSourceInfo(Map<String, Object> map) throws Exception;
	
	void updateDsApiSourceInfo(Map<String, Object> map) throws Exception;
	
	List<Map<String, Object>> selectDsApiInputRequestList(Map<String, Object> map) throws Exception;
	
	void insertDsTargetInfo(Map<String, Object> map) throws Exception;
	
	void insertDsApiInputInfo(Map<String, Object> map) throws Exception;
	void insertDsApiOutputInfo(Map<String, Object> map) throws Exception;
	
	void deleteDsTargetInfo(Map<String, Object> map) throws Exception;
	
	void deleteDsApiInputInfo(Map<String, Object> map) throws Exception;
	
	void deleteDsApiOutputInfo(Map<String, Object> map) throws Exception;
	
	void updateDsTargetInfo(Map<String, Object> map) throws Exception;
	
	void updateDsApiInputInfo(Map<String, Object> map) throws Exception;
	
	void updateDsApiOutputInfo(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> selectDsExeItemVal(Map<String, Object> map) throws Exception;
	
	List<Map<String, Object>> selectDsExeItemValForApi(Map<String, Object> map) throws Exception;
	
	List<Map<String, Object>> selectDsExeApiItemVal(Map<String, Object> map) throws Exception;
	
	List<Map<String, Object>> selectDsRegexView(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> selectDsSrcTgtList(Map<String, Object> map) throws Exception;

	List<Map<String, Object>> selectDsTempJobList(Map<String, Object> map) throws Exception;
	
	List<Map<String, Object>> selectDsTempApiInpValList(Map<String, Object> map) throws Exception;
	
	List<Map<String, Object>> selectDsTempApiJobList(Map<String, Object> map) throws Exception;
	
	List<Map<String, Object>> selectDsTempApiSrcList(Map<String, Object> map) throws Exception;
	
	void applyDsTempJob(Map<String, Object> map) throws Exception;
	
	void applyDsTempApiJob(Map<String, Object> map) throws Exception;
	
	void applyDsTempApiSrc(Map<String, Object> map) throws Exception;
	
	List<Map<String, Object>> selectDsReport1(Map<String, Object> map) throws Exception;
	
	/* 배치예약 관련 */
	
	List<Map<String, Object>> selectDsBatResultList(Map<String, Object> map) throws Exception;
	
	List<Map<String, Object>> selectDsBatJobList(Map<String, Object> map) throws Exception;

	void insDsBatJobInfo(Map<String, Object> map) throws Exception;
	
	void delDsBatJobInfo(Map<String, Object> map) throws Exception;
	
	void saveDsBatJobInfo(Map<String, Object> map) throws Exception;
	
	List<Map<String, Object>> selectDsBatJobPrmList(Map<String, Object> map) throws Exception;

	void insDsBatJobPrmInfo(Map<String, Object> map) throws Exception;
	
	void delDsBatJobPrmInfo(Map<String, Object> map) throws Exception;
	
	void saveDsBatJobPrmInfo(Map<String, Object> map) throws Exception;
	
	/*■■■■■■■■■■■■ 작업일:20170606 작업자:신한별 작업내용: 수집결과 미리보기.st ■■■■■■■■■■■■*/
	List<Map<String, Object>> selectDScrwPreview(Map<String, Object> map) throws Exception;
	String selectDScrwImgPreview(Map<String, Object> map);
	/*■■■■■■■■■■■■ 작업일:20170606 작업자:신한별 작업내용: 수집결과 미리보기.st ■■■■■■■■■■■■*/

	/* 아래는 예제소스임 */
	
	List<Map<String, Object>> selectBoardList(Map<String, Object> map) throws Exception;

	void insertBoard(Map<String, Object> map) throws Exception;

	Map<String, Object> selectBoardDetail(Map<String, Object> map) throws Exception;

	void updateBoard(Map<String, Object> map) throws Exception;

	void deleteBoard(Map<String, Object> map) throws Exception;

	String selectOupId(Map<String, Object> map);

}
