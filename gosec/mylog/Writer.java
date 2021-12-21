package gosec.mylog;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.LinkedBlockingQueue;

class ProcedureItem {
    public String fileName;
    public String content;
    public boolean over;

    public ProcedureItem(String fileName, String content, boolean over) {
        this.fileName = fileName;
        this.content = content;
        this.over = over;
    }
}

public class Writer {
    public static String packageName = "cn.demo.demo";
    public static String rootPath = "./";
    //    public static String rootPath = File.separator + "data" + File.separator + "data" + File.separator;
    public static String tmpPath = "log_tmp";
    public static String fileName = "data.txt";
    public static BufferedWriter bufferedWriter;
    public static String dataLogFileName;
    private static final int itemSize = 1000;
    private static final int bufSize = 1024;
    // 写temp的资源
    public final static int produreWriterNum = 10;
    public static List<LinkedBlockingQueue<ProcedureItem>> procedureLBQList;

    public static LinkedBlockingQueue<String> endLBQ = new LinkedBlockingQueue<>(itemSize);
    public static ConcurrentHashMap<String, BufferedWriter> bufWriMap = new ConcurrentHashMap<>();


    static {
        dataLogFileName = String.format(rootPath + "%s/%s", packageName, fileName);
        tmpPath = String.format(rootPath + "%s/%s", packageName, tmpPath);
        File dataLogFile = new File(dataLogFileName);
        File tmpLogDir = new File(tmpPath);
        // 创建data.txt
        if (!dataLogFile.getParentFile().exists()) {
            boolean result = dataLogFile.getParentFile().mkdirs();
            if (!result) {
                System.out.println("创建失败");
            }
        }
        // 创建tmp文件夹
        if (!tmpLogDir.exists()) {
            boolean result = tmpLogDir.mkdirs();
            if (!result) {
                System.out.println("创建失败");
            }
        }
        try {
            bufferedWriter = new BufferedWriter(new OutputStreamWriter(
                    new FileOutputStream(dataLogFile, true)), bufSize);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        // 创建produreWriterNum个中间变量写线程
        // 中间变量写线程
        procedureLBQList = new ArrayList<>();
        for (int i = 0; i < produreWriterNum; i++)
            procedureLBQList.add(new LinkedBlockingQueue<>(itemSize));
        for (int i = 0; i < produreWriterNum; i++) {
            final int index = i;
            new Thread(() -> {
                for (; ; ) {
                    try {
                        // LinkedBlockingQueue的take方法会阻塞获取，所以for死循环不用担心
                        ProcedureItem procedureItem = procedureLBQList.get(index).take();
                        BufferedWriter bw = bufWriMap.getOrDefault(procedureItem.fileName, null);
                        if (bw == null) continue;
                        bw.write(procedureItem.content);
//                    FileWriter fileWriter = new FileWriter(procedureItem.fileName, true);
//                    fileWriter.append(procedureItem.content);
//                    fileWriter.flush();
                        if (procedureItem.over) {
                            bw.flush();
                            bw.close();
                            bufWriMap.remove(procedureItem.fileName);
                            endLBQ.put(procedureItem.fileName);
                        }
                    } catch (InterruptedException | IOException e) {
                        e.printStackTrace();
                    }
                }
            }).start();
        }

        // 结果写线程
        new Thread(() -> {
            for (; ; ) {
                String tmpLogFile = "";
                BufferedReader in = null;
                try {
                    tmpLogFile = endLBQ.take();
                    in = new BufferedReader(new FileReader(tmpLogFile));
                    String str;
                    while ((str = in.readLine()) != null) {
                        bufferedWriter.write(str);
                        bufferedWriter.write("\n");
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                } catch (InterruptedException e) {
                    e.printStackTrace();
                } finally {
                    try {
                        bufferedWriter.flush();
                        in.close();
                        deleteFileByFilePath(tmpLogFile);
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
        }).start();
    }
    public static void write(String hash, String content, boolean over) {
//        System.out.println(hash+" "+content);
        try {
            String fileName = tmpPath + File.separator + hash;
            if (!bufWriMap.containsKey(fileName))
                bufWriMap.put(fileName, new BufferedWriter(new OutputStreamWriter(
                        new FileOutputStream(fileName, true)), bufSize));
            procedureLBQList.get((int) (Long.parseLong(hash) % produreWriterNum)).put(new ProcedureItem(fileName, content, over));
        } catch (InterruptedException | FileNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        String path = ".\\cn.demo.demo\\log_tmp\\924";
        deleteFileByFilePath(path);
    }

    public static void deleteFileByFilePath(String filePath){
        try {
            File file = new File(filePath);
//            File file = new File(fileName);
//            System.out.println(file.toString());
//            System.out.println(file.exists());
//            System.out.println(filePath);
            if (file.exists() && file.isFile()) {
                if (file.delete()) {
//                    System.out.println("successfully delete file: " + file.toString());
                }
//                else {
//                    System.out.println("delete error: " + file.toString());
//                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void deleteFileByFileName(String fileName) {
        deleteFileByFilePath(tmpPath + File.separator + fileName);
    }
}
