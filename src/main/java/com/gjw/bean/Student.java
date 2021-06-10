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
public class Student {
    private int sID;
    private String eNum;
    private String aNumber;
    private String IDCard;
    private String sName;
    private String sSex;
    private int sAge;


}
