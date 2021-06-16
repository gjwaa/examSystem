package com.gjw.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Record {

    private int rID;
    private int eID;
    private int violationNum;
    private int cheatNum;
    private String restTime;
    private String state;

}
