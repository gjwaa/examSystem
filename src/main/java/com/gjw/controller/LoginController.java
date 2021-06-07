package com.gjw.controller;


import com.gjw.utils.DrawVerify;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.PrintWriter;

@Controller
@RequestMapping("/admin")
@PropertySource("classpath:adminInfo.properties")
public class LoginController {

    @Value("${adminAcc}")
    private String adminAcc;

    @Value("${adminPwd}")
    private String adminPwd;

    @RequestMapping("/main")
    public String main() {

        return "main";
    }

    @RequestMapping("/login")
    public String login(HttpSession session, String acc,String pwd,String clientVerify) {
//        System.out.println("===>"+adminAcc+adminPwd);
        String serviceVerify = (String) session.getAttribute("serviceVerify");
        System.err.println("server："+serviceVerify+"***"+"client:"+clientVerify);
        if (acc.equals(adminAcc) && pwd.equals(adminPwd) && clientVerify.equals(serviceVerify)) {
            session.setAttribute("adminLoginInfo", acc);
            System.out.println("adminLoginInfo===>" + session.getAttribute("adminLoginInfo"));
            return "main";
        }
        return "login";
    }

    @RequestMapping("/loginOut")
    public String loginOut(HttpSession session) {
        session.removeAttribute("adminLoginInfo");

        return "login";
    }

    @RequestMapping("/verify")
    public void verify(HttpServletResponse response, HttpSession session) throws IOException {
        response.setContentType("image/jpeg");
        BufferedImage img = new BufferedImage(100, 30, BufferedImage.TYPE_INT_RGB);
        Graphics g = img.getGraphics();
        String verify = DrawVerify.drawVerify(g);
        System.out.println("verify===>" + verify);
        session.setAttribute("serviceVerify", verify);
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Cache-Control", "no-cache");
        ImageIO.write(img, "JPG", response.getOutputStream());
    }

    @RequestMapping("/checkAcc")
    public void checkAcc(HttpServletResponse response,String acc) throws IOException {
        response.setContentType("text/text;charset=utf-8");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        if (adminAcc.equals(acc)){
            out.print("accPass");
        }else {
            out.print("accUnPass");
        }
    }

    @RequestMapping("/checkPwd")
    public void checkPwd(HttpServletResponse response,String pwd) throws IOException {
        response.setContentType("text/text;charset=utf-8");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        if (adminPwd.equals(pwd)){
            out.print("pwdPass");
        }else {
            out.print("pwdUnPass");
        }
    }

    @RequestMapping("/checkVerify")
    public void checkVerify(HttpSession session,HttpServletResponse response,String verify) throws IOException {
        response.setContentType("text/text;charset=utf-8");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        String serviceVerify = (String) session.getAttribute("serviceVerify");
        if (serviceVerify.equals(verify)){
            out.print("verifyPass");
        }else {
            out.print("verifyUnPass");
        }
    }


}
