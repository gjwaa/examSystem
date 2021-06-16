package com.gjw.controller;


import com.alibaba.fastjson.JSONObject;
import com.gjw.bean.ExamInfo;
import com.gjw.bean.Student;
import com.gjw.service.ExamInfoService;
import com.gjw.service.RecordService;
import com.gjw.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/stuExam")
public class StuExamController {

    @Autowired
    @Qualifier("examInfoServiceImpl")
    private ExamInfoService examInfoService;

    @Autowired
    @Qualifier("studentServiceImpl")
    private StudentService studentService;

    @Autowired
    @Qualifier("recordServiceImpl")
    private RecordService recordService;

    @RequestMapping("/login")
    public String login() {
        return "/stu/stuLogin";
    }

    @RequestMapping("/getEName")
    @ResponseBody
    public String getEName(String getEName) {
        List<ExamInfo> allEName = examInfoService.queryAllEName();
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("data", allEName);
        return jsonObject.toString();
    }

    @RequestMapping("stuLogin")
    public void stuLogin(HttpSession session, HttpServletResponse response, String eName, String aNumber, String IDCard, String sName) throws IOException {
        PrintWriter out = response.getWriter();
        Map map = new HashMap();
        map.put("eName", eName);
        map.put("aNumber", aNumber);
        map.put("IDCard", IDCard);
        map.put("sName", sName);
        Student student = studentService.checkLogin(map);
        JSONObject jsonObject = new JSONObject();
        if (student != null) {
            session.setAttribute("stuCheckInfo", student);
            System.err.println(student);
            System.out.println("=======================================");
            String state = recordService.queryStateByEID(student.getEID());
            if (state.equals("考试中")){
                jsonObject.put("login","true");
                jsonObject.put("examIng","true");
                out.print(jsonObject);
            }else {
                jsonObject.put("login","true");
                jsonObject.put("examIng","false");
                out.print(jsonObject);
            }
        } else {
            jsonObject.put("login","false");
            out.print(jsonObject);
        }

    }

    @RequestMapping("waitExam/{id}")
    public String waitExam(HttpServletRequest request, @PathVariable("id") int id) {
        request.getSession().setAttribute("uid", id);
        return "stu/waitExam";
    }

    @RequestMapping("infoTable")
    @ResponseBody
    public String infoTable(HttpSession session) {
        Student info = (Student) session.getAttribute("stuCheckInfo");
        List<Student> list = new ArrayList<Student>();
        list.add(info);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code", 0);
        jsonObject.put("msg", "stuInfo-ok");
        jsonObject.put("count", 1);
        jsonObject.put("data", list);
        return jsonObject.toString();
    }




}
