package com.gjw.service.impl;


import com.gjw.bean.Student;
import com.gjw.mapper.StudentMapper;
import com.gjw.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StudentServiceImpl implements StudentService {

    @Autowired
    private StudentMapper studentMapper;


    @Override
    public int insertStudentInfo(List<Student> list) {
        return studentMapper.insertStudentInfo(list);
    }
}
