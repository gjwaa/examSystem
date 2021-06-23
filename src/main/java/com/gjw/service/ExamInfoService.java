package com.gjw.service;

import com.gjw.bean.ExamInfo;
import com.gjw.bean.Student;
import com.gjw.bean.ViewStuVo;
import org.apache.ibatis.annotations.Param;

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

    List<Student> queryAllStuByEIDLimit(int eID, int page, int limit);

    List<Student> queryAllStuByEID(int eID);

    int delExamInfoByENUM(String eNum);

    int updateExamInfoByENUM(Map<String, Object> map);

    ExamInfo queryExamInfoByENum(String eNum);

    ExamInfo queryExamInfoByEID(int eID);

    List<ExamInfo> queryAllEName();

    int insertType(String tType, String tContent);

    String queryTContent(String tType);

    List<Student> queryExamRes(int eID, int page, int limit);

    List<Student> queryAllExamRes(int eID);

    Student queryExamResBySID(int eID, int sID);

}
