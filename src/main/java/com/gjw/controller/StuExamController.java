package com.gjw.controller;


import com.alibaba.fastjson.JSONObject;
import com.gjw.bean.ExamInfo;
import com.gjw.service.ExamInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/stuExam")
public class StuExamController {

    @Autowired
    @Qualifier("examInfoServiceImpl")
    private ExamInfoService examInfoService;

    @RequestMapping("/login")
    public String login(){
        return "/stu/stuLogin";
    }

    @RequestMapping("/getEName")
    @ResponseBody
    public String getEName(){
        List<ExamInfo> allEName = examInfoService.queryAllEName();
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("data",allEName);
        return jsonObject.toString();
    }


}
