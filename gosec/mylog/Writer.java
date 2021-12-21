package gosec.mylog;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;

public class Writer {
    public static String packageName = "cn.demo.demo";
    public static String rootPath = "./";
    //    public static String rootPath = File.separator + "data" + File.separator + "data" + File.separator;
    public static String fileName = "data.txt";
    public static BufferedWriter bufferedWriter;
    public static String dataLogFileName;
    private static final int bufSize = 1024;


    static {
        dataLogFileName = String.format(rootPath + "%s/%s", packageName, fileName);
        File dataLogFile = new File(dataLogFileName);
        // 创建data.txt
        if (!dataLogFile.getParentFile().exists()) {
            boolean result = dataLogFile.getParentFile().mkdirs();
            if (!result) {
                System.out.println("创建失败");
            }
        }
        if (dataLogFile.exists()) {
            deleteFileByFilePath(dataLogFileName);
        }
        // 创建文件写入流
        try {
            bufferedWriter = new BufferedWriter(new OutputStreamWriter(
                    new FileOutputStream(dataLogFile, true)), bufSize);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
    }

    public synchronized static void write(String hash, String content) {
//        System.out.println(hash+" "+content);
        try {
            String hashHead = String.format("Hash: %s\n", hash);
            bufferedWriter.write(hashHead + content);
            // 临时
//            bufferedWriter.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void deleteFileByFilePath(String filePath) {
        try {
            File file = new File(filePath);
            System.out.println(file.exists());
            System.out.println(file.isFile());
            if (file.exists() && file.isFile()) {
                if (file.delete()) {
                    System.out.println("successfully delete file: " + file.toString());
                } else {
                    System.out.println("delete error: " + file.toString());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
