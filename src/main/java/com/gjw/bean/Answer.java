package com.gjw.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Answer {

    private int aID;
    private int eID;
    private String qNum;
    private int sID;
    private String answer;
    private Question question;


}
