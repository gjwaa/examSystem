package com.gjw.service;

import com.gjw.bean.ExamInfo;
import com.gjw.bean.Student;
import com.gjw.bean.ViewStuVo;

import java.util.List;
import java.util.Map;

/**
 * @version 1.0
 * @author: gjw
 * @date: 2021/6/10 10:43
 * @desc:
 */
public interface ExamInfoService {

    int checkExamRepeat(String eNum);

    int insertExamInfo(ExamInfo examInfo);

    List<Student> queryAllStuByEID(int eID,int page,int limit);

    int delExamInfoByENUM(String eNum);

    int updateExamInfoByENUM(Map<String, Object> map);

    ExamInfo queryExamInfoByENum(String eNum);

}
