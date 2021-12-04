package gosec.mylog;


public class Demo {
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
        String packageName = "cn.log";
        String fileName = "data.txt";
        // 打印调用栈
        Log.logInvokeStack();
        // 打印参数
        Log.add(a);
        Log.stopAdding(); Log.logParameters();
        // 打印中间某个寄存器的值
        Log.add(c);
        Log.stopAdding(); Log.logVariables();
        // 打印结果的值
        Log.add(b);
        Log.stopAdding(); Log.logReturnVal();
        // 调用返回类型为void 的 静态方法 打印赋值关系
        Log.add(b);Log.add(c);
        Log.stopAdding(); Log.logStaticVoid();
        // 调用返回类型为void 的 实例方法 打印赋值关系， 注意这里的c，也就是第二个参数是调用这个方法的实例！
        Log.add(b);Log.add(c);
        Log.stopAdding(); Log.logNonStaticVoid();
       // 调用返回类型 不是void 的 静态方法 打印赋值关系
        Log.add(a);Log.add(arr1);
        Log.stopAdding(); Log.logStaticNonVoid(infos);
        // 调用返回类型 不是void 的 实例方法 打印赋值关系 ， 同样！注意这里的c，也就是第三个参数是调用这个方法的实例！
        Log.add(a);Log.add(arr2);
        Log.stopAdding(); Log.logNonStaticNonVoid(infos);
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





