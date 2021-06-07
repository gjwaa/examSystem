package com.gjw.utils;

import java.awt.*;
import java.awt.image.BufferedImage;
import java.util.Random;

public class DrawVerify {
    public static final int WIDTH = 100;
    public static final int HEIGHT = 30;

    public static String drawVerify(Graphics g) {

        setBk(g);
        setBorder(g);
        drawLine(g);
        g.setColor(Color.red);
        g.setFont(new Font("宋体", Font.PLAIN, 18));
        String verify = "23456789qwertyupasdfghjkzxcvbnm";
        StringBuffer sb = new StringBuffer();
        int x = 15;
        for (int i = 0; i < 4; i++) {
            String s = verify.charAt(new Random().nextInt(verify.length())) + "";
            sb.append(s);
            g.drawString(s, x, 20);
            x += 20;
        }
        return sb.toString();
    }


    public static void setBk(Graphics g) {
        g.setColor(Color.white);
        g.fillRect(0, 0, WIDTH, HEIGHT);
    }

    public static void setBorder(Graphics g) {
        g.setColor(Color.BLUE);
        g.drawRect(1, 1, WIDTH - 2, HEIGHT - 2);
    }

    public static void drawLine(Graphics g) {
        g.setColor(Color.ORANGE);
        for (int i = 0; i < 5; i++) {
            int x1 = new Random().nextInt(WIDTH);
            int y1 = new Random().nextInt(HEIGHT);
            int x2 = new Random().nextInt(WIDTH);
            int y2 = new Random().nextInt(HEIGHT);
            g.drawLine(x1, y1, x2, y2);
        }
    }



}
