package com.gjw.service.impl;

import com.gjw.bean.Grade;
import com.gjw.mapper.GradeMapper;
import com.gjw.service.GradeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GradeServiceImpl implements GradeService {

    @Autowired
    private GradeMapper gradeMapper;

    @Override
    public String checkState(int eID, int sID) {
        return gradeMapper.checkState(eID, sID);
    }

    @Override
    public int insertState(int eID, int sID, String state) {
        return gradeMapper.insertState(eID, sID, state);
    }

    @Override
    public int updateState(int eID, int sID, String state) {
        return gradeMapper.updateState(eID, sID, state);
    }

    @Override
    public List<Grade> queryAllStuState() {
        return gradeMapper.queryAllStuState();
    }

    @Override
    public int updateGrade(int eID, int sID, int stuGrade) {
        return gradeMapper.updateGrade(eID, sID, stuGrade);
    }

    @Override
    public int updateAllState(int eID, String state) {
        return gradeMapper.updateAllState(eID, state);
    }

    @Override
    public String queryState(int eID, int sID) {
        return gradeMapper.queryState(eID, sID);
    }

    @Override
    public int insertAllStu(List<Grade> list) {
        return gradeMapper.insertAllStu(list);
    }

    @Override
    public int queryCount(int eID) {
        return gradeMapper.queryCount(eID);
    }


}
