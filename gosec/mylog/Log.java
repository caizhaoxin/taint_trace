/**
 * projectName: caizhaoxin
 * fileName: Log.java
 * packageName: gosec.log
 * date: 2021-12-2
 * copyright(c) 2017-2020 xxx公司
 */
package gosec.mylog;

import android.os.Build;

import androidx.annotation.RequiresApi;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

public class Log {
    public static String test() {
        return "我有一只小培福，我从来也不骑";
    }

    private static final SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd_HH:mm:ss");//设置日期格式
    private static final Set<String> primitiveTypeSet = new HashSet<>();
    private static final String line = "------------------------------------------------------------------------------";
    private static ThreadLocal<Long> threadLocalLong = new ThreadLocal<>();
    private static ThreadLocal<Map<Long, String>> threadLocalMethod = new ThreadLocal<>();

    static {
        primitiveTypeSet.add("java.lang.Boolean");
        primitiveTypeSet.add("java.lang.Byte");
        primitiveTypeSet.add("java.lang.Character");
        primitiveTypeSet.add("java.lang.Double");
        primitiveTypeSet.add("java.lang.Float");
        primitiveTypeSet.add("java.lang.Integer");
        primitiveTypeSet.add("java.lang.Long");
        primitiveTypeSet.add("java.lang.Short");

        primitiveTypeSet.add("Z");
        primitiveTypeSet.add("B");
        primitiveTypeSet.add("C");
        primitiveTypeSet.add("D");
        primitiveTypeSet.add("F");
        primitiveTypeSet.add("I");
        primitiveTypeSet.add("J");
        primitiveTypeSet.add("S");
    }

    private static String endLine(String str) {
        return str + "\n" +
                "End Time: " + System.currentTimeMillis() + " " + df.format(System.currentTimeMillis()) + "\n" +
                line + "\n";
    }

    private static String head() {
        StringBuffer sb = new StringBuffer();
        // 当前时间
        sb.append("Start Time: " + System.currentTimeMillis() + " " + df.format(System.currentTimeMillis()) + "\n");
        // 当前的线程名
        String curThreadName = Thread.currentThread().toString();
        sb.append("Thread name: " + curThreadName + "\n");
        // 类名
        StackTraceElement stackTraceElement = Thread.currentThread().getStackTrace()[3];
        sb.append("class and method name: " + new Throwable().getStackTrace()[2] + "\n");
        return sb.toString();
    }

    private static String logData(String type, Object... objs) {
        StringBuffer sb = new StringBuffer();
        // 参数
        sb.append(handleParas(type, objs));
        return endLine(sb.toString());
    }

