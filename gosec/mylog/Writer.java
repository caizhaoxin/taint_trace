package gosec.mylog;

import android.os.Build;

import androidx.annotation.RequiresApi;

import java.io.*;
import java.nio.ByteBuffer;
import java.nio.channels.AsynchronousFileChannel;
import java.nio.channels.CompletionHandler;
import java.nio.channels.FileChannel;
import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.util.concurrent.ConcurrentHashMap;

public class Writer {
    public static String packageName;
    public static String fileName;

    static {
        packageName = "cn.log";
        fileName = "why!!!.txt";
    }

    public static ConcurrentHashMap<String, BufferedWriter> writerMap = new ConcurrentHashMap<>();

    // bufferWriter
    @RequiresApi(api = Build.VERSION_CODES.O)
    public static void write(String content) throws IOException {
        Path path = Paths.get("/data/data/", packageName, fileName);
        File file = new File(path.toString());
        if (!file.getParentFile().exists()) {
            boolean result = file.getParentFile().mkdirs();
            if (!result) {
                System.out.println("创建失败");
            }
        }
        BufferedWriter bufferedWriter = writerMap.getOrDefault(path.toString(), null);
        if (bufferedWriter == null) {
            bufferedWriter = new BufferedWriter(new OutputStreamWriter(
                    new FileOutputStream(file, true)), (int) Math.pow(1024, 2));
            writerMap.put(path.toString(), bufferedWriter);
        }
        bufferedWriter.write(content);
        bufferedWriter.flush();
    }
}

