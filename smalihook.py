import os  
  
  
#使用register_list来管理寄存器
register_list = []
register_index = -1

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


#生成输出的代码
def generate_log_parameters(argument_count):
    inject_code = []
    inject_code.append("\n")
    for i in range(0, argument_count):
        #获取一个寄存器
        current_register = get_register()
        #当前参数的符号是pi
        current_parameter = "p" + str(i + 1)
        
        #生成log参数的代码...
    
    
    inject_code.append("\n")
    return inject_code
    

#   
def inject_code_to_method_section(method_section):  
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
    
    

    # 这里是插桩的逻辑
    for i in range(0, len(method_section)):  
        print(method_section[i])
        #记录是否要开始插桩
        start_inject = False
        #找到配置寄存器的个数
        if method_section[i].find(".locals") != -1:
            #开始插桩
            start_inject = True
            locals_line = method_section[i].split(" ")
            local_count = locals_line[len(locals_line) - 1]
            local_count = int(local_count)
            #改为14
            new_local_count = 14
            method_section[i] = "    .locals " + str(new_local_count) + "\n"
            
            #生成可用的寄存器
            global register_list
            for j in range(local_count, new_local_count):
                register_list.append("v" + str(j))
                
            continue
        
        if start_inject:
            #开始插桩...
            return
            
                
            
            
            
                
        
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
  
  
def main():  
    i = 0
    walker = os.walk("./")  
    for root, directory, files in walker:  
        for file_name in files:  
            if file_name != "Util.smali" or file_name[:5] == "Cocos":  
                continue  
            file_path = root + "/" + file_name  
            print(file_path)  
            file = open(file_path,'r',encoding='UTF-8')  
            lines = file.readlines()  
            file.close()
            new_code = inject_log_code(lines)  
            # file = open(file_path, "w")  
            # file.writelines(new_code)  
            # file.close()  
            # i += 1
            # if i == 100:
            #     os._exit(0)
  
  
if __name__ == '__main__':  
    #main()
    insert_mylog("demo")  
