package com.gjw.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ExamInfo {

    private int eID;
    private String eNum;
    private String eName;
    private String eTime;
    private String eType;
    private String eWork;
    private String eOrgan;
    private String eLevel;
    private int ePeople;
    private String eScore;
    private String courseID;
    private String courseName;



}
