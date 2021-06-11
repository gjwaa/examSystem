package com.gjw.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @version 1.0
 * @author: gjw
 * @date: 2021/6/11 10:54
 * @desc:
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Question {

    private int qID;
    private int eID;
    private String qNum;
    private String qType;
    private String qTitle;
    private String qOptA;
    private String qOptB;
    private String qOptC;
    private String qOptD;
    private String qScore;
    private String qAnswer;

}
