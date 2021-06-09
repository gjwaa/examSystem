package com.gjw.controller;


import com.gjw.bean.InfoVo;
import com.gjw.utils.ExcelUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
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
    public String showInfo(HttpSession session) throws Exception {

//        String fileRootUrl = (String) session.getAttribute("fileRootUrl");
//        String fileName = (String) session.getAttribute("fileName");
        List<List<Object>> listob = null;
        File file = new File("D:\\IdeaProjects\\examSystem\\target\\examSystem\\upload\\Test\\Test.xls");
        InputStream in = new FileInputStream(file);
        listob = new ExcelUtil().getBankListByExcel(in,"Test.xls");
        in.close();

        for (int i = 0; i < listob.size(); i++) {
            List<Object> lo = listob.get(i);
            InfoVo vo = new InfoVo();
            vo.setCode(String.valueOf(lo.get(0)));
            vo.setName(String.valueOf(lo.get(1)));
            vo.setDate(String.valueOf(lo.get(2)));
            vo.setMoney(String.valueOf(lo.get(3)));
            System.out.println("打印信息--&gt;机构:"+vo.getCode()+"  名称："+vo.getName()+"   时间："+vo.getDate()+"   资产："+vo.getMoney());
        }

            return "examManage";
    }




}
