package gosec.mylog;

<<<<<<< HEAD
public class Writer {
    public static void write(String str){
        System.out.println(str);
    }
}
=======
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
    public static ConcurrentHashMap<String, BufferedWriter> writerMap = new ConcurrentHashMap<>();

    // bufferWriter
    public static void write(String packageName, String fileName, String content) {
        Path path = Paths.get("/data/data/", packageName, fileName);
        File file = new File(path.toString());
        if (!file.getParentFile().exists()) {
            boolean result = file.getParentFile().mkdirs();
            if (!result) {
                System.out.println("创建失败");
            }
        }
        BufferedWriter bufferedWriter = writerMap.getOrDefault(path.toString(), null);
        try {
            if (bufferedWriter == null) {
                bufferedWriter = new BufferedWriter(new OutputStreamWriter(
                        new FileOutputStream(file, true)), (int) Math.pow(1024, 2));
                writerMap.put(path.toString(), bufferedWriter);
            }
            bufferedWriter.write(content);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

>>>>>>> 76aee522471377b790a59bef54438e2d8fa2a8a1
