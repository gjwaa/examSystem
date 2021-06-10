package com.gjw.mapper;

import com.gjw.bean.ExamInfo;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @version 1.0
 * @author: gjw
 * @date: 2021/6/10 10:36
 * @desc:
 */

@Repository
public interface ExamInfoMapper {

    int checkExamRepeat(String eNum);

    int insertExamInfo(ExamInfo examInfo);


}
