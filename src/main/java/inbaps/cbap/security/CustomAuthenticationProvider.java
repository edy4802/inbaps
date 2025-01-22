package inbaps.cbap.security;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

import inbaps.cbap.service.CbapService;

public class CustomAuthenticationProvider implements AuthenticationProvider  {
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="cbapService")
    private CbapService cbapService;
	
    @Override
    public boolean supports(Class<?> authentication) {
        return authentication.equals(UsernamePasswordAuthenticationToken.class);
    }

	@Override
	public Authentication authenticate(Authentication authentication)
			throws AuthenticationException {
		
		String user_id = (String)authentication.getPrincipal();		
		String user_pw = (String)authentication.getCredentials();
		
		
		log.info("Welcome authenticate! {" + user_id + "/" + user_pw + "}");
		
		// check whether user's credentials are valid.
		// if false, throw new BadCredentialsException(messages.getMessage("AbstractUserDetailsAuthenticationProvider.badCredentials", "Bad credentials"));
		
    	Map<String, Object> map = new HashMap<String,Object>();
    	map.put("USR_ID", user_id);
    	map.put("USR_PW", user_pw);
		
    	String loginYn = "";
    	String roleGrp = "";
    	String usrId = "";
    	String usrAs = "";
    	String usrNm = "";
    	String siteUrl = "";
    	String siteTit = "";
    	String mainLogoUrl = "";
    	String mainTit = "";
    	String cbapLogoUrl = "";
    	String cbapTit = "";
    	String rbapLogoUrl = "";
    	String rbapTit = "";
    	String vbapLogoUrl = "";
    	String vbapTit = "";
    	List<Map<String, Object>> list;
		try {
			list = cbapService.selectLogin(map);
			
			for(Map<String, Object> mem : list) {
	        	if(mem.containsKey("LOGIN_YN")){
	        		loginYn = (String)mem.get("LOGIN_YN");
	        	}	
	        	if(mem.containsKey("ROLE_GRP")){
	        		roleGrp = (String)mem.get("ROLE_GRP");
	        	}
	        	if(mem.containsKey("USR_ID")){
	        		usrId = (String)mem.get("USR_ID");
	        	}
	        	if(mem.containsKey("USR_AS")){
	        		usrAs = (String)mem.get("USR_AS");
	        	}
	        	if(mem.containsKey("USR_NM")){
	        		usrNm = (String)mem.get("USR_NM");
	        	}
	        	
	        	if(mem.containsKey("SITE_URL")){
	        		siteUrl = String.valueOf(mem.get("SITE_URL"));
	        	}
	        	if(mem.containsKey("SITE_TIT")){
	        		siteTit = String.valueOf(mem.get("SITE_TIT"));
	        	}
	        	if(mem.containsKey("MAIN_LOGO_URL")){
	        		mainLogoUrl = String.valueOf(mem.get("MAIN_LOGO_URL"));
	        	}
	        	if(mem.containsKey("MAIN_TIT")){
	        		mainTit = String.valueOf(mem.get("MAIN_TIT"));
	        	}
	        	if(mem.containsKey("CBAP_LOGO_URL")){
	        		cbapLogoUrl = String.valueOf(mem.get("CBAP_LOGO_URL"));
	        	}
	        	if(mem.containsKey("CBAP_TIT")){
	        		cbapTit = String.valueOf(mem.get("CBAP_TIT"));
	        	}
	        	if(mem.containsKey("RBAP_LOGO_URL")){
	        		rbapLogoUrl = String.valueOf(mem.get("RBAP_LOGO_URL"));
	        	}
	        	if(mem.containsKey("RBAP_TIT")){
	        		rbapTit = String.valueOf(mem.get("RBAP_TIT"));
	        	}
	        	if(mem.containsKey("VBAP_LOGO_URL")){
	        		vbapLogoUrl = String.valueOf(mem.get("VBAP_LOGO_URL"));
	        	}
	        	if(mem.containsKey("VBAP_TIT")){
	        		vbapTit = String.valueOf(mem.get("VBAP_TIT"));
	        	}
	        }
		} catch (Exception e) {
			// TODO Auto-generated catch block
			if(log.isDebugEnabled()){e.printStackTrace();}
		}
        
        if("Y".equals(loginYn)){
        	log.info("Welcome authenticate success! {" + user_id + "/" + user_pw + "}");
    		List<GrantedAuthority> roles = new ArrayList<GrantedAuthority>();
            roles.add(new SimpleGrantedAuthority(roleGrp));
            UsernamePasswordAuthenticationToken result = new UsernamePasswordAuthenticationToken(usrId, user_pw, roles);
            result.setDetails(new CustomUserDetails(usrId, user_pw, roleGrp, usrAs, usrNm, siteUrl, siteTit, mainLogoUrl, mainTit, cbapLogoUrl, cbapTit, rbapLogoUrl, rbapTit, vbapLogoUrl, vbapTit));
            return result;
        }else{
        	log.info("Welcome authenticate failed! {" + user_id + "/" + user_pw + "}");
        	throw new BadCredentialsException("");
        }
	}
}
