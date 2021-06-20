package com.gjw.service.impl;

import com.gjw.bean.Answer;
import com.gjw.mapper.AnswerMapper;
import com.gjw.service.AnswerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AnswerServiceImpl implements AnswerService {

    @Autowired
    private AnswerMapper answerMapper;


    @Override
    public String checkRepeat(int eID, String qNum, int sID) {
        return answerMapper.checkRepeat(eID, qNum, sID);
    }

    @Override
    public int buildAnswer(int eID, String qNum, int sID, String answer) {
        return answerMapper.buildAnswer(eID, qNum, sID, answer);
    }

    @Override
    public int updateAnswer(int eID, String qNum, int sID, String answer) {
        return answerMapper.updateAnswer(eID, qNum, sID, answer);
    }

    @Override
    public List<Answer> checkRecovery(int eID, int sID) {
        return answerMapper.checkRecovery(eID, sID);
    }
}
