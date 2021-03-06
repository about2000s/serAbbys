package com.itbank.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

// 인터셉터 : 특정 주소에 대한 요청을 가로채서 사전 작업/사후 작업을 수행하는 객체(servlet-context.xml)
// 필터 : 모든 요청에 대해 공통 작업을 수행하는 객체(web.xml)
// web.xml 에 의해서 DispatcherServlet으로 요청이 넘어가고, @Controller 이전에 Interceptor가 작동

public class LoginInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		
		if(session.getAttribute("login") == null) {
			response.sendRedirect(request.getContextPath() + "/common/login");
			return false;	// 컨트롤러의 메서드를 진행시키지 않는다
		}
		return true;		// 예정대로 컨트롤러의 메서드를 진행시킨다
		
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
	}
	
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
	}
	
}







