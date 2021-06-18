package com.gjw.service.impl;


import com.gjw.bean.Question;
import com.gjw.mapper.QuestionMapper;
import com.gjw.service.QuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class QuestionServiceImpl implements QuestionService {

    @Autowired
    private QuestionMapper questionMapper;


    @Override
    public int insertQuestion(List<Question> list) {
        return questionMapper.insertQuestion(list);
    }

    @Override
    public int queryQuestionRepeat() {
        return questionMapper.queryQuestionRepeat();
    }

    @Override
    public List<Question> queryQuestionByEID(int eID, String qType) {
        return questionMapper.queryQuestionByEID(eID, qType);
    }
}
