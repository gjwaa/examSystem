package com.gjw.service.impl;

import com.gjw.bean.ExamInfo;
import com.gjw.bean.Student;
import com.gjw.bean.ViewStuVo;
import com.gjw.mapper.ExamInfoMapper;
import com.gjw.service.ExamInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

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

    @Override
    public List<Student> queryAllStuByEID(int eID,int page,int limit) {
        return examInfoMapper.queryAllStuByEID(eID,page,limit);
    }

    @Override
    public int delExamInfoByENUM(String eNum) {
        return examInfoMapper.delExamInfoByENUM(eNum);
    }

    @Override
    public int updateExamInfoByENUM(Map<String, Object> map) {
        return examInfoMapper.updateExamInfoByENUM(map);
    }

    @Override
    public ExamInfo queryExamInfoByENum(String eNum) {
        return examInfoMapper.queryExamInfoByENum(eNum);
    }
}
