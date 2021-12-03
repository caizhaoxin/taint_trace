/**
 * projectName: caizhaoxin
 * fileName: Log.java
 * packageName: gosec.log
 * date: 2021-12-2
 * copyright(c) 2017-2020 xxx公司
 */
package gosec.mylog;

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
    private static ThreadLocal<Map<String, String>> threadLocalMethod = new ThreadLocal<>();

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
    public static void logParameters(Object... objs) {
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
    public static void logVariables(Object... objs) {
        String res = "logVariables: \n" + head() + logData("vari", objs);
        Writer.write(res);
    }

    /**
     * @param obj: 参数
     * @author: caizhaoxin
     * @methodsName: logReturnVal
     * @description: 用于记录返回的结果
     * @return:
     */
    public static void logReturnVal(Object obj) {
        String res = "logVariables: \n" + head() + logData("vari", obj);
        Writer.write(res);
    }

    /**
     * @author: caizhaoxin
     * @methodsName: getStack
     * @description: 打印调用栈
     * @return:
     */
    public static void getStack() {
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
     * @param methodName: 方法名
     * @param paras:      参数数组
     * @author: caizhaoxin
     * @methodsName: logStaticInvokeVoid
     * @description: 调用静态方法 且 方法的返回类型为void
     * @return: void
     */
    public static void logStaticInvokeVoid(String methodName, Object... paras) {
        StringBuilder sb = new StringBuilder("staticInvokeVoid: \n");
        sb.append(head());
        sb.append(String.format("invoke method: %s\n", methodName));
        sb.append("invoke parameters:\n" + handleParas("paras", paras));
        Writer.write(endLine(sb.toString()));
    }

    /**
     * @param methodName: 方法名
     * @param source:     调用者实例
     * @param paras:      参数数组
     * @author: caizhaoxin
     * @methodsName: logInvokeVoid
     * @description: 调用实例方法，且 方法的返回类型为void
     * @return: void
     */
    public static void logInvokeVoid(String methodName, Object source, Object... paras) {
        StringBuilder sb = new StringBuilder("invokeVoid: \n");
        sb.append(head());
        sb.append(String.format("invoke method: %s\n", methodName));
        sb.append("invoke source: " + source.getClass().getName() + " -> " + handlePara(source) + "\n");
        sb.append("invoke parameters:\n" + handleParas("paras", paras));
        Writer.write(endLine(sb.toString()));
    }

    /**
     * @param methodName: 方法名
     * @param signature:  唯一标识
     * @param paras:      参数数组
     * @author: caizhaoxin
     * @methodsName: logStaticInvokeNotVoidBefore
     * @description: 调用静态方法 且 方法的返回值不为void
     * @return: void
     */
    public static void logStaticInvokeNotVoidBefore(String methodName, String signature, Object... paras) {
        if (threadLocalMethod.get() == null) threadLocalMethod.set(new HashMap<>());
        Map<String, String> map = threadLocalMethod.get();
        StringBuilder sb = new StringBuilder("staticInvokeNotVoid: \n");
        sb.append(head());
        sb.append(String.format("invoke method: %s\n", methodName));
        sb.append("invoke parameters:\n" + handleParas("paras", paras));
        map.put(signature, sb.toString());
    }

    /**
     * @param signature:   唯一标识
     * @param returnValue: 参数数组
     * @author: caizhaoxin
     * @methodsName: logStaticInvokeNotVoidAfter
     * @description: 用与staticInvokeNotVoidBefore之后调用，记录log
     * @return: void
     */
    public static void logStaticInvokeNotVoidAfter(String signature, Object returnValue) {
        if (threadLocalMethod.get() == null) {
            StringBuilder sb = new StringBuilder("staticInvokeNotVoid: \n");
            sb.append(head());
            sb.append("pls invoke staticInvokeNotVoidBefore first!");
            Writer.write(endLine(sb.toString()));
        }
        Map<String, String> map = threadLocalMethod.get();
        StringBuilder sb = new StringBuilder(map.get(signature));
        sb.append("invoke result:\n" + handleParas("res", returnValue));
        map.remove(signature);
        Writer.write(endLine(sb.toString()));
    }

    /**
     * @param methodName: 方法名
     * @param signature:  唯一标识
     * @param paras:      参数数组
     * @param source:     调用者实例
     * @author: caizhaoxin
     * @methodsName: logInvokeNotVoidBefore
     * @description: 调用实例方法，且 方法的返回类型不为void
     * @return: void
     */
    public static void logInvokeNotVoidBefore(String methodName, String signature, Object source, Object... paras) {
        if (threadLocalMethod.get() == null) threadLocalMethod.set(new HashMap<>());
        Map<String, String> map = threadLocalMethod.get();
        StringBuilder sb = new StringBuilder("invokeNotVoid: \n");
        sb.append(head());
        sb.append(String.format("invoke method: %s\n", methodName));
        sb.append("invoke source: " + source.getClass().getName() + " -> " + handlePara(source) + "\n");
        sb.append("invoke parameters:\n" + handleParas("paras", paras));
        map.put(signature, sb.toString());
    }

    /**
     * @param signature:   唯一标识
     * @param returnValue: 参数数组
     * @author: caizhaoxin
     * @methodsName: logInvokeNotVoidAfter
     * @description: 用与invokeNotVoidBefore之后调用，记录log
     * @return: void
     */
    public static void logInvokeNotVoidAfter(String signature, Object returnValue) {
        if (threadLocalMethod.get() == null) {
            StringBuilder sb = new StringBuilder("invokeNotVoid: \n");
            sb.append(head());
            sb.append("pls invoke invokeNotVoidBefore first!");
            Writer.write(endLine(sb.toString()));
        }
        Map<String, String> map = threadLocalMethod.get();
        StringBuilder sb = new StringBuilder(map.get(signature));
        sb.append("invoke result:\n" + handleParas("res", returnValue));
        map.remove(signature);
        Writer.write(endLine(sb.toString()));
    }

    private static void test1() {
        int a = 123;
        double b = 234.3;
        char c = 'a';
        Double d = new Double(123.2);
        String signature = "12312312312312sd12s2s";
        logInvokeNotVoidBefore("test2", signature, a, b, c, d);
        test2();
        logInvokeNotVoidAfter(signature, a);
    }

    private static void test2() {
        int[] arr1 = {123, 12, 312, 312, 3};
        byte[] arr2 = "asdasdsa".getBytes();
        String str = "sd";
        Info[] infos = {new Info("123"), new Info("5555")};
        String signature = "sdsdsdsdaxx";
        logInvokeNotVoidBefore("test3", signature, arr1, arr2, str, infos);
        logInvokeNotVoidAfter(signature, infos);
    }

    public static void main(String[] args) throws Exception {
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

        // 打印调用栈
        getStack();

        // 打印参数
        logParameters(a, b, c, d, arr1, arr2, str, infos);

        // 打印中间某个寄存器的值
        logVariables(a, b, c);

        // 打印结果的值
        logReturnVal(infos);

        // 调用返回类型为void 的 静态方法 打印赋值关系
        logStaticInvokeVoid("fun1", a, b, infos);

        // 调用返回类型为void 的 实例方法 打印赋值关系， 注意这里的c，也就是第二个参数是调用这个方法的实例！
        logInvokeVoid("fun2", c, d, infos, arr1);

        // 调用返回类型 不是void 的 静态方法 打印赋值关系
        signature = "723qyc857on2q4ydxo78213y4";
        logStaticInvokeNotVoidBefore("fun3", signature, a, b, infos);
        // move-result-object ... 之类的结果复制字节码, 记得signature一定要对应！！！  signature你在python随机生成然后插入就好了
        logStaticInvokeNotVoidAfter(signature, arr1);
        
        // 调用返回类型 不是void 的 实例方法 打印赋值关系 ， 同样！注意这里的c，也就是第三个参数是调用这个方法的实例！
        signature = "234123c4c43";
        logInvokeNotVoidBefore("fun4", signature, c, arr2);
        // move-result-object ...
        logInvokeNotVoidAfter(signature, infos);
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





