package com.gjw.service.impl;

import com.gjw.bean.StuState;
import com.gjw.mapper.StuStateMapper;
import com.gjw.service.StuStateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StuStateServiceImpl implements StuStateService {

    @Autowired
    private StuStateMapper stuStateMapper;

    @Override
    public String checkState(int eID, int sID) {
        return stuStateMapper.checkState(eID, sID);
    }

    @Override
    public int insertState(int eID, int sID, String state) {
        return stuStateMapper.insertState(eID, sID, state);
    }

    @Override
    public int updateState(int eID, int sID, String state) {
        return stuStateMapper.updateState(eID, sID, state);
    }

    @Override
    public List<StuState> queryAllStuState() {
        return stuStateMapper.queryAllStuState();
    }

}
