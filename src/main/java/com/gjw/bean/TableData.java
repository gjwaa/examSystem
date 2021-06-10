package com.gjw.bean;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class TableData {
    private int code;
    private String msg;
    private long count;
    private Object data;
}
