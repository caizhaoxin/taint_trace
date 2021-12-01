package gosec.mylog;

import java.util.HashSet;
import java.util.Set;

public class Log {
    public static String test() {
        return "我有一只小培福，我从来也不骑";
    }

    public static String log(Object... objs) {
        StringBuffer sb = new StringBuffer();
        // 当前的线程名
        String curThreadName = Thread.currentThread().toString();
        sb.append("Thread name: " + curThreadName + "\n");
        // 类名
        StackTraceElement stackTraceElement = Thread.currentThread().getStackTrace()[2];
        sb.append("    class name: " + stackTraceElement.getClassName() + "." + stackTraceElement.getMethodName() + "\n");
        // 参数
        if (objs.length == 0) sb.append("        no parameter");
        else {
            for (Object obj : objs) {
                sb.append("        " + obj.getClass().getName() + " : " + handlePara(obj) + "\n");
            }
        }
        return sb.toString();
    }

    public static String getStack() {
        StackTraceElement[] stackElements = new Throwable().getStackTrace();
        StringBuffer sb = new StringBuffer();
        // 当前的线程名
        String curThreadName = Thread.currentThread().toString();
        sb.append("Thread name: " + curThreadName + "\n");
        if (stackElements != null) {
            for (int i = 1; i < stackElements.length; i++) {
                sb.append("    " + stackElements[i].toString() + "\n");
            }
        }
        return sb.toString();
    }

    public static String handlePara(Object obj) {
        if (obj.getClass().getName().equals("[B"))
            return new String((byte[]) obj);
        return obj.toString();
    }

    public static void main(String[] args) {
        // 测试
        System.out.println(test());
        // 打印调用栈
        System.out.println(getStack());
        // 打印参数
        int[] a = {1, 1, 1, 1, 1};
        double b = 18.2;
        Set<String> set = new HashSet<>(); set.add("hahaha");
        System.out.println(log(a, new StringBuffer("caizhaoxin"), b, set));
        System.out.println(getStack());
    }

}











