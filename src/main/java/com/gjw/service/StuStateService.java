package com.gjw.service;


import com.gjw.bean.StuState;

import java.util.List;

public interface StuStateService {

    String checkState(int eID, int sID);

    int insertState(int eID, int sID, String state);

    int updateState(int eID, int sID, String state);

    List<StuState> queryAllStuState();

}
