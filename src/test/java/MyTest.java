import com.gjw.utils.UnZipAnRar;
import org.junit.Test;

import java.io.*;
import java.util.Enumeration;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;
import java.util.zip.ZipInputStream;

/**
 * @version 1.0
 * @author: gjw
 * @date: 2021/6/8 15:36
 * @desc:
 */
public class MyTest {

    @Test
    public void getUnZipAnnRarTest() {
        String originDir = "D:\\";
        String zipPath = originDir + "1.zip";
        File zipFile = new File(zipPath);
        String rarPath = originDir + "1.rar";
        File rarFile = new File(rarPath);

        try {
            UnZipAnRar.unZip(zipFile, "D:\\1\\");
        } catch (IOException e) {
            e.printStackTrace();
        }

//        try {
//            UnZipAnRar.unRar(rarFile, "D:\\1\\");
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
    }


}
