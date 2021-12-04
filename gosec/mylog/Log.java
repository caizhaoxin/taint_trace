package gosec.mylog;

import android.os.Build;

import androidx.annotation.RequiresApi;

import java.util.Stack;

public class Log {
    /**
     * @param objs: 参数
     * @author: caizhaoxin
     * @methodsName: LogNonStatic
     * @description: 用于记录方法的所有参数，一般用在开头输出所有参数
     * @return:
     */
    static ThreadLocal<DataStack> threadLocal = new ThreadLocal<>();

    public static void add(Object obj) {
        if (threadLocal.get() == null) threadLocal.set(new DataStack());
        DataStack dataStack = threadLocal.get();
        dataStack.addData(obj);
    }

    public static void stopAdding() {
        if (threadLocal.get() == null) threadLocal.set(new DataStack());
        DataStack dataStack = threadLocal.get();
        dataStack.stopAdding();
    }

    @RequiresApi(api = Build.VERSION_CODES.O)
    public static void logInvokeStack() {
        StackTraceElement[] stackElements = new Throwable().getStackTrace();
        StringBuffer sb = new StringBuffer();
        // 获取头部信息
        sb.append(Utils.head());
        if (stackElements != null) {
            for (int i = 1; i < stackElements.length; i++) {
                sb.append(Utils.indent(4) + stackElements[i].toString() + "\n");
            }
        }
        Writer.write("getStack: \n" + Utils.endLine(sb.toString()));
    }

    public static void logParameters() {
        if (threadLocal.get() == null) threadLocal.set(new DataStack());
        DataStack dataStack = threadLocal.get();
        Stack<Object> stack = dataStack.getData();
        Object[] objs = new Object[stack.size()];
        for (int i = 0; i < objs.length; i++) objs[i] = stack.pop();
        String res = "logParameters: \n" + Utils.head() + Utils.logData("parameter", objs);
        Writer.write(Utils.endLine(res));
    }

    public static void logReturnVal() {
        if (threadLocal.get() == null) threadLocal.set(new DataStack());
        DataStack dataStack = threadLocal.get();
        Stack<Object> stack = dataStack.getData();
        Object[] objs = new Object[stack.size()];
        for (int i = 0; i < objs.length; i++) objs[i] = stack.pop();
        String res = "logReturnVal: \n" + Utils.head() + Utils.logData("retVal", objs);
        Writer.write(Utils.endLine(res));
    }

    public static void logVariables() {
        if (threadLocal.get() == null) threadLocal.set(new DataStack());
        DataStack dataStack = threadLocal.get();
        Stack<Object> stack = dataStack.getData();
        Object[] objs = new Object[stack.size()];
        for (int i = 0; i < objs.length; i++) objs[i] = stack.pop();
        String res = "logVariables: \n" + Utils.head() + Utils.logData("vari", objs);
        Writer.write(Utils.endLine(res));
    }

    public static void logNonStaticVoid() {
        if (threadLocal.get() == null) threadLocal.set(new DataStack());
        DataStack dataStack = threadLocal.get();
        Stack<Object> stack = dataStack.getData();
        Object[] objs = new Object[stack.size()-1];
        for (int i = 0; i < objs.length; i++) objs[i] = stack.pop();
        Object source = stack.pop();
        StringBuilder sb = new StringBuilder();
        sb.append("logNonStaticVoid: \n");
        sb.append(Utils.head());
        sb.append("invoke source: " + source.getClass().getName() + " -> " + Utils.handlePara(source) + "\n");
        sb.append("invoke parameters: \n");
        sb.append(Utils.logData("para", objs));
        sb.append("return type is void\n");
        Writer.write(Utils.endLine(sb.toString()));
    }

    public static void logNonStaticNonVoid(Object result) {
        if (threadLocal.get() == null) threadLocal.set(new DataStack());
        DataStack dataStack = threadLocal.get();
        Stack<Object> stack = dataStack.getData();
        Object[] objs = new Object[stack.size()-1];
        for (int i = 0; i < objs.length; i++) objs[i] = stack.pop();
        Object source = stack.pop();
        StringBuilder sb = new StringBuilder();
        sb.append("logNonStaticNonVoid: \n");
        sb.append(Utils.head());
        sb.append("invoke source: " + source.getClass().getName() + " -> " + Utils.handlePara(source) + "\n");
        sb.append("invoke parameters: \n");
        sb.append(Utils.logData("para", objs));
        sb.append("invoke result:\n" + Utils.handleParas("res", result));
        Writer.write(Utils.endLine(sb.toString()));
    }

    public static void logStaticVoid() {
        if (threadLocal.get() == null) threadLocal.set(new DataStack());
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
        Writer.write(Utils.endLine(sb.toString()));
    }

    public static void logStaticNonVoid(Object obj) {
        if (threadLocal.get() == null) threadLocal.set(new DataStack());
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
        Writer.write(Utils.endLine(sb.toString()));
    }
}
