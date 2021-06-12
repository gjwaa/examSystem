package com.gjw.mapper;

import com.gjw.bean.Student;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface StudentMapper {

    int insertStudentInfo(List<Student> list);

    int queryStudentCountByEID(int eID);

}
