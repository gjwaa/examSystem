package com.gjw.service;

import com.gjw.bean.Student;

import java.util.List;
import java.util.Map;

public interface StudentService {

    int insertStudentInfo(List<Student> list);

    int queryStudentCountByEID(int eID);

    Student checkLogin(Map map);

}
