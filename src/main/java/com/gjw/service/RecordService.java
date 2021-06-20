package com.gjw.service;

import org.apache.ibatis.annotations.Param;

import java.util.Map;

public interface RecordService {

    int insertEID(int eID,String statestate);

    int updateRecordStateByEID(Map map);

    String queryStateByEID(int eID);

    String queryRestTimeByEID(int eID);

    int updateRestTimeByEID(int eID,int restTime);

}
