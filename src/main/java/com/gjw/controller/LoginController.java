package com.gjw.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class LoginController {

    @RequestMapping("/main")
    public String main() {

        return "main";
    }

    @RequestMapping("/toLogin")
    public String toLogin(HttpSession session) {
        if (session.getAttribute("userLoginInfo")!=null){
            return "main";
        }
        return "login";
    }

    @RequestMapping("/login")
    public String login(HttpSession session, String acc, String pwd) {
        if (acc.equals("1") && pwd.equals("1")) {
            session.setAttribute("userLoginInfo", acc);
            return "main";
        }
        return "login";
    }

    @RequestMapping("/loginOut")
    public String loginOut(HttpSession session) {
        session.removeAttribute("userLoginInfo");

        return "login";
    }


}
