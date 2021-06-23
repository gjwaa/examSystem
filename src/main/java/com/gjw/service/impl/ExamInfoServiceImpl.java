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
    public List<Student> queryAllStuByEIDLimit(int eID, int page, int limit) {
        return examInfoMapper.queryAllStuByEIDLimit(eID, page, limit);
    }

    @Override
    public List<Student> queryAllStuByEID(int eID) {
        return examInfoMapper.queryAllStuByEID(eID);
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

    @Override
    public ExamInfo queryExamInfoByEID(int eID) {
        return examInfoMapper.queryExamInfoByEID(eID);
    }

    @Override
    public List<ExamInfo> queryAllEName() {
        return examInfoMapper.queryAllEName();
    }

    @Override
    public int insertType(String tType, String tContent) {
        return examInfoMapper.insertType(tType, tContent);
    }

    @Override
    public String queryTContent(String tType) {
        return examInfoMapper.queryTContent(tType);
    }

    @Override
    public List<Student> queryExamRes(int eID, int page, int limit) {
        return examInfoMapper.queryExamRes(eID, page, limit);
    }

    @Override
    public List<Student> queryAllExamRes(int eID) {
        return examInfoMapper.queryAllExamRes(eID);
    }
}
