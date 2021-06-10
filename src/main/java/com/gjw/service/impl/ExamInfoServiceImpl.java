package com.gjw.service.impl;

import com.gjw.bean.ExamInfo;
import com.gjw.mapper.ExamInfoMapper;
import com.gjw.service.ExamInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @version 1.0
 * @author: gjw
 * @date: 2021/6/10 10:43
 * @desc:
 */

@Service
public class ExamInfoServiceImpl implements ExamInfoService {

    @Autowired
    private ExamInfoMapper examInfoMapper;


    @Override
    public int checkExamRepeat(String eNum) {
        return examInfoMapper.checkExamRepeat(eNum);
    }

    @Override
    public int insertExamInfo(ExamInfo examInfo) {
        return examInfoMapper.insertExamInfo(examInfo);
    }
}
