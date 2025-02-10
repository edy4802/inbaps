/*
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
■ 파일명 : CommonOpenApi
■ 기능명 : OPEN API 클래스
■ 설   명 : OPEN API 수집을 위한 기능 클래스
■ 작성자 : (주)인아이티 SI사업부 
■ 작성일 : 2016.03.21 : 최초작성
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
*/
package inbaps.cbap.openapi;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.net.ssl.HttpsURLConnection;
import javax.xml.namespace.NamespaceContext;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;

import org.apache.log4j.Logger;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import inbaps.cbap.spider.CommonSpider;

public class CommonOpenApi {
	Logger log = Logger.getLogger(this.getClass());
	
    private String url = "";
    private String method = "";
    private String format = "";
    private String content = "";
    private Map<String,Object> mapUrlParam = new HashMap<String,Object>();
    private Map<String,Object> mapRequestParam = new HashMap<String,Object>();    
    
	private final String USER_AGENT = "Mozilla/5.0";
	
	private URL tgtUrl = null;
	private URLConnection urlCon = null;
	private HttpURLConnection hurlCon = null;
	private HttpsURLConnection hsurlCon = null;
	
	private static CommonSpider cSpider = new CommonSpider();
    
	public static void main(String[] args) throws Exception {

	}
	
	public Map<String,Object> getMapRequestParam(){
        return mapRequestParam;
    }
	
	public void setRequestParam(Map<? extends String, ?extends Object> m){
		mapRequestParam.putAll(m);
    }
	
	public Map<String,Object> getMapUrlParam(){
        return mapUrlParam;
    }
	
	public void setUrlParam(Map<? extends String, ?extends Object> m){
		mapUrlParam.putAll(m);
    }
	
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	public String getMethod() {
		return method;
	}

	public void setMethod(String method) {
		this.method = method;
	}
	
	public String getFormat() {
		return format;
	}

	public void setFormat(String format) {
		this.format = format;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}
	
	// HTTP GET request
	public void sendRequest() throws Exception {

		String url = getUrl();
		String method = getMethod();
		String format = getFormat();
		boolean bHttps = false;
		
		if(url == null || url.isEmpty() || url == ""){return;}
		
		String uHead = url.toLowerCase().substring(0, 6);
		if("https:".equals(uHead)){bHttps = true;}
		
		try{
			
			if(bHttps)
			{
				urlsGetPost(url, method, format);
				if(format.equals("XML")) readHttpsXml("UTF-8");
				else if(format.equals("JSON")) readHttpsJson("UTF-8");
			}
			else
			{
				urlGetPost(url, method, format);
				if(format.equals("XML")) readHttpXml("UTF-8");
				else if(format.equals("JSON")) readHttpJson("UTF-8");
			}
			
		}catch(Exception e){
			if(log.isDebugEnabled()){e.printStackTrace();}
		}finally{
			if(bHttps)
			{
				hsurlCon.disconnect();
			}else{
				hurlCon.disconnect();
			}
		}
	}
	
