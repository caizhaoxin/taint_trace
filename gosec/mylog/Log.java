package gosec.mylog;

import java.util.Stack;
import java.util.concurrent.atomic.AtomicLong;

public class Log {
    /**
     * @param objs: 参数
     * @author: caizhaoxin
     * @methodsName: LogNonStatic
     * @description: 用于记录方法的所有参数，一般用在开头输出所有参数
     * @return:
     */

    static ThreadLocal<Stack<String>> logDataLocal = new ThreadLocal<>();
    static ThreadLocal<DataStack> threadLocal = new ThreadLocal<>();

    private static void checkLocal() {
        if (logDataLocal.get() == null) logDataLocal.set(new Stack<>());
        if (threadLocal.get() == null) threadLocal.set(new DataStack());
    }

    public static void start() {
        checkLocal();
        StackTraceElement[] stackElements = new Throwable().getStackTrace();
        String hash = Long.toString(IdWorker.getId());
        String head1 = String.format("Method Name: %s.%s\n", stackElements[1].getClassName(), stackElements[1].getMethodName());
        String head2 = String.format("Method Start Time: %s %s\n", Utils.getCurrentTimeMillis(), Utils.getCurrentTimeFormat());
        String content = Utils.head() + head1 + head2 + Utils.line + "\n";
        Stack<String> stack = logDataLocal.get();
        stack.push(hash);
        Writer.write(stack.peek(), content);
    }

    public static void end() {
        checkLocal();
        StackTraceElement[] stackElements = new Throwable().getStackTrace();
        String end1 = String.format("Method End Time: %s %s\n", Utils.getCurrentTimeMillis(), Utils.getCurrentTimeFormat());
        String end2 = String.format("Method Name: %s.%s End!\n", stackElements[1].getClassName(), stackElements[1].getMethodName());
        String content = Utils.head() + end1 + end2 + Utils.line + "\n";
        Stack<String> stack = logDataLocal.get();
        String curHash = stack.pop();
        Writer.write(curHash, content);
    }

    public static void add(Object obj) {
        checkLocal();
        DataStack dataStack = threadLocal.get();
        dataStack.addData(obj);
    }

    public static void stopAdding() {
        checkLocal();
        DataStack dataStack = threadLocal.get();
        dataStack.stopAdding();
    }

    public static void logParameters() {
        checkLocal();
        DataStack dataStack = threadLocal.get();
        Stack<Object> stack = dataStack.getData();
        Object[] objs = new Object[stack.size()];
        for (int i = 0; i < objs.length; i++) objs[i] = stack.pop();
        String res = "logParameters: \n" + Utils.head() + "parameter:\n" + Utils.logData("parameter", objs);
        String content = Utils.endLine(res);
        Writer.write(logDataLocal.get().peek(), content);
    }


    public static void logInvokeStack() {
        StackTraceElement[] stackElements = new Throwable().getStackTrace();
        StringBuffer sb = new StringBuffer();
        // 获取头部信息
        sb.append(Utils.head());
        if (stackElements != null) {
            sb.append("invoke stack:\n");
            for (int i = 1; i < stackElements.length; i++) {
                sb.append(Utils.indent(4) + stackElements[i].toString() + "\n");
            }
        } else {
            sb.append("invoke stack here is null, unknown reason\n");
        }
        String content = "getStack: \n" + Utils.endLine(sb.toString());
        Writer.write(logDataLocal.get().peek(), content);
    }


    public static void logReturnVal() {
        checkLocal();
        DataStack dataStack = threadLocal.get();
        Stack<Object> stack = dataStack.getData();
        Object[] objs = new Object[stack.size()];
        for (int i = 0; i < objs.length; i++) objs[i] = stack.pop();
        String res = "logReturnVal: \n" + Utils.head() + "return val:\n" + Utils.logData("retVal", objs);
        String content = Utils.endLine(res);
        Writer.write(logDataLocal.get().peek(), content);
    }


    public static void logVariables() {
        checkLocal();
        DataStack dataStack = threadLocal.get();
        Stack<Object> stack = dataStack.getData();
        Object[] objs = new Object[stack.size()];
        for (int i = 0; i < objs.length; i++) objs[i] = stack.pop();
        String res = "logVariables: \n" + Utils.head() + "variable:\n" + Utils.logData("vari", objs);
        String content = Utils.endLine(res);
        Writer.write(logDataLocal.get().peek(), content);
    }


    public static void logNonStaticVoid() {
        checkLocal();
        DataStack dataStack = threadLocal.get();
        Stack<Object> stack = dataStack.getData();
        Object[] objs = new Object[stack.size() - 1];
        Object source = stack.pop();
        for (int i = 0; i < objs.length; i++) objs[i] = stack.pop();
        StringBuilder sb = new StringBuilder();
        sb.append("logNonStaticVoid: \n");
        sb.append(Utils.head());
        if (source == null) sb.append("invoke source is null!\n");
        else
            sb.append("invoke source: " + source.getClass().getName() + " -> " + Utils.handlePara(source) + "\n");
        sb.append("invoke parameters: \n");
        sb.append(Utils.logData("para", objs));
        sb.append("return type is void\n");
        String content = Utils.endLine(sb.toString());
        Writer.write(logDataLocal.get().peek(), content);
    }


    public static void logNonStaticNonVoid(Object result) {
        checkLocal();
        DataStack dataStack = threadLocal.get();
        Stack<Object> stack = dataStack.getData();
        Object[] objs = new Object[stack.size() - 1];
        Object source = stack.pop();
        for (int i = 0; i < objs.length; i++) objs[i] = stack.pop();
        StringBuilder sb = new StringBuilder();
        sb.append("logNonStaticNonVoid: \n");
        sb.append(Utils.head());
        if (source == null) sb.append("invoke source is null!\n");
        else
            sb.append("invoke source: " + source.getClass().getName() + " -> " + Utils.handlePara(source) + "\n");
        sb.append("invoke parameters: \n");
        sb.append(Utils.logData("para", objs));
        sb.append("invoke result:\n" + Utils.handleParas("res", result));
        String content = Utils.endLine(sb.toString());
        Writer.write(logDataLocal.get().peek(), content);
    }


    public static void logStaticVoid() {
        checkLocal();
        DataStack dataStack = threadLocal.get();
        Stack<Object> stack = dataStack.getData();
        Object[] objs = new Object[stack.size()];
        for (int i = 0; i < objs.length; i++) objs[i] = stack.pop();
        StringBuilder sb = new StringBuilder();
        sb.append("logStaticVoid: \n");
        sb.append(Utils.head());
        sb.append("invoke parameters: \n");
        sb.append(Utils.logData("para", objs));
        sb.append("return type is void\n");
        String content = Utils.endLine(sb.toString());
        Writer.write(logDataLocal.get().peek(), content);
    }


    public static void logStaticNonVoid(Object obj) {
        checkLocal();
        DataStack dataStack = threadLocal.get();
        Stack<Object> stack = dataStack.getData();
        Object[] objs = new Object[stack.size()];
        for (int i = 0; i < objs.length; i++) objs[i] = stack.pop();
        StringBuilder sb = new StringBuilder();
        sb.append("logStaticNonVoid: \n");
        sb.append(Utils.head());
        sb.append("invoke parameters: \n");
        sb.append(Utils.logData("para", objs));
        sb.append("invoke result:\n" + Utils.handleParas("res", obj));
        String content = Utils.endLine(sb.toString());
        Writer.write(logDataLocal.get().peek(), content);
    }
}
