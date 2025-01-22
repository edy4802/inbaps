package inbaps.cbap.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

public class CustomUserDetails implements UserDetails   {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String userId;
    private String userPw;
    private String userAs;
    private String userNm;
    private String siteUrl;
    private String siteTit;
    private String mainLogoUrl;
    private String mainTit;
    private String cbapLogoUrl;
    private String cbapTit;
	private String rbapLogoUrl;
    private String rbapTit;
    private String vbapLogoUrl;
    private String vbapTit;
    
    private String rolegroup = "ROLE_USER";
	
    public String getSiteUrl() {
		return siteUrl;
	}

	public void setSiteUrl(String siteUrl) {
		this.siteUrl = siteUrl;
	}

	public String getSiteTit() {
		return siteTit;
	}

	public void setSiteTit(String siteTit) {
		this.siteTit = siteTit;
	}

	public String getMainLogoUrl() {
		return mainLogoUrl;
	}

	public void setMainLogoUrl(String mainLogoUrl) {
		this.mainLogoUrl = mainLogoUrl;
	}

	public String getMainTit() {
		return mainTit;
	}

	public void setMainTit(String mainTit) {
		this.mainTit = mainTit;
	}

	public String getCbapLogoUrl() {
		return cbapLogoUrl;
	}

	public void setCbapLogoUrl(String cbapLogoUrl) {
		this.cbapLogoUrl = cbapLogoUrl;
	}

	public String getCbapTit() {
		return cbapTit;
	}

	public void setCbapTit(String cbapTit) {
		this.cbapTit = cbapTit;
	}

	public String getRbapLogoUrl() {
		return rbapLogoUrl;
	}

	public void setRbapLogoUrl(String rbapLogoUrl) {
		this.rbapLogoUrl = rbapLogoUrl;
	}

	public String getRbapTit() {
		return rbapTit;
	}

	public void setRbapTit(String rbapTit) {
		this.rbapTit = rbapTit;
	}

	public String getVbapLogoUrl() {
		return vbapLogoUrl;
	}

	public void setVbapLogoUrl(String vbapLogoUrl) {
		this.vbapLogoUrl = vbapLogoUrl;
	}

	public String getVbapTit() {
		return vbapTit;
	}

	public void setVbapTit(String vbapTit) {
		this.vbapTit = vbapTit;
	}

	public void setRolegroup(String rolegroup) {
		this.rolegroup = rolegroup;
	}
	
    public CustomUserDetails(String userId, String userPw, String rolegroup, String userAs, String userNm, String siteUrl,String siteTit,String mainLogoUrl,String mainTit,String cbapLogoUrl,String cbapTit,String rbapLogoUrl,String rbapTit,String vbapLogoUrl,String vbapTit)
    {
    	this.userId = userId;
    	this.userPw = userPw;
    	this.rolegroup = rolegroup;
    	this.userAs = userAs;
    	this.userNm = userNm;
    	this.siteUrl = siteUrl;
    	this.siteTit = siteTit;
    	this.mainLogoUrl = mainLogoUrl;
    	this.mainTit = mainTit;
    	this.cbapLogoUrl = cbapLogoUrl;
    	this.cbapTit = cbapTit;
    	this.rbapLogoUrl = rbapLogoUrl;
    	this.rbapTit = rbapTit;
    	this.vbapLogoUrl = vbapLogoUrl;
    	this.vbapTit = vbapTit;
    	
    }
    
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();    
        authorities.add(new SimpleGrantedAuthority(this.rolegroup));
        
        return authorities;
	}

	public String getUserPw() {
		return userPw;
	}

	public String getUserId() {
		return userId;
	}
	
	public String getRolegroup() {
		return rolegroup;
	}
	
	public String getUserAs() {
		return userAs;
	}
	
	public String getUserNm() {
		return userNm;
	}

	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public boolean isEnabled() {
		return true;
	}

	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return userPw;
	}

	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return userId;
	}
}
