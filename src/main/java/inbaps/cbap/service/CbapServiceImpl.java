package inbaps.cbap.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import inbaps.cbap.dao.CbapDAO;

@Service("cbapService")
public class CbapServiceImpl implements CbapService{
	Logger log = Logger.getLogger(this.getClass());
	
    @Resource(name="cbapDAO")
    private CbapDAO cbapDAO;	

	@Override
	public List<Map<String, Object>> selectLogin(Map<String, Object> map) throws Exception {
		return cbapDAO.selectLogin(map);
	}

	@Override
	public List<Map<String, Object>> selectDsProjectList(Map<String, Object> map) throws Exception {
		return cbapDAO.selectDsProjectList(map);
	}

	@Override
	public void insertDsProjectInfo(Map<String, Object> map) throws Exception {
		cbapDAO.insertDsProjectInfo(map);
	}

	@Override
	public void deleteDsProjectInfo(Map<String, Object> map) throws Exception {
		cbapDAO.deleteDsTargetAllByProject(map);
		cbapDAO.deleteDsSourceAllByProject(map);
		cbapDAO.deleteDsJobAllByProject(map);
		cbapDAO.deleteDsProjectInfo(map);
	}
	
	@Override
	public void updateDsProjectInfo(Map<String, Object> map) throws Exception {
		cbapDAO.updateDsProjectInfo(map);
	}

	@Override
	public List<Map<String, Object>> selectDsApiJobList(Map<String, Object> map) throws Exception {
		return cbapDAO.selectDsApiJobList(map);
	}
	
	@Override
	public void insertDsJobInfo(Map<String, Object> map) throws Exception {
		cbapDAO.insertDsJobInfo(map);
	}
	
	@Override
	public void insertDsApiJobInfo(Map<String, Object> map) throws Exception {
		cbapDAO.insertDsApiJobInfo(map);
	}
	
	@Override
	public void deleteDsJobInfo(Map<String, Object> map) throws Exception {
		cbapDAO.deleteDsTargetAllByJob(map);
		cbapDAO.deleteDsSourceAllByJob(map);
		cbapDAO.deleteDsJobInfo(map);
	}
	
	@Override
	public void deleteDsApiJobInfo(Map<String, Object> map) throws Exception {
		cbapDAO.deleteDsApiInputAllByJob(map);
		cbapDAO.deleteDsApiOutputAllByJob(map);
		cbapDAO.deleteDsApiSourceAllByJob(map);
		cbapDAO.deleteDsApiJobInfo(map);
	}

	@Override
	public void updateDsJobInfo(Map<String, Object> map) throws Exception {
		cbapDAO.updateDsJobInfo(map);
	}
	
	@Override
	public void updateDsApiJobInfo(Map<String, Object> map) throws Exception {
		cbapDAO.updateDsApiJobInfo(map);
	}
	
	@Override
	public void insertDsSourceInfo(Map<String, Object> map) throws Exception {
		cbapDAO.insertDsSourceInfo(map);
	}
	
	@Override
	public void insertDsApiSourceInfo(Map<String, Object> map) throws Exception {
		cbapDAO.insertDsApiSourceInfo(map);
	}	
	
	@Override
	public void deleteDsSourceInfo(Map<String, Object> map) throws Exception {
		cbapDAO.deleteDsTargetAllBySource(map);
		cbapDAO.deleteDsSourceInfo(map);
	}
	
	@Override
	public void deleteDsApiSourceInfo(Map<String, Object> map) throws Exception {
		cbapDAO.deleteDsApiInputAllBySource(map);
		cbapDAO.deleteDsApiOutputAllBySource(map);
		cbapDAO.deleteDsApiSourceInfo(map);
	}	
	
	@Override
	public void updateDsSourceInfo(Map<String, Object> map) throws Exception {
		cbapDAO.updateDsSourceInfo(map);
	}	
	
