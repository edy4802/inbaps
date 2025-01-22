package inbaps.vbap.service;

import java.util.List;
import java.util.Map;

public interface VbapService {

	List<Map<String, Object>> openVwMainSub01Data(Map<String, Object> map) throws Exception;
	
	List<Map<String, Object>> openVwMainSub01Link(Map<String, Object> map) throws Exception;
}
