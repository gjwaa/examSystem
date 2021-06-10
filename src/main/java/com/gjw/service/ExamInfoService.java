package com.gjw.service;

import com.gjw.bean.ExamInfo;

import java.util.List;

/**
 * @version 1.0
 * @author: gjw
 * @date: 2021/6/10 10:43
 * @desc:
 */
public interface ExamInfoService {

    int checkExamRepeat(String eNum);

    int insertExamInfo(ExamInfo examInfo);

}