	@Override
	public void updateDsApiSourceInfo(Map<String, Object> map) throws Exception {
		cbapDAO.updateDsApiSourceInfo(map);
	}	

	
	@Override
	public List<Map<String, Object>> selectDsApiInputRequestList(Map<String, Object> map) throws Exception {
		return cbapDAO.selectDsApiInputRequestList(map);
	}	
	
	@Override
	public void insertDsTargetInfo(Map<String, Object> map) throws Exception {
		cbapDAO.insertDsTargetInfo(map);
	}

	@Override
	public void insertDsApiInputInfo(Map<String, Object> map) throws Exception {
		cbapDAO.insertDsApiInputInfo(map);
	}
	
	@Override
	public void insertDsApiOutputInfo(Map<String, Object> map) throws Exception {
		cbapDAO.insertDsApiOutputInfo(map);
	}	

	@Override
	public void deleteDsTargetInfo(Map<String, Object> map) throws Exception {
		cbapDAO.deleteDsTargetInfo(map);
	}

	@Override
	public void deleteDsApiInputInfo(Map<String, Object> map) throws Exception {
		cbapDAO.deleteDsApiInputInfo(map);
	}
	
	@Override
	public void deleteDsApiOutputInfo(Map<String, Object> map) throws Exception {
		cbapDAO.deleteDsApiOutputInfo(map);
	}	

	@Override
	public void updateDsTargetInfo(Map<String, Object> map) throws Exception {
		cbapDAO.updateDsTargetInfo(map);
	}	

	@Override
	public void updateDsApiInputInfo(Map<String, Object> map) throws Exception {
		cbapDAO.updateDsApiInputInfo(map);
	}	

	@Override
	public void updateDsApiOutputInfo(Map<String, Object> map) throws Exception {
		cbapDAO.updateDsApiOutputInfo(map);
	}	

	@Override
	public List<Map<String, Object>> selectDsExeItemVal(Map<String, Object> map) throws Exception {
		return cbapDAO.selectDsExeItemVal(map);
	}
	
	@Override
	public List<Map<String, Object>> selectDsExeItemValForApi(Map<String, Object> map) throws Exception {
		return cbapDAO.selectDsExeItemValForApi(map);
	}

	@Override
	public List<Map<String, Object>> selectDsExeApiItemVal(Map<String, Object> map) throws Exception {
		return cbapDAO.selectDsExeApiItemVal(map);
	}

	@Override
	public List<Map<String, Object>> selectDsRegexView(Map<String, Object> map) throws Exception {
		return cbapDAO.selectDsRegexView(map);
	}	

	@Override
	public List<Map<String, Object>> selectDsSrcTgtList(Map<String, Object> map) throws Exception {
		return cbapDAO.selectDsSrcTgtList(map);
	}
	

	
	@Override
	public List<Map<String, Object>> selectBoardList(Map<String, Object> map) throws Exception {
		return cbapDAO.selectBoardList(map);
	}
	
	@Override
	public void applyDsTempJob(Map<String, Object> map) throws Exception {
		
		cbapDAO.deleteDsSourceAllByJob(map);
		cbapDAO.applyDsTempJobToSrc(map);
		cbapDAO.deleteDsTargetAllByJob(map);
		cbapDAO.applyDsTempJobToTgt(map);
	}
	
	@Override
	public void applyDsTempApiJob(Map<String, Object> map) throws Exception {
		
		cbapDAO.deleteDsApiSourceAllByJob(map);
		cbapDAO.applyDsTempApiJobToSrc(map);
		cbapDAO.deleteDsApiInputAllByJob(map);
		cbapDAO.deleteDsApiOutputAllByJob(map);
		cbapDAO.applyDsTempApiJobToInput(map);
		cbapDAO.applyDsTempApiJobToOutput(map);
	}	

	@Override
	public void applyDsTempApiSrc(Map<String, Object> map) throws Exception {
		
		cbapDAO.deleteDsApiInputAllBySource(map);
		cbapDAO.deleteDsApiOutputAllBySource(map);
		cbapDAO.applyDsTempApiSourceToInput(map);
		cbapDAO.applyDsTempApiSourceToOutput(map);
	}	
	
