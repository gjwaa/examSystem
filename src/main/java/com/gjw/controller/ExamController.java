package com.gjw.controller;

import com.gjw.utils.UnZipAnRar;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * @version 1.0
 * @author: gjw
 * @date: 2021/6/8 12:38
 * @desc:
 */

@Controller
@RequestMapping("/exam")
public class ExamController {

    @RequestMapping("/showInfo")
    public String showInfo(HttpSession session) {
        String fileLoadUrl = (String) session.getAttribute("fileLoadUrl");
        File zipFile = new File(fileLoadUrl);
        try {
            String fileRootUrl = (String) session.getAttribute("fileRootUrl");
            UnZipAnRar.unZip(zipFile, fileRootUrl);
        } catch (IOException e) {
            e.printStackTrace();
        }

        return "examManage";
    }




}
