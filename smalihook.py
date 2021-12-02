import os  
  
  
#使用register_list来管理寄存器
register_list = []
register_index = -1

#存储火焰图的类和方法
target_class = []
target_method = []

class ParserError(Exception):  
    pass  

#每次都获取一个寄存器，循环利用
def get_register():
    global register_index
    register_index += 1
    register_index %= len(register_list)
    return register_list[register_index]


#把自己定义好的Log类插入到App中
def insert_mylog(package_name):
    root_path = os.path.join(package_name, 'smali')
    #判断是否存在当前文件夹pacage_name/smali
    is_exist_folder = os.path.exists(root_path)
    
    if is_exist_folder:
        #创建文件夹package_name/samli/gosec/mylog
        mylog_location = os.path.join(root_path, 'gosec', 'mylog')
        if not os.path.exists(mylog_location):
            os.makedirs(mylog_location)
        print("successful!")
        
        #把smali写入到gosec/mylog文件夹下
        mylog_smali = os.path.join(mylog_location, 'Log.smali')
        #需要把已经写好的smali文件放入到当前的文件夹下
        current_smali = os.path.join(os.getcwd(), 'Log.smali')
        
        r = open(current_smali, 'r')
        lines = r.readlines()
        
        f = open(mylog_smali, 'w')
        f.writelines(lines)
        
        r.close()
        f.close()
        
    else:
        print(root_path + 'is not exist')


#计算函数传入参数的个数,传入的格式为([BLjava/io/InputStream;Ljava/io/OutputStream;)
def count_arguments(arguments):
    arguments = arguments[1:len(arguments) - 1]
    argumen_count = 0
    
    argument_list = arguments.split(";")
    
    for i in range(0, len(argument_list)):
        
        is_find_array = False
        for j in range(0, len(argument_list[i])):
            char = argument_list[i][j]
            
            if char != '[' and char != 'L':
                if is_find_array:
                    is_find_array = False
                else:
                    argumen_count += 1
                
            if char == 'L' and not is_find_array:
                argumen_count += 1
                break
                
            if char == '[' and not is_find_array:
                argumen_count += 1
                is_find_array = True
                
                
    return argumen_count


##生成log参数和stacktrace的smali代码
def generate_log_parameters(arguments, argument_count, is_static):
    
    #静态和非静态对应的其实参数符号不同
    if is_static:
        if argument_count > 1:
            current_parameter = '{p0 .. p' + str(argument_count - 1) + '}'
        elif argument_count == 1:
            current_parameter = '{p0}'
    else:
        if argument_count > 1:
            current_parameter = '{p1 .. p' + str(argument_count) + '}'
        elif argument_count == 1:
            current_parameter = '{p1}'
    #插入log参数和调用栈的smali语句
    
    #如果没有参数的话就直接打印调用栈
    if argument_count == 0:
        inject_code = [
            '\n',
            '    invoke-static {}, Lcn/log/Log;->getStack()Ljava/lang/String;'
            '\n'
        ]
    #如果有参数则log参数
    elif argument_count > 0:
        inject_code = [
            '\n',
            '    invoke-static {}, Lcn/log/Log;->getStack()Ljava/lang/String;'
            '\n',
            '\n',
            '    invoke-static/range ' + current_parameter + ', Lcn/log/Log;->log' + arguments + 'Ljava/lang/String;',
            '\n'
        ]
    #出错了,返回空列表
    else:
        inject_code = []
    
    return inject_code
    

