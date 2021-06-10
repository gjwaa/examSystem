package com.gjw.controller;


import com.alibaba.fastjson.JSONObject;
import com.gjw.bean.ExamInfo;
import com.gjw.bean.Student;
import com.gjw.bean.TableData;
import com.gjw.service.ExamInfoService;
import com.gjw.service.StudentService;
import com.gjw.utils.ExcelUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.ArrayList;
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

    @Autowired
    @Qualifier("studentServiceImpl")
    private StudentService studentService;

    @Autowired
    @Qualifier("examInfoServiceImpl")
    private ExamInfoService examInfoService;


    @RequestMapping("/showInfo")
    public String showInfo(HttpSession session) throws Exception {

        //读取考试excel
        List<List<Object>> examListByExcel = null;
        File examFile = new File(session.getAttribute("fileRootUrl") + "\\Test\\Test.xls");
        System.out.println(examFile + "<<<<<<<");
        InputStream examIn = new FileInputStream(examFile);
        examListByExcel = new ExcelUtil().getBankListByExcel(examIn, "Test.xls");
        examIn.close();
//        List<ExamInfo> exams = new ArrayList<ExamInfo>();
        ExamInfo examInfo = new ExamInfo();
        for (int i = 0; i < 1; i++) {
            List<Object> lo = examListByExcel.get(i);
            examInfo.setENum(String.valueOf(lo.get(0)));
            examInfo.setEName(String.valueOf(lo.get(1)));
            examInfo.setETime(String.valueOf(lo.get(2)));
            examInfo.setEType(String.valueOf(lo.get(3)));
            examInfo.setEWork(String.valueOf(lo.get(4)));
            examInfo.setEOrgan(String.valueOf(lo.get(5)));
            examInfo.setELevel(String.valueOf(lo.get(6)));
            examInfo.setEScore(String.valueOf(lo.get(7)));
            examInfo.setCourseID(String.valueOf(lo.get(10)));
            examInfo.setCourseName(String.valueOf(lo.get(11)));
        }
        System.out.println("===>" + examInfo);
        int count = examInfoService.checkExamRepeat(examInfo.getENum());
        if (count <= 0) {
            examInfoService.insertExamInfo(examInfo);
            System.err.println(examListByExcel);

            System.out.println("=================================================");

            //读取学生excel
            List<List<Object>> bankListByExcel = null;
            File file = new File(session.getAttribute("fileRootUrl") + "\\Test\\ExamPaper.xls");
            System.out.println(file + "<<<<<<<");
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
                student.setENum(String.valueOf(lo.get(3)));
                students.add(student);
                System.out.println("===>" + student);
            }

            studentService.insertStudentInfo(students);
            System.err.println(bankListByExcel);
        }

        int countByENUM = studentService.queryStudentCountByENUM(examInfo.getENum());
        examInfo.setEPeople(countByENUM);
        session.setAttribute("examInfo",examInfo);


        return "examManage";

    }

    @RequestMapping("/examInfo")
    @ResponseBody
    public String examInfo(HttpSession session,int page,int limit){
        ExamInfo examInfo = (ExamInfo) session.getAttribute("examInfo");
//        TableData tableData = new TableData();
//        tableData.setCode(0);//
//        tableData.setMsg("成功");//执行成功返回“成功”
        System.out.println(">>>>"+page+">>>>"+limit);
//        tableData.setData(examInfo);//设置当前数据
        Map map = new HashMap();
        List<ExamInfo> list = new ArrayList<ExamInfo>();
//        JSONObject jsonObject = new JSONObject();
//        jsonObject.put("code",0);
//        jsonObject.put("msg","ok");
//        jsonObject.put("count","1000");
//        jsonObject.put("data",list);
        list.add(examInfo);
        map.put("code",0);
        map.put("msg","table-service-OK");
        map.put("count",100);
        map.put("data",list);
//        JSONObject jsonObject = JSONObject.parseObject(JSONObject.toJSONString(map));
//        return jsonObject;

        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code",0);
        jsonObject.put("msg","table-ok");
        jsonObject.put("data",list);
        return jsonObject.toString();
    }





}
