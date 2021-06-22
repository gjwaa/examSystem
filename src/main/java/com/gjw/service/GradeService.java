package com.gjw.service;


import com.gjw.bean.Grade;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface GradeService {

    String checkState(int eID, int sID);

    int insertState(int eID, int sID, String state);

    int updateState(int eID, int sID, String state);

    List<Grade> queryAllStuState();

    int updateGrade(int eID,int sID,int stuGrade);

    int updateAllState(int eID,String state);

    String queryState(int eID,int sID);

}
