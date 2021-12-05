package gosec.mylog;

import java.text.SimpleDateFormat;
import java.util.HashSet;
import java.util.Set;

public class Utils {
    private static final SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd_HH:mm:ss");//设置日期格式
    private static final String line = "------------------------------------------------------------------------------";
    private static final Set<String> primitiveTypeSet = new HashSet<>();

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

    protected static String head() {
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

    protected static String indent(int num) {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < num; i++) sb.append(" ");
        return sb.toString();
    }

    protected static String endLine(String str) {
        return str + "\n" +
                "End Time: " + System.currentTimeMillis() + " " + df.format(System.currentTimeMillis()) + "\n" +
                line + "\n";
    }

    protected static String logData(String type, Object... objs) {
        StringBuffer sb = new StringBuffer();
        // 参数
        sb.append(handleParas(type, objs));
        return sb.toString();
    }

    protected static String handleParas(String type, Object... objs) {
        StringBuilder sb = new StringBuilder();
        if (objs.length == 0) sb.append(indent(4) + "no parameter\n");
        else {
            for (int i = 0; i < objs.length; i++) {
                sb.append(indent(4) + type + " " + i + ": " + objs[i].getClass().getName() + " -> " + handlePara(objs[i]) + "\n");
            }
        }
        return sb.toString();
    }

    protected static String handlePara(Object obj) {
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
}
