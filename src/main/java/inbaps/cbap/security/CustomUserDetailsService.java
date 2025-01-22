package inbaps.cbap.security;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.StandardPasswordEncoder;

public class CustomUserDetailsService implements UserDetailsService   {
	@Override
	public UserDetails loadUserByUsername(String userId)
			throws UsernameNotFoundException {
		
		StandardPasswordEncoder encoder = new StandardPasswordEncoder();
		String passwordFromDatabase = encoder.encode("aa");
        
        return new CustomUserDetails(userId, passwordFromDatabase, "ROLE_USER", "", "", "", "", "", "", "", "", "", "", "", "");
	}
}
