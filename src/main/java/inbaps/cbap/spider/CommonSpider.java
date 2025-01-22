/*
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■ 파일명 : CommonSpider
■ 기능명 : 웹수집기 클래스
■ 설   명 : 웹컨텐츠 수집을 위한 기능 클래스
■ 작성자 : (주)인아이티 SI사업부 
■ 작성일 : 2016.03.21 : 최초작성
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
*/
package inbaps.cbap.spider;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.log4j.Logger;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;

public class CommonSpider {
	Logger log = Logger.getLogger(this.getClass());
	
    private String url = "";
    private String urlParameters = "";
    private String content = "";
    private String regex = "";
    private String replaceRegex = "";
    private String disptype = "";
    private String tgtFindType = "REG";
    private String srcEncode = "UTF-8";
    private String srcEncodeDefalut = "UTF-8";
    private String realUrl = "";
    private String srcSaveType = "";
    private String tgtSaveVal = "";
    private String urlSnapShotPath = "";
    
	private final String USER_AGENT = "Mozilla/5.0";
	
	private URL tgtUrl = null;
	private URLConnection urlCon = null;
	private HttpURLConnection hurlCon = null;
	
	public static void main(String[] args) throws Exception {

		//CommonSpider c = new CommonSpider();

	}

	public String getUrlSnapShotPath() {
		return urlSnapShotPath;
	}

	public void setUrlSnapShotPath(String urlSnapShotPath) {
		this.urlSnapShotPath = urlSnapShotPath;
	}

	public String getSrcEncodeDefalut() {
		return srcEncodeDefalut;
	}

	public void setSrcEncodeDefalut(String srcEncodeDefalut) {
		this.srcEncodeDefalut = srcEncodeDefalut;
	}

	public String getTgtSaveVal() {
		return tgtSaveVal;
	}

	public void setTgtSaveVal(String tgtSaveVal) {
		this.tgtSaveVal = tgtSaveVal;
	}
	
	public String getSrcSaveType() {
		return srcSaveType;
	}

	public void setSrcSaveType(String srcSaveType) {
		this.srcSaveType = srcSaveType;
	}
	
	public String getRealUrl() {
		return realUrl;
	}

	public void setRealUrl(String realUrl) {
		this.realUrl = realUrl;
	}
	
	public String getSrcEncode() {
		return srcEncode;
	}

	public void setSrcEncode(String srcEncode) {
		this.srcEncode = srcEncode;
	}
	
	public String getTgtFindType() {
		return tgtFindType;
	}

	public void setTgtFindType(String tgtFindType) {
		this.tgtFindType = tgtFindType;
	}
	
    public String getDisptype() {
		return disptype;
	}

	public void setDisptype(String disptype) {
		this.disptype = disptype;
	}
	
    public String getReplaceRegex() {
		return replaceRegex;
	}

	public void setReplaceRegex(String replaceRegex) {
		this.replaceRegex = replaceRegex;
	}

	public String getUrlParameters() {
		return urlParameters;
	}

