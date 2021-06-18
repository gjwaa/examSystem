package com.gjw.service;

import com.gjw.bean.Question;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface QuestionService {

    int insertQuestion(List<Question> list);

    int queryQuestionRepeat();

    List<Question> queryQuestionByEID(int eID,String qType);

}
