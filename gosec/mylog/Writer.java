package gosec.mylog;

<<<<<<< HEAD
<<<<<<< HEAD
public class Writer {
    public static void write(String str){
        System.out.println(str);
    }
}
=======
=======
import android.os.Build;

import androidx.annotation.RequiresApi;

>>>>>>> b2063a7fdf45a703158e7ad7baf452a1941d130d
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
        fileName = "data.txt";
    }

    public static ConcurrentHashMap<String, BufferedWriter> writerMap = new ConcurrentHashMap<>();

    // bufferWriter
    @RequiresApi(api = Build.VERSION_CODES.O)
    public static void write(String content) {
//        System.out.println(content);
//        Path path = Paths.get("/data/data/", packageName, fileName);
        String path = String.format("/data/data/%s/%s", packageName, fileName);
        File file = new File(path.toString());
        if (!file.getParentFile().exists()) {
            boolean result = file.getParentFile().mkdirs();
            if (!result) {
                System.out.println("创建失败");
            }
        }
        BufferedWriter bufferedWriter = writerMap.getOrDefault(path, null);
        try {
            if (bufferedWriter == null) {
                bufferedWriter = new BufferedWriter(new OutputStreamWriter(
                        new FileOutputStream(file, true)), (int) Math.pow(1024, 2));
                writerMap.put(path, bufferedWriter);
            }
            bufferedWriter.write(content);
            bufferedWriter.flush();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
<<<<<<< HEAD

>>>>>>> 76aee522471377b790a59bef54438e2d8fa2a8a1
=======
>>>>>>> b2063a7fdf45a703158e7ad7baf452a1941d130d
