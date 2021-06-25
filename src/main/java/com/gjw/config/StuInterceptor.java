package com.gjw.config;

import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @version 1.0
 * @author: gjw
 * @date: 2021/6/25 11:57
 * @desc:
 */
public class StuInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        if (request.getSession().getAttribute("stuCheckInfo") == null) {
            return true;
        }
        request.getRequestDispatcher("/WEB-INF/jsp/stu/waitExam.jsp").forward(request, response);
        return false;
    }
}
