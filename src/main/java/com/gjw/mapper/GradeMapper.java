package com.gjw.mapper;

import com.gjw.bean.Grade;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface GradeMapper {

    String checkState(@Param("eID") int eID, @Param("sID") int sID);

    int insertState(@Param("eID") int eID, @Param("sID") int sID, @Param("state") String state);

    int updateState(@Param("eID") int eID, @Param("sID") int sID, @Param("state") String state);

    List<Grade> queryAllStuState();

    int updateGrade(@Param("eID") int eID, @Param("sID") int sID, @Param("stuGrade") int stuGrade);

    int updateAllState(@Param("eID") int eID, @Param("state") String state);

    String queryState(@Param("eID") int eID, @Param("sID") int sID);

    int insertAllStu(List<Grade> list);

    int queryCount(int eID);

}
