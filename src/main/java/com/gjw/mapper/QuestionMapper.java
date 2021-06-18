package com.gjw.mapper;

import com.gjw.bean.Question;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface QuestionMapper {

    int insertQuestion(List<Question> list);

    int queryQuestionRepeat();

    List<Question> queryQuestionByEID(@Param("eID") int eID, @Param("qType") String qType);


}
