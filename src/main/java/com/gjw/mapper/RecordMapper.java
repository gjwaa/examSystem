package com.gjw.mapper;

import org.springframework.stereotype.Repository;

import java.util.Map;

@Repository
public interface RecordMapper {

    int insertEID(int eID);

    int updateRecordStateByEID(Map map);

    String queryStateByEID(int eID);

}
