package com.gjw.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @version 1.0
 * @author: gjw
 * @date: 2021/6/23 10:33
 * @desc:
 */
public class DateUtils {


    public static String dateToString(Date date){
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        String dateString = formatter.format(date);
        return dateString;
    }
}
