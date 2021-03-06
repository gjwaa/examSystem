package com.gjw.mapper;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.Map;

@Repository
public interface RecordMapper {

    int insertEID(@Param("eID") int eID,@Param("state") String state);

    int updateRecordStateByEID(Map map);

    String queryStateByEID(int eID);

    String queryRestTimeByEID(int eID);

    int updateRestTimeByEID(@Param("eID") int eID,@Param("restTime") int restTime);

}
