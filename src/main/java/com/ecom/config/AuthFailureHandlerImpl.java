package com.ecom.config;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import com.ecom.Model.UserDtls;
import com.ecom.Repositry.UserRepository;
import com.ecom.Service.UserService;
import com.ecom.util.AppConstant;

@Component
public class AuthFailureHandlerImpl extends SimpleUrlAuthenticationFailureHandler {

	@Autowired
	private UserRepository userRepository;

	@Autowired
    private UserService userService;
	
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		
		String email = request.getParameter("username");//loginjsp
		
		UserDtls userDtls = userRepository.findByEmail(email);
		if(userDtls != null) {
		
		if(userDtls.getIsEnable()) {
			
			if(userDtls.getAccountNonLocked()) {
				
				if(userDtls.getFailedAttempt()<AppConstant.ATTEMPT_TIME)
				{
					userService.increaseFailedAttempt(userDtls);
				}else {
					userService.userAccountLock(userDtls);
					exception = new LockedException("Your account is locked || failed attempt 3");
				}
			}else {
				if(userService.unlockAccountTimeExpired(userDtls))
				{
					exception = new LockedException("Your account is Unlocked || Please try to login");
				}else {
				exception = new LockedException("your account is Locked || Please try after sometimes");
				}
			}
			
		}else {
			exception = new LockedException("your account is inactive");
		}
		}else {
			exception = new LockedException("Email & Password is invalid");
		}
		super.setDefaultFailureUrl("/signin?error"); // redirect back to login page
		super.onAuthenticationFailure(request, response, exception);
	}

}
