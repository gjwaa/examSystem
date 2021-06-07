package com.gjw.mapper;

import com.gjw.bean.User;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @version 1.0
 * @author: gjw
 * @date: 2021/6/7 13:08
 * @desc:
 */
@Repository
public interface UserMapper {

    List<User> queryAllUser();

}
