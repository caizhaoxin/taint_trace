import os  

  
  

#存储火焰图的类和方法
target_class = []
target_method = []
map_class_method = {}

filter_list = ['Z', 'B', 'C', 'D', 'F', 'I', 'J', 'S']

# table_transfer = {
#     'Z': 'boolean',
#     'B': 'byte',
#     'C': 'char',
#     'D': 'double',
#     'F': 'float',
#     'I': 'int',
#     'J': 'long',
#     'S': 'short'
# }

class ParserError(Exception):  
    pass  

def filter_useless_paras(label_list, paras_list, is_static):
    #print('label_list = ' + str(label_list))
    #print('param_list = ' + str(paras_list))
    result_list = []
    
    if is_static:
        for i in range(0, len(paras_list)):
            if paras_list[i] in filter_list:
                continue
            
            result_list.append(label_list[i])
    else:
        result_list.append(label_list[0])
        for i in range(0, len(paras_list)):
            if paras_list[i] in filter_list:
                continue
            
            result_list.append(label_list[i + 1])
 
    return result_list


#log的时候添加的所要log的值,插入参数的模版
def add_parameters(parameter_list):
    #print(parameter_list)
    
    add_parameters_inject_code = ['\n']
    
    for each_para in parameter_list:
        if each_para != '':
            #print(each_para)
            add_para = '    invoke-static/range {'+ each_para +' .. ' + each_para + '}, Lgosec/mylog/Log;->add(Ljava/lang/Object;)V\n'
            add_parameters_inject_code.append(add_para)
            add_parameters_inject_code.append('\n')
    
    add_parameters_inject_code.append('    invoke-static {}, Lgosec/mylog/Log;->stopAdding()V\n')
    add_parameters_inject_code.append('\n')
    
    return add_parameters_inject_code

def add_stack_log():
    return [
        '\n',
        '    invoke-static {}, Lgosec/mylog/Log;->logInvokeStack()V\n',
        '\n'
    ]
    
#把自己定义好的Log类插入到App中
def insert_mylog_smali_file(package_name):
    #要插入apk的位置
    app_path = os.path.join('.', package_name)
    #smali_code/gosec/mylog,这个位置存放的是已经写好的要插入到apk中的Log文件
    mylog_smali_path = os.path.join('.', 'smali_code', 'gosec', 'mylog')
    dir_list = os.listdir(app_path)
    mylog_smalis = os.listdir(mylog_smali_path)
    print(dir_list)
    smali_list = []
    for each_dir in dir_list:
        if 'smali' in each_dir:
            smali_list.append(each_dir)
            
    print(smali_list)
    length = len(smali_list)
    
    #创建新的smali文件夹,判断smali当前的文件最大是多少,要新创建多一个文件夹
    if length == 1:
        mylog_location = os.path.join(app_path, 'smali_classes2', 'gosec', 'mylog')
    elif length > 1:
        smali_count_list = []
        for each_file in smali_list:
            index = each_file.find('classes')
            if index != -1:
                smali_file_count = int(each_file[index + 7:])
                smali_count_list.append(smali_file_count)
            
        max_value = max(smali_count_list)
            
        mylog_location = os.path.join(app_path, 'smali_classes' + str(max_value + 1), 'gosec', 'mylog')
        
    print(mylog_location)
        
    
    if not os.path.exists(mylog_location):
        os.makedirs(mylog_location)
        
    
    #把本地的Log文件写入到App的smali文件夹中
    for smali_file in mylog_smalis:
        read_path = os.path.join(mylog_smali_path, smali_file)
        write_path = os.path.join(mylog_location, smali_file)
        
        r = open(read_path, 'r')
        f = open(write_path, 'w')
        
        lines = r.readlines()
        f.writelines(lines)
        
        r.close()
        f.close()
        
        
    print('successful!!!')
    


