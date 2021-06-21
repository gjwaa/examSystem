package com.gjw.mapper;

import com.gjw.bean.Answer;
import com.gjw.bean.Grade;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AnswerMapper {

    String checkRepeat(@Param("eID") int eID, @Param("qNum") String qNum, @Param("sID") int sID);

    int buildAnswer(@Param("eID") int eID, @Param("qNum") String qNum, @Param("sID") int sID, @Param("answer") String answer);

    int updateAnswer(@Param("eID") int eID, @Param("qNum") String qNum, @Param("sID") int sID, @Param("answer") String answer);

    List<Answer> checkRecovery(@Param("eID") int eID, @Param("sID") int sID);

    List<Answer> judgeAnswer(@Param("eID") int eID, @Param("sID") int sID);

}
