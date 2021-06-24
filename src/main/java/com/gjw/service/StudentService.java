package com.gjw.service;

import com.gjw.bean.Grade;
import com.gjw.bean.Student;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface StudentService {

    int insertStudentInfo(List<Student> list);

    int queryStudentCountByEID(int eID);

    Student checkLogin(Map map);

    List<Grade> queryAllSID(int eID);

    int checkCheat(int eID,int sID,String state);

}