    private static String indent(int num) {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < num; i++) sb.append(" ");
        return sb.toString();
    }

    private static String handleParas(String type, Object... objs) {
        StringBuilder sb = new StringBuilder();
        if (objs.length == 0) sb.append(indent(4) + "no parameter");
        else {
            for (int i = 0; i < objs.length; i++) {
                sb.append(indent(4) + type + " " + i + ": " + objs[i].getClass().getName() + " -> " + handlePara(objs[i]) + "\n");
            }
        }
        return sb.toString();
    }

    private static String handlePara(Object obj) {
        String objType = obj.getClass().getName();
        if (objType.equals("[B"))
            return new String((byte[]) obj);
        // 检测是否为以为数组 目前只考虑一维数组 并且基础类型地不考虑 byte[] 除外
        int l = 0;
        while (l < objType.length() && objType.charAt(l) == '[') l++;
        objType = objType.substring(l);
        if (l > 0 && !primitiveTypeSet.contains(objType)) {
            Object[] objs = (Object[]) obj;
            StringBuilder sb = new StringBuilder("\n");
            for (int i = 0; i < objs.length; i++)
                sb.append(indent(8) + String.format("[%d] -> ", i) + objs[i].toString() + (i == objs.length - 1 ? "" : "\n"));
            return sb.toString();
        }
        return obj.toString();
    }

    /**
     * @param objs: 参数
     * @author: caizhaoxin
     * @methodsName: logParameters
     * @description: 用于记录方法的所有参数，一般用在开头输出所有参数
     * @return:
     */
    @RequiresApi(api = Build.VERSION_CODES.O)
    public static void logParameters(Object... objs) throws IOException {
        String res = "logParameters: \n" + head() + logData("para", objs);
        Writer.write(res);
    }

    /**
     * @param objs: 参数
     * @author: caizhaoxin
     * @methodsName: logVariables
     * @description: 用于记录过程间参数，一般查看过程间哪个参数比较感兴趣
     * @return:
     */
    @RequiresApi(api = Build.VERSION_CODES.O)
    public static void logVariables(Object... objs) throws IOException {
        String res = "logVariables: \n" + head() + logData("vari", objs);
        Writer.write(res);
    }

    /**
     * @param obj: 返回参数
     * @author: caizhaoxin
     * @methodsName: logReturnVal
     * @description: 用于记录返回的结果
     * @return:
     */
    @RequiresApi(api = Build.VERSION_CODES.O)
    public static void logReturnVal(Object obj) throws IOException {
        String res = "logVariables: \n" + head() + logData("vari", obj);
        Writer.write(res);
    }

    /**
     * @author: caizhaoxin
     * @methodsName: getStack
     * @description: 打印调用栈
     * @return:
     */
    @RequiresApi(api = Build.VERSION_CODES.O)
    public static void getStack() throws IOException {
        StackTraceElement[] stackElements = new Throwable().getStackTrace();
        StringBuffer sb = new StringBuffer();
        // 获取头部信息
        sb.append(head());
        if (stackElements != null) {
            for (int i = 1; i < stackElements.length; i++) {
                sb.append(indent(4) + stackElements[i].toString() + "\n");
            }
        }
        Writer.write("getStack: \n" + endLine(sb.toString()));
    }

    /**
     * @param paras: 参数数组
     * @author: caizhaoxin
     * @methodsName: logStaticInvokeVoid
     * @description: 调用静态方法 且 方法的返回类型为void
     * @return: void
     */
    @RequiresApi(api = Build.VERSION_CODES.O)
    public static void logStaticInvokeVoid(Object... paras) throws IOException {
        StringBuilder sb = new StringBuilder("staticInvokeVoid: \n");
        sb.append(head());
//        sb.append(String.format("invoke method: %s\n",));
        sb.append("invoke parameters:\n" + handleParas("paras", paras));
        Writer.write(endLine(sb.toString()));
    }

    /**
     * @param source: 调用者实例
     * @param paras:  参数数组
     * @author: caizhaoxin
     * @methodsName: logInvokeVoid
     * @description: 调用实例方法，且 方法的返回类型为void
     * @return: void
     */
    @RequiresApi(api = Build.VERSION_CODES.O)
    public static void logInvokeVoid(Object source, Object... paras) throws IOException {
        StringBuilder sb = new StringBuilder("invokeVoid: \n");
        sb.append(head());
        sb.append("invoke source: " + source.getClass().getName() + " -> " + handlePara(source) + "\n");
        sb.append("invoke parameters:\n" + handleParas("paras", paras));
        Writer.write(endLine(sb.toString()));
    }

    /**
     * @author: caizhaoxin
     * @methodsName: logStaticInvokeNotVoidBefore
     * @description: 调用静态方法 且 方法的返回值不为void
     * @return: void
     */
    public static void logStaticInvokeNotVoidBefore(Object... paras) throws IOException {
        if (threadLocalLong.get() == null) threadLocalLong.set(new Long(Long.MIN_VALUE));
        if (threadLocalMethod.get() == null) threadLocalMethod.set(new HashMap<>());
        Long index = threadLocalLong.get();
        Map<Long, String> mp = threadLocalMethod.get();
        StringBuilder sb = new StringBuilder("staticInvokeNotVoid: \n");
        sb.append(head());
        sb.append("invoke parameters:\n" + handleParas("paras", paras));
        mp.put(index, sb.toString());
        threadLocalLong.set(index + 1);
    }

    /**
     * @param returnValue: 参数数组
     * @author: caizhaoxin
     * @methodsName: logStaticInvokeNotVoidAfter
     * @description: 用与staticInvokeNotVoidBefore之后调用，记录log
     * @return: void
     */
    @RequiresApi(api = Build.VERSION_CODES.O)
    public static void logStaticInvokeNotVoidAfter(Object returnValue) throws IOException {
        if (threadLocalMethod.get() == null || threadLocalLong.get() == null) {
            StringBuilder sb = new StringBuilder("staticInvokeNotVoid: \n");
            sb.append(head());
            sb.append("pls invoke staticInvokeNotVoidBefore first!");
            Writer.write(endLine(sb.toString()));
        }
        Long index = threadLocalLong.get() - 1;
        threadLocalLong.set(index);
        Map<Long, String> mp = threadLocalMethod.get();
        String str = mp.get(index);
        str += ("invoke result:\n" + handleParas("res", returnValue));
        Writer.write(endLine(str));
    }

    /**
     * @param source: 调用者实例
     * @author: caizhaoxin
     * @methodsName: logInvokeNotVoidBefore
     * @description: 调用实例方法，且 方法的返回类型不为void
     * @return: void
     */
    public static void logInvokeNotVoidBefore(Object source, Object... paras) {
        if (threadLocalLong.get() == null) threadLocalLong.set(new Long(Long.MIN_VALUE));
        if (threadLocalMethod.get() == null) threadLocalMethod.set(new HashMap<>());
        Long index = threadLocalLong.get();
        Map<Long, String> mp = threadLocalMethod.get();
        StringBuilder sb = new StringBuilder("logInvokeNotVoidBefore: \n");
        sb.append(head());
        sb.append("invoke parameters:\n" + handleParas("paras", paras));
        mp.put(index, sb.toString());
        threadLocalLong.set(index + 1);
    }

    /**
     * @param returnValue: 返回参数
     * @author: caizhaoxin
     * @methodsName: logInvokeNotVoidAfter
     * @description: 用与invokeNotVoidBefore之后调用，记录log
     * @return: void
     */
    @RequiresApi(api = Build.VERSION_CODES.O)
    public static void logInvokeNotVoidAfter(Object returnValue) throws IOException {
        if (threadLocalMethod.get() == null || threadLocalLong.get() == null) {
            StringBuilder sb = new StringBuilder("logInvokeNotVoidAfter: \n");
            sb.append(head());
            sb.append("pls invoke logInvokeNotVoidAfter first!");
            Writer.write(endLine(sb.toString()));
        }
        Long index = threadLocalLong.get() - 1;
        threadLocalLong.set(index);
        Map<Long, String> mp = threadLocalMethod.get();
        String str = mp.get(index);
        str += ("invoke result:\n" + handleParas("res", returnValue));
        Writer.write(endLine(str));
    }

    @RequiresApi(api = Build.VERSION_CODES.O)
    public static String demo() {
        try {
            // 参数
            int a = 123;
            double b = 234.3;
            char c = 'a';
            Double d = new Double(123.2);
            int[] arr1 = {123, 12, 312, 312, 3};
            byte[] arr2 = "asdasdsa".getBytes();
            String str = "sd";
            Info[] infos = {new Info("123"), new Info("5555")};
            String signature = "";
            String packageName = "cn.log";
            String fileName = "data.txt";
            // 打印调用栈
            getStack();
            // 打印参数
            logParameters(a, b, c, d, arr1, arr2, str, infos);
            // 打印中间某个寄存器的值
            logVariables(a, b, c);
            // 打印结果的值
            logReturnVal(infos);
            // 调用返回类型为void 的 静态方法 打印赋值关系
            logStaticInvokeVoid(a, b, infos);
            // 调用返回类型为void 的 实例方法 打印赋值关系， 注意这里的c，也就是第二个参数是调用这个方法的实例！
            logInvokeVoid(c, d, infos, arr1);
            // 调用返回类型 不是void 的 静态方法 打印赋值关系
            logStaticInvokeNotVoidBefore(a, b, infos);
            logStaticInvokeNotVoidAfter(arr1);
            // 调用返回类型 不是void 的 实例方法 打印赋值关系 ， 同样！注意这里的c，也就是第三个参数是调用这个方法的实例！
            logInvokeNotVoidBefore(c, arr2);
            logInvokeNotVoidAfter(infos);
        } catch (Exception e) {
            return e.toString();
        }
        return "success";
    }
}




class Info {
    private String password;

    public Info(String password) {
        this.password = password;
    }

    @Override
    public String toString() {
        return "Info{" +
                "password='" + password + '\'' +
                '}';
    }

}





