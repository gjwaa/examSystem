package com.gjw.service.impl;

import com.gjw.mapper.RecordMapper;
import com.gjw.service.RecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class RecordServiceImpl implements RecordService {

    @Autowired
    private RecordMapper recordMapper;


    @Override
    public int insertEID(int eID) {
        return recordMapper.insertEID(eID);
    }

    @Override
    public int updateRecordStateByEID(Map map) {
        return recordMapper.updateRecordStateByEID(map);
    }

    @Override
    public String queryStateByEID(int eID) {
        return recordMapper.queryStateByEID(eID);
    }
}