#   
def inject_code_to_method_section(method_section):  
    
    result_method = []
    #print(method_section)
    #   
    if method_section[0].find("static constructor") != -1:  
        return method_section  
    #   
    if method_section[0].find("synthetic") != -1:  
        return method_section  
    #   
    if method_section[0].find("abstract") != -1:  
        return method_section  
    #   
    
    
    
    
    #获取当前的函数的函数名，参数类型和返回值类型
    method_define = method_section[0]
    print(method_define)
    for i in range(0, len(method_define)):
        char_line = method_define[i]
        if char_line == '(':
            method_des = method_define[0:i]
            argu_start = i
        if char_line == ')':
            argu_end = i + 1
            arguments = method_define[argu_start:argu_end]
            return_type = method_define[argu_end: len(method_define)]
            
    print(method_des)
    print(arguments)
    print(return_type)
    
    
    #获取参数的个数
    argument_count = count_arguments(arguments)
    
    #记录是否要开始插桩
    start_inject = False
    #记录是否插入了参数和调用栈
    is_inject_para_stack = False

    # 这里是插桩的逻辑
    for i in range(0, len(method_section)):  
        statement = method_section[i]
        
        #找到配置寄存器的个数
        if statement.find(".locals") != -1:
            #开始插桩
            start_inject = True
            locals_line = statement.split(" ")
            local_count = locals_line[len(locals_line) - 1]
            local_count = int(local_count)
            #改为14
            new_local_count = 14
            statement = "    .locals " + str(new_local_count) + "\n"
            
            #生成可用的寄存器
            global register_list
            for j in range(local_count, new_local_count):
                register_list.append("v" + str(j))
                
            continue
        
        if start_inject:
            #开始插桩...
            #log参数和调用栈的代码插桩
            if statement == '\n' and not is_inject_para_stack:
                
                #判断是否静态,对应的参数起始符号不一样
                if 'static' in method_des:
                    log_para_inject = generate_log_parameters(arguments, argument_count, True)
                else:
                    log_para_inject = generate_log_parameters(arguments, argument_count, False)
                    
                #插入代码
                if len(log_para_inject) != 0:
                    result_method.extend(log_para_inject)
                    
                is_inject_para_stack = True
                continue
            
            
        
        
        
        result_method.append(statement)
        
        
    for line in result_method:
        print(line)
            
                
            
            
            
                
        
        # if method_section[i].find(".prologue") != -1:  
        #     method_section[i + 1: i + 1] = inject_code
            #return method_section
    
    # for ii in range(0, len(method_section)-1):
    #     if len(method_section[ii].strip())!= 0 and len(method_section[ii+1].strip()) == 0 :   
    #         method_section[ii + 1: ii + 1] = inject_code
    #         #return method_section
    # return method_section  
  
  
def inject_log_code(content):  
    new_content = []  
    method_section = []  
    is_method_begin = False  
    for line in content:  
        if line[:7] == ".method":  
            is_method_begin = True
            method_section.append(line)  
            continue  
        if is_method_begin:  
            method_section.append(line)  
        else:  
            new_content.append(line)  
        if line[:11] == ".end method" and is_method_begin:  
            if not is_method_begin:  
                raise ParserError(".method error")  
            is_method_begin = False  
            new_method_section = inject_code_to_method_section(method_section)  
            new_content.extend(method_section)  
            #print(method_section)
            #print(method_section)
            method_section.clear()
            
    return new_content  
  



#读取火焰图并生成对应的类
def read_flame_function_list():
    r = open('./res.txt', 'r')
    function_list = r.readlines()
    r.close()
    
    for function in function_list:
        class_method = function.split(" ")[0]
        index = class_method.rfind('.')
        if index != -1:
            class_name = class_method[:index]
            method_name = class_method[index + 1:]
            
            package_list = class_name.split('.')
            
            
            #变成文件夹的格式
            class_package_name = ''
            for i in range(0, len(package_list)):
                #print(package_list[i])
                class_package_name = os.path.join(class_package_name, package_list[i])
            
            global target_class
            global target_method
            target_class.append(class_package_name)
            target_method.append(method_name)
        
    

def main():  
    
    read_flame_function_list()
    global target_class
    global target_method
    
    #这里后面需要修改对应的apk名字
    root_path = os.path.join('.', 'demo')
    root_dirs = os.listdir(root_path)
    smali_dirs = []
    print(root_dirs)
    #找到apk目录下存在的smali文件夹
    for dirs in root_dirs:
        if 'smali' in dirs:
            smali_dirs.append(os.path.join(root_path, dirs))
    
    print(smali_dirs)     
    for i in range(0, len(target_class)):
        for j in range(0, len(smali_dirs)):
            class_smali_path = os.path.join(smali_dirs[j], target_class[i] + '.smali')
            #找到了文件
            if os.path.exists(class_smali_path):
                
                #这里找到了class和method所在的文件,可以进行接下来的读操作
                print(class_smali_path)
                
                #跳出循环
                break
    # walker = os.walk("./")  
    # for root, directory, files in walker:  
    #     for file_name in files:  
    #         file_path = os.path.join(root, file_name)
    #         print(file_path)  
    #         file = open(file_path,'r',encoding='UTF-8')  
    #         lines = file.readlines()  
    #         file.close()
    #         new_code = inject_log_code(lines)  
            # file = open(file_path, "w")  
            # file.writelines(new_code)  
            # file.close()  
            # i += 1
            # if i == 100:
            #     os._exit(0)
  
  
if __name__ == '__main__':  
    read_flame_function_list()
    main()
    #read_flame_function_list()
    #insert_mylog("demo")  
