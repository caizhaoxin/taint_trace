package gosec.mylog;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.Timer;
import java.util.TimerTask;

public class Writer {
    public static String packageName = "cn.demo.demo";
    public static String rootPath = "./";
    //    public static String rootPath = File.separator + "data" + File.separator + "data" + File.separator;
    public static String fileName = "data.txt";
    public static BufferedWriter bufferedWriter;
    public static String dataLogFileName;
    private static final int bufSize = (int) Math.pow(1024, 2);


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
        //flush
        new Timer("writer looper").schedule(new TimerTask() {
            @Override
            public void run() {
                try {
                    bufferedWriter.flush();
//                    System.out.println("flush");
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }, 1000, 1000);
    }

    public static void write(String hash, String content) {
        try {
            String hashHead = String.format("Hash: %s\n", hash);
            bufferedWriter.write(hashHead + content);
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
