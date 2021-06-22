package com.gjw.service.impl;


import com.gjw.bean.Grade;
import com.gjw.bean.Student;
import com.gjw.mapper.StudentMapper;
import com.gjw.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class StudentServiceImpl implements StudentService {

    @Autowired
    private StudentMapper studentMapper;


    @Override
    public int insertStudentInfo(List<Student> list) {
        return studentMapper.insertStudentInfo(list);
    }

    @Override
    public int queryStudentCountByEID(int eID) {
        return studentMapper.queryStudentCountByEID(eID);
    }

    @Override
    public Student checkLogin(Map map) {
        return studentMapper.checkLogin(map);
    }

    @Override
    public List<Grade> queryAllSID(int eID) {
        return studentMapper.queryAllSID(eID);
    }
}