	public Map<String,Object> getXmlNode(List<Map<String,Object>> lstOup, final String xmlPrefix, final String xmlNamespaceuri) throws Exception {
		Map<String,Object> xmlNode = new HashMap<String,Object>();
		
		String oupId = "";
		String oupDiv = "";
   		String oupType = "";
        String oupExp = "";
        String oupKey = "";
        String oupType2 = "";
        String xmlKey = "";
        String xmlVal = "";
        
        List<Map<String,Object>> itemRoot = new ArrayList<Map<String,Object>>();
        List<Map<String,Object>> itemList = new ArrayList<Map<String,Object>>();
        Map<String,Object> keyNode = new HashMap<String,Object>();
        Document xmlDocment = initialize(getContent());
        XPath xPath =  XPathFactory.newInstance().newXPath();
        
        NamespaceContext ctx = new NamespaceContext() {
            public String getNamespaceURI(String prefix) {
                return prefix.equals(xmlPrefix) ? xmlNamespaceuri : null; 
            }
            public Iterator getPrefixes(String val) {
                return null;
            }
            public String getPrefix(String uri) {
                return null;
            }
        };
        xPath.setNamespaceContext(ctx);
        NodeList nodeList = null;
        NodeList subNodeList = null;
        
        for(Map<String, Object> oupMap : lstOup){
        	if(oupMap.containsKey("OUP_DIV")) 
        	{
   				oupDiv = (String)oupMap.get("OUP_DIV");
        	}else{
        		oupDiv = "";
        	}
        	if(oupMap.containsKey("OUP_KEY")) 
        	{
        		oupKey = (String)oupMap.get("OUP_KEY");
        	}else{
        		oupKey = "";
        	}
        	if(oupMap.containsKey("OUP_TYPE")) 
        	{
        		oupType = (String)oupMap.get("OUP_TYPE");
        	}else{
        		oupType = "";
        	}
        	if("ITEMKEY".equals(oupDiv)){
        		keyNode.put(oupKey, oupType);
        	}
        }
		for(Map<String, Object> oupMap : lstOup){
			if(oupMap.containsKey("OUP_ID")) 
        	{
        		oupId = (String)oupMap.get("OUP_ID");
        	}else{
        		oupId = "";
        	}
			if(oupMap.containsKey("OUP_KEY")) 
        	{
        		oupKey = (String)oupMap.get("OUP_KEY");
        	}else{
        		oupKey = "";
        	}
        	if(oupMap.containsKey("OUP_EXP")) 
        	{
        		oupExp = (String)oupMap.get("OUP_EXP");
        	}else{
        		oupExp = "";
        	}
   			if(oupMap.containsKey("OUP_DIV")) 
        	{
   				oupDiv = (String)oupMap.get("OUP_DIV");
        	}else{
        		oupDiv = "";
        	}
        	
        	if("ROOT".equals(oupDiv)){
        		xmlNode.put("ROOT_OUP_ID", oupId);
        		if(oupExp != "" && xmlDocment != null)
        		{
	        		nodeList = (NodeList) xPath.compile(oupExp).evaluate(xmlDocment, XPathConstants.NODESET);
	        		for (int i = 0; null!=nodeList && i < nodeList.getLength(); i++) {
	        		    Map<String, Object> map = new HashMap<String,Object>();
	        			subNodeList = nodeList.item(i).getChildNodes();
	        			for (int j = 0;null!=subNodeList && j < subNodeList.getLength(); j++) {
	        				Node nod = subNodeList.item(j);
	        				if(nod.getNodeType() == Node.ELEMENT_NODE){
	        					xmlKey = oupKey +"." +nod.getNodeName();
	        					if(null!=nod.getFirstChild()){
		        					xmlVal = nod.getFirstChild().getNodeValue();
		        					if(keyNode.containsKey(xmlKey)){
		        						oupType2 = (String)keyNode.get(xmlKey);
		        						if("TIME_URL".equals(oupType2)){
		        					        cSpider.setUrl(xmlVal);
		        					        cSpider.setSrcEncode("AUTO");
		        					        cSpider.setSrcEncodeDefalut("EUC-KR");
		        					        cSpider.setSrcSaveType("TEXT");
		        					        cSpider.setContent("");
		        					        cSpider.sendGet();
		        					        xmlVal = cSpider.getRealUrl();
		        					        map.put(xmlKey + ".contents", cSpider.getContent());
		        						}
		        						map.put(xmlKey, xmlVal);
		        					}
	        					}
	        				} 
	        			}
	        			itemRoot.add(map);
	        		}
        		}
        	}else if("LIST".equals(oupDiv)){
        		xmlNode.put("LIST_OUP_ID", oupId);
        		if(oupExp != "" && xmlDocment != null)
        		{
	        		nodeList = (NodeList) xPath.compile(oupExp).evaluate(xmlDocment, XPathConstants.NODESET);
	        		for (int i = 0; null!=nodeList && i < nodeList.getLength(); i++) {
	        		    Map<String, Object> map = new HashMap<String,Object>();
	        			subNodeList = nodeList.item(i).getChildNodes();
	        			for (int j = 0;null!=subNodeList && j < subNodeList.getLength(); j++) {
	        				Node nod = subNodeList.item(j);
	        				if(nod.getNodeType() == Node.ELEMENT_NODE){
	        					xmlKey = oupKey +"." +nod.getNodeName();
	        					if(null!=nod.getFirstChild()){
		        					xmlVal = nod.getFirstChild().getNodeValue();
		        					if(keyNode.containsKey(xmlKey)){
		        						oupType2 = (String)keyNode.get(xmlKey);
		        						if("TIME_URL".equals(oupType2)){
		        							cSpider.setUrl(xmlVal);	        					        
		        					        cSpider.setSrcEncode("AUTO");
		        					        cSpider.setSrcEncodeDefalut("EUC-KR");
		        					        cSpider.setSrcSaveType("TEXT");
		        					        cSpider.setContent("");
		        					        cSpider.sendGet();
		        					        xmlVal = cSpider.getRealUrl();
		        					        map.put(xmlKey + ".contents", cSpider.getContent());
		        						}
		        						map.put(xmlKey, xmlVal);
		        					}
	        					}
	        				} 
	        			}
	        			itemList.add(map);
	        		}
        		}
        	}
        }
		
		xmlNode.put("ROOT", itemRoot);
		xmlNode.put("LIST", itemList);
		return xmlNode;
	}
	
