package com.gjw.mapper;

import com.gjw.bean.ExamInfo;
import com.gjw.bean.Student;
import com.gjw.bean.ViewStuVo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * @version 1.0
 * @author: gjw
 * @date: 2021/6/10 10:36
 * @desc:
 */

@Repository
public interface ExamInfoMapper {

    int checkExamRepeat(String eNum);

    int insertExamInfo(ExamInfo examInfo);

    List<Student> queryAllStuByEIDLimit(@Param("eID") int eID,@Param("page") int page,@Param("limit") int limit);

    List<Student> queryAllStuByEID(int eID);

    int delExamInfoByENUM(String eNum);

    int updateExamInfoByENUM(Map<String, Object> map);

    ExamInfo queryExamInfoByENum(String eNum);

}