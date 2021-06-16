package com.gjw.config;

import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        if (request.getRequestURI().contains("checkAcc")||request.getRequestURI().contains("checkPwd")||request.getRequestURI().contains("checkVerify")) {
//            System.err.println(request.getRequestURI());
            return true;
        }


        if (request.getRequestURI().contains("login")) {
//            System.err.println(request.getRequestURI());
            return true;
        }

        if (request.getSession().getAttribute("adminLoginInfo") != null) {
//            System.out.println(request.getRequestURI());
            return true;
        }

        if (request.getRequestURI().contains("loginOut")) {
//            System.err.println(request.getRequestURI() + "-->out");
            return true;
        }

        if (request.getRequestURI().contains("verify")) {
            return true;
        }
        System.err.println("被拦截了");
        request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);
        return false;


    }
}