	protected Document initialize(String xml)throws Exception{
		Document xmlDocment = null;
		
		if(null==xml || xml.isEmpty()){return null;}
		InputSource is = new InputSource(new StringReader(xml));
		if(format.equals("XML")) {
			DocumentBuilderFactory docBuildFact = DocumentBuilderFactory.newInstance();
			DocumentBuilder docBuild = docBuildFact.newDocumentBuilder();
			xmlDocment = docBuild.parse(is);
		} else if(format.equals("JSON")) {
			
		}
		
		return xmlDocment;
	}
	
	private void urlGetPost(String url, String method, String format) throws IOException {
		
		String urlParam = "";
		Map<String,Object> mapUrlParam = getMapUrlParam();
		Map<String,Object> mapRequestParam = getMapRequestParam();		
		
		if(mapUrlParam != null)
		{
			for( String key : mapUrlParam.keySet() ){
	            
				//java.net.URLEncoder.encode(seacrhkey,"UTF-8")
	            if(urlParam == ""){
	            	urlParam += key + "=" + (String)mapUrlParam.get(key);	
	            }else{
	            	urlParam += "&" + key + "=" + (String)mapUrlParam.get(key);
	            }
	        }
		}
		
		if("GET".equals(method)){
			url = url + "?" + urlParam;
		}
		
		tgtUrl = new URL(url);
		
		urlCon = tgtUrl.openConnection();
		
		// HTTP
		hurlCon = (HttpURLConnection)urlCon;
		hurlCon.setConnectTimeout(5000);	// 접속 제한시간 5초
		hurlCon.setReadTimeout(30000);	// 반환 제한시간 30초

		// add request header
		hurlCon.setRequestMethod(method);
		//format = XML/JSON
		String applicationFormat = "application/xml";
		if(format.equals("JSON")) applicationFormat = "application/json";
		hurlCon.setRequestProperty("Content-Type", applicationFormat);
		hurlCon.setRequestProperty("User-Agent", USER_AGENT);
		
		for( String key : mapRequestParam.keySet() ){
			log.debug("RequestProperty(" + key + "," + (String)mapRequestParam.get(key) + ")");
			hurlCon.setRequestProperty(key, (String)mapRequestParam.get(key));			
        }
		// 기본값은 false 이고, TRUE 이면 자동으로 POST 방식으로 설정된다.
		if("GET".equals(method)){
			hurlCon.setDoOutput(false);
			hurlCon.setUseCaches(false);
			hurlCon.setDefaultUseCaches(false);
		}else{
			hurlCon.setDoOutput(true);
			DataOutputStream wr = new DataOutputStream(hurlCon.getOutputStream());
			wr.writeBytes(urlParam);
			wr.flush();
			wr.close();	
		}
	}
	