	@Override
	public List<Map<String, Object>> selectDsReport1(Map<String, Object> map) throws Exception {
		return cbapDAO.selectDsReport1(map);
	}
	
	@Override
	public List<Map<String, Object>> selectDsTempJobList(Map<String, Object> map) throws Exception {
		return cbapDAO.selectDsTempJobList(map);
	}
	
	@Override
	public List<Map<String, Object>> selectDsTempApiInpValList(Map<String, Object> map) throws Exception {
		return cbapDAO.selectDsTempApiInpValList(map);
	}
	
	@Override
	public List<Map<String, Object>> selectDsTempApiJobList(Map<String, Object> map) throws Exception {
		return cbapDAO.selectDsTempApiJobList(map);
	}

	@Override
	public List<Map<String, Object>> selectDsTempApiSrcList(Map<String, Object> map) throws Exception {
		return cbapDAO.selectDsTempApiSrcList(map);
	}
	
	/* 배치예제 */
	
	
	@Override
	public List<Map<String, Object>> selectDsBatResultList(Map<String, Object> map) throws Exception {
		return cbapDAO.selectDsBatResultList(map);
	}
	
	@Override
	public List<Map<String, Object>> selectDsBatJobList(Map<String, Object> map) throws Exception {
		return cbapDAO.selectDsBatJobList(map);
	}

	@Override
	public void insDsBatJobInfo(Map<String, Object> map) throws Exception {
		cbapDAO.insDsBatJobInfo(map);
	}
	
	@Override
	public void delDsBatJobInfo(Map<String, Object> map) throws Exception {
		cbapDAO.delDsBatJobPrmAllByBatJobInfo(map);
		cbapDAO.delDsBatJobInfo(map);
	}
	
	@Override
	public void saveDsBatJobInfo(Map<String, Object> map) throws Exception {
		cbapDAO.saveDsBatJobInfo(map);
	}

	@Override
	public List<Map<String, Object>> selectDsBatJobPrmList(Map<String, Object> map) throws Exception {
		return cbapDAO.selectDsBatJobPrmList(map);
	}

	@Override
	public void insDsBatJobPrmInfo(Map<String, Object> map) throws Exception {
		cbapDAO.insDsBatJobPrmInfo(map);
	}
	
	@Override
	public void delDsBatJobPrmInfo(Map<String, Object> map) throws Exception {
		cbapDAO.delDsBatJobPrmInfo(map);
	}
	
	@Override
	public void saveDsBatJobPrmInfo(Map<String, Object> map) throws Exception {
		cbapDAO.saveDsBatJobPrmInfo(map);
	}
	
	/*■■■■■■■■■■■■ 작업일:20170606 작업자:신한별 작업내용: 수집결과 미리보기.st ■■■■■■■■■■■■*/
	@Override
	public List<Map<String, Object>> selectDScrwPreview(Map<String, Object> map) throws Exception {
		return cbapDAO.selectDScrwPreview(map);
	}
	@Override
	public String selectDScrwImgPreview(Map<String, Object> map) {
		return cbapDAO.selectDScrwImgPreview(map); 
	}
	/*■■■■■■■■■■■■ 작업일:20170606 작업자:신한별 작업내용: 수집결과 미리보기.ed ■■■■■■■■■■■■*/
	
	/* 아래는 예제소스임 */
	

	@Override
	public void insertBoard(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Map<String, Object> selectBoardDetail(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateBoard(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteBoard(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<Map<String, Object>> openDrawDatasetAPI(Map<String, Object> map) throws Exception {
		return cbapDAO.openDrawDatasetAPI(map);
	}
	
	@Override
	public List<Map<String, Object>> selectOupKeyList(Map<String, Object> map) throws Exception {
		return cbapDAO.selectOupKeyList(map);
	}

	@Override
	public String selectOupId(Map<String, Object> map) {
		return cbapDAO.selectOupId(map);
	}

}
