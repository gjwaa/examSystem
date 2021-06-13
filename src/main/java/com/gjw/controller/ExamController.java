package com.gjw.controller;


import com.alibaba.fastjson.JSONObject;
import com.gjw.bean.ExamInfo;
import com.gjw.bean.Question;
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
            session.setAttribute("multipleInfo", lo.get(8));//多选信息
            session.setAttribute("singleInfo", lo.get(9));//单选信息
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
                student.setEID(examInfo.getEID());
                students.add(student);
                System.out.println("===>" + student);
            }

            studentService.insertStudentInfo(students);
            System.err.println(bankListByExcel);

        }
        int countByEID = studentService.queryStudentCountByEID(examInfo.getEID());
        examInfo.setEPeople(countByEID);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("eID", examInfo.getEID());
        map.put("ePeople", countByEID);
        examInfoService.updateExamInfoByENUM(map);
        ExamInfo examInfoByDB = examInfoService.queryExamInfoByENum(examInfo.getENum());
        session.setAttribute("examInfo", examInfoByDB);

        List<Question> singleOpt = new ArrayList<Question>();
        List<Question> multipleOpt = new ArrayList<Question>();
        for (int i = 2; i < 17; i++) {
            Question singleQuestion = new Question();
            Question multipleQuestion = new Question();
            List<Object> lo = examListByExcel.get(i);
            if (String.valueOf(lo.get(0)).equals("单选题")) {
                singleQuestion.setQType(String.valueOf(lo.get(0)));
                singleQuestion.setQNum(String.valueOf(lo.get(1)));
                singleQuestion.setQTitle(String.valueOf(lo.get(2)));
                singleQuestion.setQOptA(String.valueOf(lo.get(3)));
                singleQuestion.setQOptB(String.valueOf(lo.get(4)));
                singleQuestion.setQOptC(String.valueOf(lo.get(5)));
                singleQuestion.setQOptD(String.valueOf(lo.get(6)));
                singleQuestion.setQAnswer(String.valueOf(lo.get(7)));
                singleQuestion.setQScore(String.valueOf(lo.get(8)));
                singleOpt.add(singleQuestion);
                session.setAttribute("singleOptList", singleOpt);
            } else if (String.valueOf(lo.get(0)).equals("多选题")) {
                multipleQuestion.setQType(String.valueOf(lo.get(0)));
                multipleQuestion.setQNum(String.valueOf(lo.get(1)));
                multipleQuestion.setQTitle(String.valueOf(lo.get(2)));
                multipleQuestion.setQOptA(String.valueOf(lo.get(3)));
                multipleQuestion.setQOptB(String.valueOf(lo.get(4)));
                multipleQuestion.setQOptC(String.valueOf(lo.get(5)));
                multipleQuestion.setQOptD(String.valueOf(lo.get(6)));
                multipleQuestion.setQAnswer(String.valueOf(lo.get(7)));
                multipleQuestion.setQScore(String.valueOf(lo.get(8)));
                multipleOpt.add(multipleQuestion);
                session.setAttribute("multipleOptList", multipleOpt);
            }
        }
        List<Question> allList = new ArrayList<Question>();
        allList.addAll(singleOpt);
        allList.addAll(multipleOpt);
        session.setAttribute("allQuestion", allList);


        return "examManage";

    }

    @RequestMapping("/examInfo")
    @ResponseBody
    public String examInfo(HttpSession session, int page, int limit) {
        ExamInfo examInfo = (ExamInfo) session.getAttribute("examInfo");

        System.out.println(">>>>" + page + ">>>>" + limit);

        List<ExamInfo> list = new ArrayList<ExamInfo>();

        list.add(examInfo);

        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code", 0);
        jsonObject.put("msg", "table-ok");
        jsonObject.put("data", list);
        return jsonObject.toString();
    }

    @RequestMapping("viewPaper")
    public String viewPaper() {
        return "viewPaper";
    }

    @RequestMapping("stuInfo")
    @ResponseBody
    public String stuInfo(HttpSession session, int page, int limit) {
        ExamInfo examInfo = (ExamInfo) session.getAttribute("examInfo");
        List<Student> students = examInfoService.queryAllStuByEIDLimit(examInfo.getEID(), page, limit);
        int count = examInfoService.queryAllStuByEID(examInfo.getEID()).size();
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code", 0);
        jsonObject.put("msg", "stuTable-ok");
        jsonObject.put("count", count);
        jsonObject.put("data", students);
        return jsonObject.toString();
    }

    @RequestMapping("viewStu")
    public String viewStu() {
        return "viewStu";
    }

    @RequestMapping("invigilator")
    public String invigilator(HttpSession session) {

        return "invigilator";
    }


}
