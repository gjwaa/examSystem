package com.gjw.mapper;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface StuStateMapper {

    String checkState(@Param("eID") int eID, @Param("sID") int sID);

    int insertState(@Param("eID") int eID, @Param("sID") int sID, @Param("state") String state);

    int updateState(@Param("eID") int eID, @Param("sID") int sID, @Param("state") String state);

}
