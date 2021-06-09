package com.gjw.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @version 1.0
 * @author: gjw
 * @date: 2021/6/9 15:07
 * @desc:
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class InfoVo {
    private String code;
    private String name;
    private String date;
    private String money;
}
