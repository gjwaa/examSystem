package com.gjw.controller;


import com.alibaba.fastjson.JSONObject;
import com.gjw.bean.*;
import com.gjw.service.*;
import com.gjw.utils.ExcelUtil;
import com.gjw.utils.StrUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

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

    @Autowired
    @Qualifier("recordServiceImpl")
    private RecordService recordService;

    @Autowired
    @Qualifier("questionServiceImpl")
    private QuestionService questionService;

    @Autowired
    @Qualifier("answerServiceImpl")
    private AnswerService answerService;


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
            recordService.insertEID(examInfo.getEID(), "等待考试");
            String singleInfo = (String) session.getAttribute("singleInfo");
            String multipleInfo = (String) session.getAttribute("multipleInfo");
            examInfoService.insertType("单选题", singleInfo);
            examInfoService.insertType("多选题", multipleInfo);
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
                singleQuestion.setQNum(StrUtil.str(String.valueOf(lo.get(1))));
                singleQuestion.setQTitle(String.valueOf(lo.get(2)));
                singleQuestion.setQOptA(String.valueOf(lo.get(3)));
                singleQuestion.setQOptB(String.valueOf(lo.get(4)));
                singleQuestion.setQOptC(String.valueOf(lo.get(5)));
                singleQuestion.setQOptD(String.valueOf(lo.get(6)));
                singleQuestion.setQAnswer(String.valueOf(lo.get(7)));
                singleQuestion.setQScore(String.valueOf(lo.get(8)));
                singleQuestion.setEID(examInfo.getEID());
                singleOpt.add(singleQuestion);
                session.setAttribute("singleOptList", singleOpt);
            } else if (String.valueOf(lo.get(0)).equals("多选题")) {
                multipleQuestion.setQType(String.valueOf(lo.get(0)));
                multipleQuestion.setQNum(StrUtil.str(String.valueOf(lo.get(1))));
                multipleQuestion.setQTitle(String.valueOf(lo.get(2)));
                multipleQuestion.setQOptA(String.valueOf(lo.get(3)));
                multipleQuestion.setQOptB(String.valueOf(lo.get(4)));
                multipleQuestion.setQOptC(String.valueOf(lo.get(5)));
                multipleQuestion.setQOptD(String.valueOf(lo.get(6)));
                multipleQuestion.setQAnswer(String.valueOf(lo.get(7)));
                multipleQuestion.setQScore(String.valueOf(lo.get(8)));
                multipleQuestion.setEID(examInfo.getEID());
                multipleOpt.add(multipleQuestion);
                session.setAttribute("multipleOptList", multipleOpt);
            }
        }
        List<Question> allList = new ArrayList<Question>();
        allList.addAll(singleOpt);
        allList.addAll(multipleOpt);
        session.setAttribute("allQuestion", allList);
        int i = questionService.queryQuestionRepeat();
        if (i <= 0) {
            questionService.insertQuestion(allList);
        }


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
        page = (page - 1) * limit;
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

    @RequestMapping("invigilator")//监考
    public String invigilator(HttpSession session, HttpServletRequest request) {
        request.getSession().setAttribute("uid", "admin");
        return "invigilator";
    }

    @RequestMapping("startExam")
    public void startExam(HttpSession session, HttpServletResponse response, HttpServletRequest request) throws IOException {
        response.setContentType("text/text;charset=utf-8");
        response.setCharacterEncoding("UTF-8");
        ExamInfo examInfo = (ExamInfo) session.getAttribute("examInfo");
        Map map = new HashMap();
        map.put("eID", examInfo.getEID());
        map.put("state", "考试中");
//        request.getSession().setAttribute("state","startExam");
        recordService.updateRecordStateByEID(map);
//        session.setAttribute("uid", "admin");
        response.getWriter().print("start");
    }

    @RequestMapping("checkExamState")
    public void checkExamState(HttpServletResponse response, int eID) throws IOException {
        response.setContentType("text/text;charset=utf-8");
        response.setCharacterEncoding("UTF-8");
        String state = recordService.queryStateByEID(eID);
        response.getWriter().print(state);
    }

    @RequestMapping("getRestTime")
    public void getRestTime(HttpServletResponse response, HttpSession session, int eID) throws IOException {
        response.setContentType("text/text;charset=utf-8");
        response.setCharacterEncoding("UTF-8");
        ExamInfo examInfo = (ExamInfo) session.getAttribute("examInfo");
        String restTime = recordService.queryRestTimeByEID(eID);
        String REGEX = "[^(0-9)]";
        String time = Pattern.compile(REGEX).matcher(examInfo.getETime()).replaceAll("").trim();
        if (restTime == null) {
            response.getWriter().print(Integer.valueOf(time) * 60);
        } else {
            response.getWriter().print(restTime);
        }
    }

    @RequestMapping("setRestTime")
    public void setRestTime(HttpServletResponse response, HttpSession session, int eID, int restTime) throws IOException {
        response.setContentType("text/text;charset=utf-8");
        response.setCharacterEncoding("UTF-8");
        recordService.updateRestTimeByEID(eID, restTime);
        response.getWriter().print("ok");

    }

    @RequestMapping("paper")
    public String paper() {
        return "stu/exam";
    }

    @RequestMapping("question")
    public void question(HttpServletResponse response, HttpSession session, int eID) throws IOException {
        response.setContentType("text/text;charset=utf-8");
        response.setCharacterEncoding("UTF-8");
        System.out.println(eID + "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
        ExamInfo examInfoByDB = examInfoService.queryExamInfoByEID(eID);
        session.setAttribute("qExamInfo", examInfoByDB);
        List<Question> singles = questionService.queryQuestionByEID(eID, "单选题");
        session.setAttribute("singles", singles);
        List<Question> multiples = questionService.queryQuestionByEID(eID, "多选题");
        session.setAttribute("multiples", multiples);
        String singleTip = examInfoService.queryTContent("单选题");
        session.setAttribute("singleTip", singleTip);
        String multipleTip = examInfoService.queryTContent("多选题");
        session.setAttribute("multipleTip", multipleTip);
        List<Question> all = new ArrayList<Question>();
        all.addAll(singles);
        all.addAll(multiples);
        session.setAttribute("all", all);
        response.getWriter().print("ok");
    }

    @RequestMapping("pauseExam")
    public void pauseExam(HttpSession session, HttpServletResponse response, HttpServletRequest request) throws IOException {
        response.setContentType("text/text;charset=utf-8");
        response.setCharacterEncoding("UTF-8");
        ExamInfo examInfo = (ExamInfo) session.getAttribute("examInfo");
        Map map = new HashMap();
        map.put("eID", examInfo.getEID());
        map.put("state", "暂停考试");
        recordService.updateRecordStateByEID(map);
        response.getWriter().print("pause");
    }

    @RequestMapping("answer")
    public void answer(HttpServletResponse response, int eID, String qNum, int sID, String answer) throws IOException {
        response.setContentType("text/text;charset=utf-8");
        response.setCharacterEncoding("UTF-8");
        System.out.println("+++++++++++++++++++++++++++++++++++++++++++++");
        String answered = answerService.checkRepeat(eID, qNum, sID);
        if (answered == null) {
            answerService.buildAnswer(eID, qNum, sID, answer);
        } else {
            answerService.updateAnswer(eID, qNum, sID, answer);
        }
        response.getWriter().print("answer");

    }

    @RequestMapping("checkRecovery")
    @ResponseBody
    public void checkRecovery(HttpServletResponse response, int eID, int sID) throws IOException {
        response.setContentType("text/text;charset=utf-8");
        response.setCharacterEncoding("UTF-8");
        List<Answer> answers = answerService.checkRecovery(eID, sID);
        JSONObject jsonObject = new JSONObject();
        if (answers != null) {
            jsonObject.put("data", answers);
            response.getWriter().print(jsonObject);
        } else {
            jsonObject.put("data", "noAnswer");
            response.getWriter().print(jsonObject);
        }

    }


}