#计算函数传入参数的个数,传入的格式为([BLjava/io/InputStream;Ljava/io/OutputStream;)
def count_arguments(arguments):
    #print('进来了....原始数据为:' + str(arguments))
    str1 = arguments[1: len(arguments) - 1]
    final_argument_list = []
    is_find_array = False
    is_find_class = False
    for i in range(0, len(str1)):
        if str1[i] == 'L' and not is_find_class:
            clazz_start = i
            is_find_class = True
            
            
        if str1[i] == '[' and not is_find_array:
            array_start = i
            is_find_array = True
            
        if str1[i] == ';':
            
            if is_find_class and is_find_array:
                final_argument_list.append(str1[clazz_start: i + 1])
                is_find_array = False
                is_find_class = False
                
            elif is_find_class:
                final_argument_list.append(str1[clazz_start: i + 1])
                is_find_class = False
            
            elif is_find_array:
                final_argument_list.append(str1[array_start: i + 1])
                is_find_array = False
                
        if str1[i] != 'L' and str1[i] != '[' and str1[i] != ';' and not is_find_class:
            
            if is_find_array:
                final_argument_list.append(str1[array_start: i + 1])
                is_find_array = False
        
            else:
                final_argument_list.append(str1[i])
                
    argument_count = len(final_argument_list)
    return argument_count, final_argument_list

    


