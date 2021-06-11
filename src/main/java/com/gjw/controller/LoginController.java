package com.gjw.controller;


import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.gjw.utils.DrawVerify;

import com.gjw.utils.ZipUtil;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

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

    @RequestMapping("/help")
    public String help() {
       return "help";
    }

    @RequestMapping("/newPaper")
    public String newPaper() {
        return "examManage";
    }

    @ResponseBody
    @RequestMapping("/upLoad")
    public String upLoad(@RequestParam("file") CommonsMultipartFile file,String zipPwd,HttpServletResponse response, HttpServletRequest request, Model model) throws IOException, ServletException {
        response.setDateHeader("Expires",0);
        response.setHeader("Buffer","True");
        response.setHeader("Cache-Control","no-cache");
        response.setHeader("Cache-Control","no-store");
        response.setHeader("Expires","0");
        response.setHeader("ETag",String.valueOf(System.currentTimeMillis()));
        response.setHeader("Pragma","no-cache");
        response.setHeader("Date",String.valueOf(new Date()));
        response.setHeader("Last-Modified",String.valueOf(new Date()));
        String path = request.getServletContext().getRealPath("/upload");
        File realPath = new File(path);
        if (!realPath.exists()) {
            realPath.mkdir();
        }
        System.out.println("文件保存地址：" + realPath);
        File dest = new File(realPath + "/" + file.getOriginalFilename());
        file.transferTo(dest);
        System.out.println("fileName===>"+dest.getName());
        HttpSession session = request.getSession();
        session.setAttribute("fileLoadUrl", dest.getAbsolutePath());
        session.setAttribute("fileRootUrl", realPath);
        session.setAttribute("fileName", dest.getName());
        JSONObject jsonObject = new JSONObject();
        File[] files = ZipUtil.unzip(dest, realPath.getAbsolutePath(), zipPwd);

        for (File zipFile : files) {
            System.out.println(zipFile.getAbsolutePath()+"<<<<<");
            session.setAttribute(zipFile.getName(), zipFile.getAbsolutePath());
        }
        jsonObject.put("msg", "ok");
        jsonObject.put("code", 0);

        return jsonObject.toString();

    }




}
