package com.gjw.service;


public interface StuStateService {

    String checkState(int eID, int sID);

    int insertState(int eID, int sID, String state);

    int updateState(int eID, int sID, String state);

}
