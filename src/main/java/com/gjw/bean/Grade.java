package com.gjw.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Grade {

    private int gID;
    private int sID;
    private int eID;
    private String state;
    private int stuGrade;

}
