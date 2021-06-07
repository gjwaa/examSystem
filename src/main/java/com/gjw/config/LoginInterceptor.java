package com.gjw.config;

import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {


        if (request.getRequestURI().contains("login")){
            System.err.println(request.getRequestURI());
            return true;
        }

        if (request.getSession().getAttribute("userLoginInfo")!=null){
            System.out.println(request.getRequestURI());
            return true;
        }

        if (request.getRequestURI().equals("loginOut")){
            System.err.println(request.getRequestURI()+"-->out");
            return true;
        }

        request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request,response);
        return false;
    }
}
