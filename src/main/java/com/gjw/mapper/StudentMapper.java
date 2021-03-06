package com.gjw.mapper;

import com.gjw.bean.Grade;
import com.gjw.bean.Student;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface StudentMapper {

    int insertStudentInfo(List<Student> list);

    int queryStudentCountByEID(int eID);

    Student checkLogin(Map map);

    List<Grade> queryAllSID(int eID);

    int checkCheat(@Param("eID") int eID, @Param("sID") int sID,@Param("state") String state);

}
