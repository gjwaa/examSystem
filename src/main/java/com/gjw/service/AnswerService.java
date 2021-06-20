package com.gjw.service;


import com.gjw.bean.Answer;


import java.util.List;

public interface AnswerService {

    String checkRepeat(int eID, String qNum, int sID);

    int buildAnswer(int eID, String qNum, int sID, String answer);

    int updateAnswer(int eID, String qNum, int sID, String answer);

    List<Answer> checkRecovery(int eID,int sID);

}