##生成log参数和stacktrace的smali代码
def generate_log_parameters(arguments, argument_count, is_static):
    if argument_count == 0:
        return []
    
    inject_code = []
    paras_list = []
    #静态和非静态对应的其实参数符号不同
    if is_static:
        for i in range(0, argument_count):
            
            #判断是否为基本数据类型
            if arguments[i] in filter_list:
                continue
            
            paras_list.append('p' + str(i))
    else:
        for i in range(1, argument_count + 1):
            
            #判断是否为基本数据类型
            if arguments[i - 1] in filter_list:
                continue
            
            paras_list.append('p' + str(i))
    
    #生成log参数的代码
    add_code = add_parameters(paras_list)
    
    inject_code.extend(add_code)
    
    inject_code.extend([
        '    invoke-static {}, Lgosec/mylog/Log;->logParameters()V\n',
        '\n'
    ])
    
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
    #print(method_define)
    for i in range(0, len(method_define)):
        char_line = method_define[i]
        if char_line == '(':
            method_des = method_define[0:i]
            argu_start = i
        if char_line == ')':
            argu_end = i + 1
            arguments = method_define[argu_start:argu_end]
            return_type = method_define[argu_end: len(method_define)]
            
    
    #获取参数的个数
    argument_count, final_argument_list = count_arguments(arguments)
    
    #记录是否要开始插桩
    start_inject = False
    
    #记录是否插入了参数和调用栈
    is_inject_para_stack = False
    
    is_return = False

    # 这里是插桩的逻辑
    for i in range(0, len(method_section)):  
        raw_statement = method_section[i]
        statement = method_section[i].strip()
        result_method.append(raw_statement + '\n')
        
        #找到配置寄存器的个数
        if statement.startswith(".locals") and not start_inject:
            #print('statement = :' + statement)
            #开始插桩
            start_inject = True
                      
            #打印调用栈
            result_method.extend(add_stack_log())
                
            #判断是否静态,对应的参数起始符号不一样
            if 'static' in method_des:
                log_para_inject = generate_log_parameters(final_argument_list, argument_count, True)
            else:
                log_para_inject = generate_log_parameters(final_argument_list, argument_count, False)
                    
            #插入代码
            if len(log_para_inject) != 0:
                result_method.extend(log_para_inject)
                

            continue
        
        if start_inject:
            # 开始插桩...
            # log参数和调用栈的代码插桩
            
            #找到调用函数的地方了
            if statement.startswith('move-result-object'):
                # print('===================================')
                # print(method_section[i - 2:i + 1])
                #获取到invoke到return的语句
                invoke_return_smali = method_section[i - 2: i + 1]
                #类似于invoke-static {v0, v1}, Lcom/mob/commons/b;->a(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;
                invoke_smali = invoke_return_smali[0].strip()
                #类似于move-result-object v0
                return_smali = invoke_return_smali[2].strip()
                
                #获取参数
                bracket_start = invoke_smali.find('(')
                bracket_end = invoke_smali.find(')')
                invoke_paras = invoke_smali[bracket_start: bracket_end + 1]
                #print('invoke_paras = ' + invoke_paras)
                argument_count, final_argument_list = count_arguments(invoke_paras)
                
                #操作字符串
                start = invoke_smali.find('{')
                end = invoke_smali.find('}')
                
                return_info = return_smali.split(' ')
                
                #类似于v0, v1
                invoke_label_raw = invoke_smali[start + 1: end]
                #print('invoke_paras_raw = ' + str(invoke_paras_raw))
                #类似于v0
                return_para = return_info[1]
                
                
                #invoke_paras = []
                invoke_label = []
                #类似于[v0, v1]
                if invoke_label_raw.find(', ') != -1:
                    invoke_label = invoke_label_raw.split(', ')
                #类似于{p1 .. p3}
                elif invoke_label_raw.find(' .. ') != -1:
                    #类似于[p1, p3]
                    range_start_end = invoke_label_raw.split(' .. ')
                    #p1
                    range_start_label = range_start_end[0]
                    #p3
                    range_end_label = range_start_end[1]
                    #1
                    start_count = range_start_label[1:]
                    #3
                    end_count = range_end_label[1:]
                    #p
                    label = range_start_label[0]
                    
                    #[p1, p2, p3]
                    for k in range(int(start_count), int(end_count) + 1):
                        invoke_label.append(label + str(k))
                        
                elif invoke_label_raw.find(', ') == -1 and invoke_label_raw.find(' .. ') == -1:
                    invoke_label = [invoke_label_raw]
                #print('last_invoke_paras = ' + str(invoke_paras))
                
                
                filtered_paras_list = []
                is_invoke_static = False
                #筛掉没用的符号和参数
                if invoke_smali.startswith('invoke-static'):
                    #静态调用
                    filtered_paras_list = filter_useless_paras(invoke_label, final_argument_list, True)
                    is_invoke_static = True
                else:
                    #非静态调用
                    filtered_paras_list = filter_useless_paras(invoke_label, final_argument_list, False)
                
                
                
                #插入add参数的log方法
                log_paras = add_parameters(filtered_paras_list)
                log_paras.extend(invoke_return_smali)
                log_paras.append('\n')
                
                #插入log函数调用返回值的操作
                if invoke_smali.startswith('invoke'):
                    if is_invoke_static:
                        #静态调用
                        log_paras.extend([
                            '    invoke-static/range {' + return_para + ' .. ' + return_para + '}, Lgosec/mylog/Log;->logStaticNonVoid(Ljava/lang/Object;)V\n',
                            '\n'
                        ])
                    else:
                        #非静态调用
                        log_paras.extend([
                            '    invoke-static/range {' + return_para + ' .. ' + return_para + '}, Lgosec/mylog/Log;->logNonStaticNonVoid(Ljava/lang/Object;)V\n',
                            '\n'
                        ])
                    
                    #因为读到这一行move-result-object的时候result_method已经读取了之前的两行invoke操作了,所以要先把它去除掉,在插桩上我们的代码
                    
                    del result_method[-3:]
                    result_method.extend(log_paras)
                
                #跳过接下来的操作
                continue
            
            #碰到当前函数的返回值了,可能有switch语句会出现多个return
            if statement.startswith('return-object'):
                
                result_method.pop()
                
                return_def = statement.split(' ')
                return_register = return_def[1]
                
                inject_return_log = add_parameters([return_register])
                #在return之前插入
                result_method.extend(inject_return_log)
                result_method.extend([
                    '    invoke-static {}, Lgosec/mylog/Log;->logReturnVal()V\n',
                    '\n',
                    '    ' + statement + '\n',
                    '\n'
                ])
        
        
        
        
        
    return result_method
        
        
  
  
def inject_log_code(content, method_set):  
    method_list = list(method_set)
    #print('method_set = ' + str(method_list))
    new_content = []  
    method_section = []  
    is_method_begin = False  
    #找到对应的函数
    for line in content:  
        #找到对应的函数了
        if line[:7] == ".method":  
            str_list = line.split(' ', 3)
            method_name_raw = str_list[len(str_list) - 1]
            
            #print(method_name_raw)
            # if 'init' in method_i:
            #     print('method_i = ' + method_i)
            #     print('method_name = ' + method_name)
            for each_method in method_list:
            
                if str(method_name_raw).strip() == each_method:
                    #print('find method need to insert:' + method_name_raw)
                    is_method_begin = True
                    method_section.append(line)  
                    break
            
            if is_method_begin:
                continue  
        if is_method_begin:  
            method_section.append(line)  
        else:  
            new_content.append(line)  
        if line[:11] == ".end method" and is_method_begin:  
            #method_section.append(line) 
            is_method_begin = False  
            #对这个函数插桩代码
            #print()
            new_method_section = inject_code_to_method_section(method_section)  
            new_content.extend(new_method_section)  
            method_section.clear()
            
    return new_content  
  



