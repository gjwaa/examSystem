package com.gjw.service;

import java.util.Map;

public interface RecordService {

    int insertEID(int eID);

    int updateRecordStateByEID(Map map);

    String queryStateByEID(int eID);

}
