package com.gjw.controller;


import com.gjw.bean.ExamInfo;
import com.gjw.bean.Student;
import com.gjw.service.StudentService;
import com.gjw.utils.ExcelUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

/**
 * @version 1.0
 * @author: gjw
 * @date: 2021/6/8 12:38
 * @desc:
 */

@Controller
@RequestMapping("/exam")
public class ExamController {

    @Autowired
    @Qualifier("studentServiceImpl")
    private StudentService studentService;


    @RequestMapping("/showInfo")
    public String showInfo(HttpSession session) throws Exception {

        List<List<Object>> bankListByExcel = null;
        File file = new File(session.getAttribute("fileRootUrl")+"\\Test\\ExamPaper.xls");
        System.out.println(file+"<<<<<<<");
        InputStream in = new FileInputStream(file);
        bankListByExcel = new ExcelUtil().getBankListByExcel(in, "ExamPaper.xls");
        in.close();
        List<Student> students = new ArrayList<Student>();
        for (int i = 0; i < bankListByExcel.size(); i++) {
            List<Object> lo = bankListByExcel.get(i);
            Student student = new Student();
            student.setANumber(String.valueOf(lo.get(0)));
            student.setSName(String.valueOf(lo.get(1)));
            student.setIDCard(String.valueOf(lo.get(2)));
            students.add(student);
            ExamInfo examInfo = new ExamInfo();
            examInfo.setENum(String.valueOf(lo.get(3)));
            System.out.println(student+"<==>"+examInfo);
        }
        studentService.insertStudentInfo(students);
        System.out.println(bankListByExcel);

            return "examManage";
    }




}