	public void setUrlParameters(String urlParameters) {
		this.urlParameters = urlParameters;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getRegex() {
		return regex;
	}

	public void setRegex(String regex) {
		this.regex = regex;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	public String sendGetUrl() throws Exception {
		String url = getUrl();

		try{
			
			urlGet(url);
			
			if(hurlCon!=null){			
				int responseCode = -1;
				try{
					responseCode = hurlCon.getResponseCode();
					
					if (mustRedirect(responseCode))
					{
						urlGet(hurlCon.getHeaderField("Location"));
					}
				}catch(Exception e){
					if(log.isDebugEnabled()){e.printStackTrace();}
				}
				
				setRealUrl(hurlCon.getURL().toString());
			}
			
		}catch(Exception e){
			if(log.isDebugEnabled()){e.printStackTrace();}
			if(hurlCon!=null){
				setRealUrl(hurlCon.getURL().toString());
			}
		}finally{
			if(hurlCon!=null){hurlCon.disconnect();}
		}
		
		return getRealUrl();
	}
	
	public String sendPostUrl() throws Exception {
		String url = getUrl();
		
		try{
			
			urlPost(url);
			
			if(hurlCon!=null){
			
				String urlParameters = getUrlParameters();
				
				// Send post request
				
				DataOutputStream wr = new DataOutputStream(hurlCon.getOutputStream());
				wr.writeBytes(urlParameters);
				wr.flush();
				wr.close();
				
				int responseCode = -1;
				
				try{
					responseCode = hurlCon.getResponseCode();
					
					if (mustRedirect(responseCode))
					{
						urlGet(hurlCon.getHeaderField("Location"));
					}
				}catch(Exception e){
					if(log.isDebugEnabled()){e.printStackTrace();}
				}
				
				setRealUrl(hurlCon.getURL().toString());
			
			}
		}catch(Exception e){
			if(log.isDebugEnabled()){e.printStackTrace();}
			if(hurlCon!=null){
				setRealUrl(hurlCon.getURL().toString());
			}
		}finally{
			if(hurlCon!=null){hurlCon.disconnect();}
		}
		
		return getRealUrl();
	}
	
	// HTTP GET request
	public void sendGet() throws Exception {

		String url = getUrl();

		try{
			
			urlGet(url);			
	
			int responseCode = -1;
			
			if(hurlCon!=null){
				try{
					responseCode = hurlCon.getResponseCode();
					log.debug("\nSending 'GET' request to URL : " + url);
					log.debug("Response Code : " + responseCode);
					
					if (mustRedirect(responseCode))
					{
						urlGet(hurlCon.getHeaderField("Location"));
					}
				}catch(Exception e){
					if(log.isDebugEnabled()){e.printStackTrace();}
				}
				
				setRealUrl(hurlCon.getURL().toString());
				
				String encode = getSrcEncode();
				String curEncode = "";
	
				try{
					curEncode = getEncoding();
					
					log.debug("Encoding : " + encode);
					if("AUTO".equals(encode)){
						encode = curEncode;
					}
				}catch(Exception e){
					if(log.isDebugEnabled()){e.printStackTrace();}
				}
				
				readContents(encode);	
			}
			
		}catch(Exception e){
			if(log.isDebugEnabled()){e.printStackTrace();}
		}finally{
			if(hurlCon!=null){hurlCon.disconnect();}
		}
	}
	
	private String getEncoding(){
		String encode = "";
		
		if(hurlCon!=null){
			
			try{
				//curEncode = hurlCon.getContentEncoding();
				String headerType = hurlCon.getContentType();
				
				if(headerType != null && !headerType.isEmpty()){
					if(headerType.toUpperCase().indexOf("EUC-KR") != -1){
						encode = "EUC-KR";
					}else if(headerType.toUpperCase().indexOf("UTF-8") != -1){
						encode = "UTF-8";
					}else{
						encode = getSrcEncodeDefalut();
					}
				}else{
					encode = getSrcEncodeDefalut();
				}
			}catch(Exception e){
				if(log.isDebugEnabled()){e.printStackTrace();}
				encode = getSrcEncodeDefalut();
			}
		}
		
		return encode;
	}
	
	// HTTP POST request
	public void sendPost() throws Exception {

		String url = getUrl();
				
		try{
			
			urlPost(url);
			
			if(hurlCon!=null){
			
				String urlParameters = getUrlParameters();
				
				// Send post request
				
				DataOutputStream wr = new DataOutputStream(hurlCon.getOutputStream());
				wr.writeBytes(urlParameters);
				wr.flush();
				wr.close();
				
				int responseCode = -1;
				try{
					responseCode = hurlCon.getResponseCode();
					log.debug("\nSending 'GET' request to URL : " + url);
					log.debug("Response Code : " + responseCode);
					
					if (mustRedirect(responseCode))
					{
						urlGet(hurlCon.getHeaderField("Location"));
					}
				}catch(Exception e){
					if(log.isDebugEnabled()){e.printStackTrace();}
				}
				
				setRealUrl(hurlCon.getURL().toString());
	
				String encode = getSrcEncode();
				String curEncode = "";
	
				try{
					curEncode = getEncoding();
					log.debug("Encoding : " + encode);
					if("AUTO".equals(encode)){
						encode = curEncode;
					}
				}catch(Exception e){
					if(log.isDebugEnabled()){e.printStackTrace();}
				}			
				readContents(encode);
			}
		}catch(Exception e){
			if(log.isDebugEnabled()){e.printStackTrace();}
		}finally{
			if(hurlCon!=null){hurlCon.disconnect();}
		}
	}
	
	private boolean mustRedirect(int code) {
	    if (code == HttpURLConnection.HTTP_MOVED_PERM ||
	      code == HttpURLConnection.HTTP_MOVED_TEMP) {
	      return true;
	    } else
	      return false;
	}
	
	private void urlGet(String location) throws IOException {
		
		String uHead = location.toLowerCase().substring(0, 4);
		if(!"http".equals(uHead)){return;}
		
		try{
			tgtUrl = new URL(location);
			
			urlCon = tgtUrl.openConnection();
			
			// HTTP
			hurlCon = (HttpURLConnection)urlCon;
			hurlCon.setConnectTimeout(5000);	// 접속 제한시간 5초
			hurlCon.setReadTimeout(30000);	// 반환 제한시간 30초
			// HTTPS
			//HttpsURLConnection hurlCon = (HttpsURLConnection)urlCon;
	
			// add request header
			hurlCon.setRequestMethod("GET");
			hurlCon.setRequestProperty("User-Agent", USER_AGENT);
			
			// 기본값은 false 이고, TRUE 이면 자동으로 POST 방식으로 설정된다.
			hurlCon.setDoOutput(false);
			hurlCon.setUseCaches(false);
			hurlCon.setDefaultUseCaches(false);
			
		}catch(Exception e){
			//
			if(log.isDebugEnabled()){e.printStackTrace();}
		}
	}
	
	private void urlPost(String location) throws IOException {
		
		String uHead = location.toLowerCase().substring(0, 4);
		if(!"http".equals(uHead)){return;}
		
		try{
			tgtUrl = new URL(location);
			
			urlCon = tgtUrl.openConnection();
			
			// HTTP
			hurlCon = (HttpURLConnection)urlCon;
			hurlCon.setConnectTimeout(5000);	// 접속 제한시간 5초
			hurlCon.setReadTimeout(30000);	// 반환 제한시간 30초
			// HTTPS
			//HttpsURLConnection hurlCon = (HttpsURLConnection)urlCon;
	
			// add request header
			hurlCon.setRequestMethod("POST");
			hurlCon.setRequestProperty("User-Agent", USER_AGENT);
			
			// 기본값은 false 이고, TRUE 이면 자동으로 POST 방식으로 설정된다.
			hurlCon.setDoOutput(true);
			hurlCon.setUseCaches(false);
			hurlCon.setDefaultUseCaches(false);			
			hurlCon.setChunkedStreamingMode(0);
		}catch(Exception e){
			//
			if(log.isDebugEnabled()){e.printStackTrace();}
		}
	}	
	
	private void readContents(String encode) throws Exception{
		StringBuffer response = new StringBuffer();
		try{

			BufferedReader in = new BufferedReader(
			        new InputStreamReader(hurlCon.getInputStream(), encode));
			
			String inputLine;
			while ((inputLine = in.readLine()) != null) {
				response.append(inputLine);
				response.append("\r\n");
			}
			in.close();
			
			// 저장타입에 따라 분기
			if("TEXT".equals(this.srcSaveType)){
				Document doc = Jsoup.parse(response.toString());
				Elements body = doc.select("body");
				if(body != null && !body.isEmpty()){
					setContent(body.text());
				}else{
					setContent(response.toString());
				}
			}else{
				setContent(response.toString());
			}
		}catch(Exception e){
			//
			if(log.isDebugEnabled()){e.printStackTrace();}
			setContent(response.toString());
		}finally{
			//			
		}
	}
	
	/**
	 * url 경로의 파일을 다운로드하는 예제
	 * @param address
	 * @throws Exception
	 */
	private void getDown(String address) throws Exception{
		URL url = null;
        InputStream in = null;
        FileOutputStream out = null;
        //String address = "http://www.javachobo.com/book/src/flashjava2_src.zip";
 
        int ch = 0;
 
        try {
            url = new URL(address);
            in = url.openStream();
            out = new FileOutputStream("aaaa.zip");
 
            while ((ch = in.read()) != -1) {
                out.write(ch);
            }
            in.close();
            out.close();
 
        } catch (Exception e) {
        	if(log.isDebugEnabled()){e.printStackTrace();}
        }
	}
	
	// Regular Expression
	public List<Map<String, Object>> getRegexMap() throws Exception {
		
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		
		try{
	        String content = getContent();
	        String regex = getRegex();
	        String replaceRegex = getReplaceRegex();
	        String disptype = getDisptype();
	        String tgtFindType = getTgtFindType();
	        String tgtSaveVal = getTgtSaveVal();
			
	        //log.debug("CONTENT : " + content);
			log.debug("REGEX : " + regex);
			log.debug("REPLACEREGEX : " + replaceRegex);
			log.debug("DISPTYPE : " + disptype);
			log.debug("TGT_FIND_TYPE : " + tgtFindType);
			
			// CASE_INSENSITIVE : 대소문자 구분
			Pattern p = null;
			Matcher m = null;
			try {
				switch (tgtFindType) {
					case "REG|DOTALL":
						p = Pattern.compile(regex, Pattern.CASE_INSENSITIVE | Pattern.MULTILINE | Pattern.DOTALL);
						break;
					case "REG":
						p = Pattern.compile(regex, Pattern.CASE_INSENSITIVE | Pattern.MULTILINE);
						break;
	
					default:
						p = Pattern.compile(regex, Pattern.CASE_INSENSITIVE | Pattern.MULTILINE);
						break;
				}
				m = p.matcher(content);				
            } catch (IllegalArgumentException e) {
                log.debug("[ERROR]"+e.getMessage());
                return null;
            }
			
			Set<String> namedGroups = getNamedGroupCandidates(regex);
			
			String gName = "";
			String gValue = "";
			int idx = 0;
			Map<String, Object> map;
			while (m.find()) {
				idx++;
				
				// 그룹기호가 없거나, 출력양식이 전체결과 일 경우
				if(m.groupCount()<=0 || "MCH_ALL".equals(disptype)){
					map = new HashMap<String,Object>();
					gName = "REGEX";
					gValue = m.group();
					
					map.put(gName,gValue);   
					list.add(map);
				}	
				else
				{
					map = new HashMap<String,Object>();
					
					Iterator<String> ir = namedGroups.iterator();
					
					// 그룹기호는 있는데 그룹명이 없거나, 출력양식이 그룹기호일 경우
					if("MCH_GNO".equals(disptype) || (!ir.hasNext() && "MCH_GNM".equals(disptype)))
					{
						for(int i = 0; i<m.groupCount() ; i++) {
							try {
			                	gName = "$" + (i+1);
			                	gValue = m.group(i+1);
			                	map.put(gName,gValue);
			                	log.debug("[" + idx + "]row, group[" + (i+1) + "] " + gValue);
			                } catch (IllegalArgumentException e) {
			                    log.debug("group parsing error!!!");
			                }
						}
					}
					// 그룹명이 있거나, 출력양식이 그룹명일 경우
					if(ir.hasNext() && "MCH_GNM".equals(disptype))
					{	// exist group name (?<groupname>...) 
						while (ir.hasNext()) {
			                try {
			                	gName = ir.next();
			                	gValue = m.group(gName);			                	
			                	gValue = getGrpReplace(gValue, gName, replaceRegex);
			                	
			                	map.put(gName,gValue);			                	
			                	log.debug("[" + idx + "]row, group[" + gName + "] " + gValue);
			                } catch (IllegalArgumentException e) {
			                    ir.remove();
			                }
						}
					}
					list.add(map);
				}		
				
				/*
				for(int i = 0; i<m.groupCount() ; i++) {
					log.debug("[" + idx + "]row, group[" + i + "].Name[" + 1 + "] " + m.group(i));
				}
				*/
		    }
			
			// 찾은 결과가 없고, NULL 대체가 있을때.
			if(idx == 0 && tgtSaveVal !=null && !tgtSaveVal.isEmpty()){
				Set<String> saveGrp = getNamedSaveGrp(tgtSaveVal);	
				Iterator<String> irSaveGrp = saveGrp.iterator();
				if(irSaveGrp.hasNext())
				{ 
					String sName = "";
					String sValue = "";
					map = new HashMap<String,Object>();
					while (irSaveGrp.hasNext()) {
		                try {
		                	sName = irSaveGrp.next();		                	
		                	sValue = getSaveReplace(sName, tgtSaveVal);
		                	
		                	if("$SRCURL$".equals(sValue)){
		                		sValue = getUrl();
		                	}
		                	map.put(sName,sValue);
		                	log.debug("group[" + sName + "] " + sValue);
		                } catch (IllegalArgumentException e) {
		                	irSaveGrp.remove();
		                }
					}
					list.add(map);			                	
				}
			}
			
		}catch(Exception e){
			if(log.isDebugEnabled()){e.printStackTrace();}
		}
		return list;
	}
	
	private String getGrpReplace(String src, String gName, String regexs){
        /*
         * 교체패턴문자열에서 "{$그룹명}" 패턴의 그룹명을 배열로 반환
         * 예) Replace  예시 : <$그룹명>{repMatch}:{repValue}</$그룹명><$그룹명>{repMatch}:{repValue}</$그룹명>
         * 예) <$productname>{<i class="best">.*?</i>\s*(.+)}:{$1}</$productname>
         * 예) Unescape 예시 : <$그룹명>{repMatch}:{[UNESCAPE]repValue}</$그룹명><$그룹명>{repMatch}:{repValue}</$그룹명>
         * 예) <$productname>{<i class="best">.*?</i>\s*(.+)}:{[UNESCAPTE]$1}</$productname>
        */
		
		String sRtn = src;
		
		if(regexs == null || regexs.isEmpty()){return sRtn;}
		
		Matcher m = null;
		try {
			m = Pattern.compile("\\<\\$" + gName + ">\\{(.+?)\\}\\:\\{(.+?)\\}<\\/\\$" + gName +  ">").matcher(regexs);				
        } catch (IllegalArgumentException e) {
            log.debug("[ERROR]"+e.getMessage());
            return sRtn;
        }

        while (m.find()) {
        	log.debug("getGrpReplace(), " + m.group(1) + ", " + m.group(2));
        	sRtn = sRtn.replaceAll(m.group(1), m.group(2));
        }
		
		return sRtn;
	}
	
	private String getSaveReplace(String gName, String regexs){
        /*
         * NULL 대체 값 
         * 예) 예시 : <$그룹명>값1</$그룹명><$그룹명>값2</$그룹명>
        */
		
		String sRtn = "";
		
		if(regexs == null || regexs.isEmpty()){return sRtn;}
		
		Matcher m = null;
		try {
			m = Pattern.compile("\\<\\$" + gName + ">(.*?)<\\/\\$" + gName +  ">").matcher(regexs);				
        } catch (IllegalArgumentException e) {
            log.debug("[ERROR]"+e.getMessage());
            return sRtn;
        }

        while (m.find()) {
        	log.debug("getSaveReplace(), " + m.group(1));
        	sRtn = m.group(1);
        }
		
		return sRtn;
	}
	
	private static Set<String> getNamedGroupCandidates(String regex) {
        Set<String> namedGroups = new TreeSet<String>();

        Matcher m = Pattern.compile("\\(\\?<([a-zA-Z][a-zA-Z0-9]*)>").matcher(regex);

        while (m.find()) {
            namedGroups.add(m.group(1));
        }

        return namedGroups;
    }
	
	private static Set<String> getNamedSaveGrp(String regex) {
        Set<String> namedGroups = new TreeSet<String>();

        Matcher m = Pattern.compile("\\<\\$([a-zA-Z][a-zA-Z0-9]*)>").matcher(regex);

        while (m.find()) {
            namedGroups.add(m.group(1));
        }

        return namedGroups;
    }
}