	private void urlsGetPost(String url, String method, String format) throws IOException {
		
		String urlParam = "";
		Map<String,Object> mapUrlParam = getMapUrlParam();
		Map<String,Object> mapRequestParam = getMapRequestParam();		
		
		if(mapUrlParam != null)
		{
			for( String key : mapUrlParam.keySet() ){
	            
				//java.net.URLEncoder.encode(seacrhkey,"UTF-8")
	            if(urlParam == ""){
	            	urlParam += key + "=" + (String)mapUrlParam.get(key);	
	            }else{
	            	urlParam += "&" + key + "=" + (String)mapUrlParam.get(key);
	            }
	        }
		}
		if("GET".equals(method)){
			url = url + "?" + urlParam;
		}
		
		tgtUrl = new URL(url);
		
		urlCon = tgtUrl.openConnection();
		
		// HTTPS
		hsurlCon = (HttpsURLConnection)urlCon;
		hsurlCon.setConnectTimeout(5000);	// 접속 제한시간 5초
		hsurlCon.setReadTimeout(30000);	// 반환 제한시간 30초
		// HTTPS
		

		// add request header
		hsurlCon.setRequestMethod(method);
		//format = XML/JSON
		String applicationFormat = "application/xml";
		if(format.equals("JSON")) applicationFormat = "application/json";
		hsurlCon.setRequestProperty("Content-Type", applicationFormat);
		hsurlCon.setRequestProperty("User-Agent", USER_AGENT);
		
		for( String key : mapRequestParam.keySet() ){
			log.debug("RequestProperty(" + key + "," + (String)mapRequestParam.get(key) + ")");
			hsurlCon.setRequestProperty(key, (String)mapRequestParam.get(key));			
        }
		// 기본값은 false 이고, TRUE 이면 자동으로 POST 방식으로 설정된다.
		if("GET".equals(method)){
			hsurlCon.setDoOutput(false);
			hsurlCon.setUseCaches(false);
			hsurlCon.setDefaultUseCaches(false);
		}else{
			hsurlCon.setDoOutput(true);
			DataOutputStream wr = new DataOutputStream(hsurlCon.getOutputStream());
			wr.writeBytes(urlParam);
			wr.flush();
			wr.close();	
		}
	}
	
	private void readHttpXml(String encode) throws Exception{
		BufferedReader in = new BufferedReader(
		        new InputStreamReader(hurlCon.getInputStream(), encode));
		StringBuffer response = new StringBuffer();
		
		String inputLine;
		while ((inputLine = in.readLine()) != null) {
			response.append(inputLine);
			response.append("\r\n");
		}
		in.close();
		
		setContent(response.toString());
	}
	
	private void readHttpsXml(String encode) throws Exception{
		BufferedReader in = new BufferedReader(
		        new InputStreamReader(hsurlCon.getInputStream(), encode));
		StringBuffer response = new StringBuffer();
		
		String inputLine;
		while ((inputLine = in.readLine()) != null) {
			response.append(inputLine);
			response.append("\r\n");
		}
		in.close();
		
		setContent(response.toString());
	}
	
	private void readHttpJson(String encode) throws Exception{
		BufferedReader in = new BufferedReader(
		        new InputStreamReader(hurlCon.getInputStream(), encode));
		StringBuilder response = new StringBuilder();
		
		String inputLine;
		while ((inputLine = in.readLine()) != null) {
			
		}
		in.close();
		setContent(response.toString());
	}
	
	private void readHttpsJson(String encode) throws Exception{
		BufferedReader in = new BufferedReader(
		        new InputStreamReader(hsurlCon.getInputStream(), encode));
		StringBuilder response = new StringBuilder();
		
		String inputLine;
		while ((inputLine = in.readLine()) != null) {
			response.append(inputLine);
		}
		in.close();
		setContent(response.toString());
	}
	
	public Map<String,Object> getJsonNode(List<Map<String,Object>> lstOup) throws Exception {
		Map<String,Object> jsonNode = new HashMap<String,Object>();
		JSONObject result = null;
		
		String oupId = "";
		String oupDiv = "";
   		String oupType = "";
        String oupExp = "";
        String oupKey = "";
        String oupType2 = "";
        String xmlKey = "";
        String xmlVal = "";
		
		List<Map<String,Object>> itemRoot = new ArrayList<Map<String,Object>>();
        List<Map<String,Object>> itemList = new ArrayList<Map<String,Object>>();
        Map<String,Object> keyNode = new HashMap<String,Object>();
		
		String content = getContent();
        result = (JSONObject) new JSONParser().parse(content);
        
        for(Map<String, Object> oupMap : lstOup){
        	if(oupMap.containsKey("OUP_DIV")) 
        	{
   				oupDiv = (String)oupMap.get("OUP_DIV");
        	}else{
        		oupDiv = "";
        	}
        	if(oupMap.containsKey("OUP_KEY")) 
        	{
        		oupKey = (String)oupMap.get("OUP_KEY");
        	}else{
        		oupKey = "";
        	}
        	if(oupMap.containsKey("OUP_TYPE")) 
        	{
        		oupType = (String)oupMap.get("OUP_TYPE");
        	}else{
        		oupType = "";
        	}
        	if("ITEMKEY".equals(oupDiv)){
        		keyNode.put(oupKey, oupType);
        	}
        }
		
		return jsonNode;
	}
}
