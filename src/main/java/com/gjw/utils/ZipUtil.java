package com.gjw.utils;

import net.lingala.zip4j.ZipFile;
import net.lingala.zip4j.exception.ZipException;
import net.lingala.zip4j.model.FileHeader;

import java.io.File;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;

public class ZipUtil {
    public static File[] unzip(File zipFile, String dest, String passwd) throws ZipException {
        ZipFile zFile = new ZipFile(zipFile);  // 首先创建ZipFile指向磁盘上的.zip文件
//        zFile.setFileNameCharset("GBK");       // 设置文件名编码，在GBK系统中需要设置
        zFile.setCharset(Charset.forName("GBK"));
        if (!zFile.isValidZipFile()) {   // 验证.zip文件是否合法，包括文件是否存在、是否为zip文件、是否被损坏等
            throw new ZipException("压缩文件不合法,可能被损坏.");
        }
        File destDir = new File(dest);     // 解压目录
        if (destDir.isDirectory() && !destDir.exists()) {
            destDir.mkdir();
        }
        if (zFile.isEncrypted()) {
            zFile.setPassword(passwd.toCharArray());  // 设置密码
        }
        zFile.extractAll(dest);      // 将文件抽出到解压目录(解压)
        List<FileHeader> headerList = zFile.getFileHeaders();
        List<File> extractedFileList = new ArrayList<File>();
        for(FileHeader fileHeader : headerList) {
            if (!fileHeader.isDirectory()) {
                extractedFileList.add(new File(destDir,fileHeader.getFileName()));
            }
        }
        File [] extractedFiles = new File[extractedFileList.size()];
        extractedFileList.toArray(extractedFiles);
        return extractedFiles;
    }
}
