package com.gjw.utils;

public class StrUtil {


    public static String str(String s) {
        int i = s.indexOf(".");
        return s.substring(0, i);
    }

}