#读取火焰图并生成对应的类
def read_flame_function_list():
    r = open('./res.txt', 'r')
    function_list = r.readlines()
    r.close()
    
    
    for function in function_list:
        #不需要关注线程名字,这个会在Log类中处理
        if function.startswith('-'):
            continue

        
        index = function.rfind('.')
        if index != -1:
            class_name = function[:index]
            method_name = function[index + 1:].replace(' ', '')
            method_name = method_name.replace('\n','')
            #print('class_name = ' + class_name)
            #print('method_name = ' + method_name)
            
            package_list = class_name.split('.')
            
            
            #变成文件夹的格式
            class_package_name = ''
            for i in range(0, len(package_list)):
                #print(package_list[i])
                class_package_name = os.path.join(class_package_name, package_list[i])
            
            # global target_class
            # global target_method
            # target_class.append(class_package_name)
            # target_method.append(method_name)
            
            global map_class_method
            if class_package_name in map_class_method.keys():
                method_set = map_class_method[class_package_name]
                method_set.add(method_name)
                map_class_method[class_package_name] = method_set
            else:
                map_class_method[class_package_name] = set([method_name])

#利用命令行反编译
def decompile_apk(package_name):
    decompile_command = 'java -jar apktool_2.6.0.jar d ' + package_name + '.apk'
    os.system(decompile_command)
    
def recompile_apk(package_name):
    recompile_command = 'java -jar apktool_2.6.0.jar b ' + os.path.join('.', package_name) + ' -o ' + os.path.join('.', 'result.apk')
    os.system(recompile_command)

def main(package_name):  
    
    #反编译
    decompile_apk(package_name)
    #在apk中插入自己的Log类
    insert_mylog_smali_file(package_name)
    #读取火焰图
    read_flame_function_list()
    
    # global target_class
    # global target_method
    global map_class_method
    
    
    #开始读取smali文件
    root_path = os.path.join('.', package_name)
    root_dirs = os.listdir(root_path)
    smali_dirs = []
    #print(root_dirs)
    #找到apk目录下存在的smali文件夹
    for dirs in root_dirs:
        if 'smali' in dirs:
            smali_dirs.append(os.path.join(root_path, dirs))
    
    #print(smali_dirs)     
    
    print('总的smali文件数:' + str(len(map_class_method)))
    #print('总的插桩方法数为:' + str(len(target_method)))
    all_count = 0
    key_count = 0
    # for i in range(0, len(target_class)):
    for key in map_class_method.keys():
        print(key)
        key_count += 1
        for j in range(0, len(smali_dirs)):
            class_smali_path = os.path.join(smali_dirs[j], key + '.smali')
            #找到了文件
            if os.path.exists(class_smali_path):
                all_count += 1
                
                
                
                
                print('现在处理第' + str(all_count) + '文件....')
                #print('class_file = ' + class_smali_path)
                #这里找到了class和method所在的文件,可以进行接下来的读操作
                smali_file = open(class_smali_path,'r',encoding='UTF-8')  
                lines = smali_file.readlines()  
                smali_file.close()
                
                
                #修改smali文件,返回一个新的smali文件
                #print('插桩的类是' + class_smali_path + '...插桩的方法是' + target_method[i])
                new_code = inject_log_code(lines, map_class_method[key])
                smali_file = open(class_smali_path, 'w')
                smali_file.writelines(new_code)
                smali_file.close()
                
                print('第' + str(all_count) + '个文件处理完毕....')
                #跳出循环
                break
     
    #print('keycount = ' + str(key_count))       
    #recompile_apk(package_name)
    print('结束拉======================================================================')
  
  
if __name__ == '__main__':  
    main('base')
    
