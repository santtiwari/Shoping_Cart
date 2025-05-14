package com.ecom.Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

public class CommonServiceImpl implements CommonService {

	@Override
	public void removeSessionMessage() {
	HttpServletRequest request = ((ServletRequestAttributes)(RequestContextHolder.getRequestAttributes())).getRequest();
	HttpSession session = request.getSession();
	session.removeAttribute("succMsg");
	session.removeAttribute("errorMsg");
	}

}
