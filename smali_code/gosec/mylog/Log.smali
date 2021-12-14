.class public Lgosec/mylog/Log;
.super Ljava/lang/Object;
.source "Log.java"


# static fields
.field static logDataLocal:Ljava/lang/ThreadLocal;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ThreadLocal",
            "<",
            "Ljava/util/Stack",
            "<",
            "Ljava/lang/StringBuilder;",
            ">;>;"
        }
    .end annotation
.end field

.field static threadLocal:Ljava/lang/ThreadLocal;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ThreadLocal",
            "<",
            "Lgosec/mylog/DataStack;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .registers 1

    .prologue
    .line 13
    new-instance v0, Ljava/lang/ThreadLocal;

    invoke-direct {v0}, Ljava/lang/ThreadLocal;-><init>()V

    sput-object v0, Lgosec/mylog/Log;->logDataLocal:Ljava/lang/ThreadLocal;

    .line 14
    new-instance v0, Ljava/lang/ThreadLocal;

    invoke-direct {v0}, Ljava/lang/ThreadLocal;-><init>()V

    sput-object v0, Lgosec/mylog/Log;->threadLocal:Ljava/lang/ThreadLocal;

    return-void
.end method

.method public constructor <init>()V
    .registers 1

    .prologue
    .line 5
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static add(Ljava/lang/Object;)V
    .registers 3
    .param p0, "obj"    # Ljava/lang/Object;

    .prologue
    .line 44
    invoke-static {}, Lgosec/mylog/Log;->checkLocal()V

    .line 45
    sget-object v1, Lgosec/mylog/Log;->threadLocal:Ljava/lang/ThreadLocal;

    invoke-virtual {v1}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lgosec/mylog/DataStack;

    .line 46
    .local v0, "dataStack":Lgosec/mylog/DataStack;
    invoke-virtual {v0, p0}, Lgosec/mylog/DataStack;->addData(Ljava/lang/Object;)V

    .line 47
    return-void
.end method

.method private static checkLocal()V
    .registers 2

    .prologue
    .line 17
    sget-object v0, Lgosec/mylog/Log;->logDataLocal:Ljava/lang/ThreadLocal;

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_12

    sget-object v0, Lgosec/mylog/Log;->logDataLocal:Ljava/lang/ThreadLocal;

    new-instance v1, Ljava/util/Stack;

    invoke-direct {v1}, Ljava/util/Stack;-><init>()V

    invoke-virtual {v0, v1}, Ljava/lang/ThreadLocal;->set(Ljava/lang/Object;)V

    .line 18
    :cond_12
    sget-object v0, Lgosec/mylog/Log;->threadLocal:Ljava/lang/ThreadLocal;

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_24

    sget-object v0, Lgosec/mylog/Log;->threadLocal:Ljava/lang/ThreadLocal;

    new-instance v1, Lgosec/mylog/DataStack;

    invoke-direct {v1}, Lgosec/mylog/DataStack;-><init>()V

    invoke-virtual {v0, v1}, Ljava/lang/ThreadLocal;->set(Ljava/lang/Object;)V

    .line 19
    :cond_24
    return-void
.end method

.method public static end()V
    .registers 10

    .prologue
    const/4 v9, 0x2

    const/4 v8, 0x0

    const/4 v7, 0x1

    .line 30
    invoke-static {}, Lgosec/mylog/Log;->checkLocal()V

    .line 31
    new-instance v4, Ljava/lang/Throwable;

    invoke-direct {v4}, Ljava/lang/Throwable;-><init>()V

    invoke-virtual {v4}, Ljava/lang/Throwable;->getStackTrace()[Ljava/lang/StackTraceElement;

    move-result-object v3

    .line 32
    .local v3, "stackElements":[Ljava/lang/StackTraceElement;
    const-string v4, "Method End Time: %s %s\n"

    new-array v5, v9, [Ljava/lang/Object;

    invoke-static {}, Lgosec/mylog/Utils;->getCurrentTimeMillis()Ljava/lang/String;

    move-result-object v6

    aput-object v6, v5, v8

    invoke-static {}, Lgosec/mylog/Utils;->getCurrentTimeFormat()Ljava/lang/String;

    move-result-object v6

    aput-object v6, v5, v7

    invoke-static {v4, v5}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 33
    .local v0, "end1":Ljava/lang/String;
    const-string v4, "Method Name: %s.%s End!\n"

    new-array v5, v9, [Ljava/lang/Object;

    aget-object v6, v3, v7

    invoke-virtual {v6}, Ljava/lang/StackTraceElement;->getClassName()Ljava/lang/String;

    move-result-object v6

    aput-object v6, v5, v8

    aget-object v6, v3, v7

    invoke-virtual {v6}, Ljava/lang/StackTraceElement;->getMethodName()Ljava/lang/String;

    move-result-object v6

    aput-object v6, v5, v7

    invoke-static {v4, v5}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 34
    .local v1, "end2":Ljava/lang/String;
    sget-object v4, Lgosec/mylog/Log;->logDataLocal:Ljava/lang/ThreadLocal;

    invoke-virtual {v4}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/util/Stack;

    invoke-virtual {v4}, Ljava/util/Stack;->pop()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/StringBuilder;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "****************************************************************************************************************"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "\n"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 35
    .local v2, "logData":Ljava/lang/String;
    invoke-static {v2}, Lgosec/mylog/Writer;->write(Ljava/lang/String;)V

    .line 36
    return-void
.end method

.method public static logInvokeStack()V
    .registers 6

    .prologue
    .line 68
    new-instance v3, Ljava/lang/Throwable;

    invoke-direct {v3}, Ljava/lang/Throwable;-><init>()V

    invoke-virtual {v3}, Ljava/lang/Throwable;->getStackTrace()[Ljava/lang/StackTraceElement;

    move-result-object v2

    .line 69
    .local v2, "stackElements":[Ljava/lang/StackTraceElement;
    new-instance v1, Ljava/lang/StringBuffer;

    invoke-direct {v1}, Ljava/lang/StringBuffer;-><init>()V

    .line 71
    .local v1, "sb":Ljava/lang/StringBuffer;
    invoke-static {}, Lgosec/mylog/Utils;->head()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 72
    if-eqz v2, :cond_48

    .line 73
    const-string v3, "invoke stack:\n"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 74
    const/4 v0, 0x1

    .local v0, "i":I
    :goto_1d
    array-length v3, v2

    if-ge v0, v3, :cond_4d

    .line 75
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v4, 0x4

    invoke-static {v4}, Lgosec/mylog/Utils;->indent(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    aget-object v4, v2, v0

    invoke-virtual {v4}, Ljava/lang/StackTraceElement;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "\n"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 74
    add-int/lit8 v0, v0, 0x1

    goto :goto_1d

    .line 78
    .end local v0    # "i":I
    :cond_48
    const-string v3, "invoke stack here is null, unknown reason\n"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 80
    :cond_4d
    sget-object v3, Lgosec/mylog/Log;->logDataLocal:Ljava/lang/ThreadLocal;

    invoke-virtual {v3}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/util/Stack;

    invoke-virtual {v3}, Ljava/util/Stack;->peek()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/StringBuilder;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "getStack: \n"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v1}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lgosec/mylog/Utils;->endLine(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 82
    return-void
.end method

.method public static logNonStaticNonVoid(Ljava/lang/Object;)V
    .registers 11
    .param p0, "result"    # Ljava/lang/Object;

    .prologue
    .line 131
    invoke-static {}, Lgosec/mylog/Log;->checkLocal()V

    .line 132
    sget-object v6, Lgosec/mylog/Log;->threadLocal:Ljava/lang/ThreadLocal;

    invoke-virtual {v6}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lgosec/mylog/DataStack;

    .line 133
    .local v0, "dataStack":Lgosec/mylog/DataStack;
    invoke-virtual {v0}, Lgosec/mylog/DataStack;->getData()Ljava/util/Stack;

    move-result-object v5

    .line 134
    .local v5, "stack":Ljava/util/Stack;, "Ljava/util/Stack<Ljava/lang/Object;>;"
    invoke-virtual {v5}, Ljava/util/Stack;->size()I

    move-result v6

    add-int/lit8 v6, v6, -0x1

    new-array v2, v6, [Ljava/lang/Object;

    .line 135
    .local v2, "objs":[Ljava/lang/Object;
    invoke-virtual {v5}, Ljava/util/Stack;->pop()Ljava/lang/Object;

    move-result-object v4

    .line 136
    .local v4, "source":Ljava/lang/Object;
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_1c
    array-length v6, v2

    if-ge v1, v6, :cond_28

    invoke-virtual {v5}, Ljava/util/Stack;->pop()Ljava/lang/Object;

    move-result-object v6

    aput-object v6, v2, v1

    add-int/lit8 v1, v1, 0x1

    goto :goto_1c

    .line 137
    :cond_28
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    .line 138
    .local v3, "sb":Ljava/lang/StringBuilder;
    const-string v6, "logNonStaticNonVoid: \n"

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 139
    invoke-static {}, Lgosec/mylog/Utils;->head()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 140
    if-nez v4, :cond_8a

    const-string v6, "invoke source is null!\n"

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 143
    :goto_40
    const-string v6, "invoke parameters: \n"

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 144
    const-string v6, "para"

    invoke-static {v6, v2}, Lgosec/mylog/Utils;->logData(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 146
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "invoke result:\n"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "res"

    const/4 v8, 0x1

    new-array v8, v8, [Ljava/lang/Object;

    const/4 v9, 0x0

    aput-object p0, v8, v9

    invoke-static {v7, v8}, Lgosec/mylog/Utils;->handleParas(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 147
    sget-object v6, Lgosec/mylog/Log;->logDataLocal:Ljava/lang/ThreadLocal;

    invoke-virtual {v6}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/util/Stack;

    invoke-virtual {v6}, Ljava/util/Stack;->peek()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Lgosec/mylog/Utils;->endLine(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 149
    return-void

    .line 142
    :cond_8a
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "invoke source: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v4}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " -> "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-static {v4}, Lgosec/mylog/Utils;->handlePara(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "\n"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_40
.end method

.method public static logNonStaticVoid()V
    .registers 8

    .prologue
    .line 110
    invoke-static {}, Lgosec/mylog/Log;->checkLocal()V

    .line 111
    sget-object v6, Lgosec/mylog/Log;->threadLocal:Ljava/lang/ThreadLocal;

    invoke-virtual {v6}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lgosec/mylog/DataStack;

    .line 112
    .local v0, "dataStack":Lgosec/mylog/DataStack;
    invoke-virtual {v0}, Lgosec/mylog/DataStack;->getData()Ljava/util/Stack;

    move-result-object v5

    .line 113
    .local v5, "stack":Ljava/util/Stack;, "Ljava/util/Stack<Ljava/lang/Object;>;"
    invoke-virtual {v5}, Ljava/util/Stack;->size()I

    move-result v6

    add-int/lit8 v6, v6, -0x1

    new-array v2, v6, [Ljava/lang/Object;

    .line 114
    .local v2, "objs":[Ljava/lang/Object;
    invoke-virtual {v5}, Ljava/util/Stack;->pop()Ljava/lang/Object;

    move-result-object v4

    .line 115
    .local v4, "source":Ljava/lang/Object;
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_1c
    array-length v6, v2

    if-ge v1, v6, :cond_28

    invoke-virtual {v5}, Ljava/util/Stack;->pop()Ljava/lang/Object;

    move-result-object v6

    aput-object v6, v2, v1

    add-int/lit8 v1, v1, 0x1

    goto :goto_1c

    .line 116
    :cond_28
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    .line 117
    .local v3, "sb":Ljava/lang/StringBuilder;
    const-string v6, "logNonStaticVoid: \n"

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 118
    invoke-static {}, Lgosec/mylog/Utils;->head()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 119
    if-nez v4, :cond_6d

    const-string v6, "invoke source is null!\n"

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 122
    :goto_40
    const-string v6, "invoke parameters: \n"

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 123
    const-string v6, "para"

    invoke-static {v6, v2}, Lgosec/mylog/Utils;->logData(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 124
    const-string v6, "return type is void\n"

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 125
    sget-object v6, Lgosec/mylog/Log;->logDataLocal:Ljava/lang/ThreadLocal;

    invoke-virtual {v6}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/util/Stack;

    invoke-virtual {v6}, Ljava/util/Stack;->peek()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Lgosec/mylog/Utils;->endLine(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 127
    return-void

    .line 121
    :cond_6d
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "invoke source: "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v4}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, " -> "

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-static {v4}, Lgosec/mylog/Utils;->handlePara(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v7, "\n"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v3, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_40
.end method

.method public static logParameters()V
    .registers 7

    .prologue
    .line 56
    invoke-static {}, Lgosec/mylog/Log;->checkLocal()V

    .line 57
    sget-object v5, Lgosec/mylog/Log;->threadLocal:Ljava/lang/ThreadLocal;

    invoke-virtual {v5}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lgosec/mylog/DataStack;

    .line 58
    .local v0, "dataStack":Lgosec/mylog/DataStack;
    invoke-virtual {v0}, Lgosec/mylog/DataStack;->getData()Ljava/util/Stack;

    move-result-object v4

    .line 59
    .local v4, "stack":Ljava/util/Stack;, "Ljava/util/Stack<Ljava/lang/Object;>;"
    invoke-virtual {v4}, Ljava/util/Stack;->size()I

    move-result v5

    new-array v2, v5, [Ljava/lang/Object;

    .line 60
    .local v2, "objs":[Ljava/lang/Object;
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_16
    array-length v5, v2

    if-ge v1, v5, :cond_22

    invoke-virtual {v4}, Ljava/util/Stack;->pop()Ljava/lang/Object;

    move-result-object v5

    aput-object v5, v2, v1

    add-int/lit8 v1, v1, 0x1

    goto :goto_16

    .line 61
    :cond_22
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "logParameters: \n"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-static {}, Lgosec/mylog/Utils;->head()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "parameter:\n"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "parameter"

    invoke-static {v6, v2}, Lgosec/mylog/Utils;->logData(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 62
    .local v3, "res":Ljava/lang/String;
    sget-object v5, Lgosec/mylog/Log;->logDataLocal:Ljava/lang/ThreadLocal;

    invoke-virtual {v5}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/util/Stack;

    invoke-virtual {v5}, Ljava/util/Stack;->peek()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/StringBuilder;

    invoke-static {v3}, Lgosec/mylog/Utils;->endLine(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 64
    return-void
.end method

.method public static logReturnVal()V
    .registers 7

    .prologue
    .line 86
    invoke-static {}, Lgosec/mylog/Log;->checkLocal()V

    .line 87
    sget-object v5, Lgosec/mylog/Log;->threadLocal:Ljava/lang/ThreadLocal;

    invoke-virtual {v5}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lgosec/mylog/DataStack;

    .line 88
    .local v0, "dataStack":Lgosec/mylog/DataStack;
    invoke-virtual {v0}, Lgosec/mylog/DataStack;->getData()Ljava/util/Stack;

    move-result-object v4

    .line 89
    .local v4, "stack":Ljava/util/Stack;, "Ljava/util/Stack<Ljava/lang/Object;>;"
    invoke-virtual {v4}, Ljava/util/Stack;->size()I

    move-result v5

    new-array v2, v5, [Ljava/lang/Object;

    .line 90
    .local v2, "objs":[Ljava/lang/Object;
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_16
    array-length v5, v2

    if-ge v1, v5, :cond_22

    invoke-virtual {v4}, Ljava/util/Stack;->pop()Ljava/lang/Object;

    move-result-object v5

    aput-object v5, v2, v1

    add-int/lit8 v1, v1, 0x1

    goto :goto_16

    .line 91
    :cond_22
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "logReturnVal: \n"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-static {}, Lgosec/mylog/Utils;->head()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "return val:\n"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "retVal"

    invoke-static {v6, v2}, Lgosec/mylog/Utils;->logData(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 92
    .local v3, "res":Ljava/lang/String;
    sget-object v5, Lgosec/mylog/Log;->logDataLocal:Ljava/lang/ThreadLocal;

    invoke-virtual {v5}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/util/Stack;

    invoke-virtual {v5}, Ljava/util/Stack;->peek()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/StringBuilder;

    invoke-static {v3}, Lgosec/mylog/Utils;->endLine(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 94
    return-void
.end method

.method public static logStaticNonVoid(Ljava/lang/Object;)V
    .registers 10
    .param p0, "obj"    # Ljava/lang/Object;

    .prologue
    .line 170
    invoke-static {}, Lgosec/mylog/Log;->checkLocal()V

    .line 171
    sget-object v5, Lgosec/mylog/Log;->threadLocal:Ljava/lang/ThreadLocal;

    invoke-virtual {v5}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lgosec/mylog/DataStack;

    .line 172
    .local v0, "dataStack":Lgosec/mylog/DataStack;
    invoke-virtual {v0}, Lgosec/mylog/DataStack;->getData()Ljava/util/Stack;

    move-result-object v4

    .line 173
    .local v4, "stack":Ljava/util/Stack;, "Ljava/util/Stack<Ljava/lang/Object;>;"
    invoke-virtual {v4}, Ljava/util/Stack;->size()I

    move-result v5

    new-array v2, v5, [Ljava/lang/Object;

    .line 174
    .local v2, "objs":[Ljava/lang/Object;
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_16
    array-length v5, v2

    if-ge v1, v5, :cond_22

    invoke-virtual {v4}, Ljava/util/Stack;->pop()Ljava/lang/Object;

    move-result-object v5

    aput-object v5, v2, v1

    add-int/lit8 v1, v1, 0x1

    goto :goto_16

    .line 175
    :cond_22
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    .line 176
    .local v3, "sb":Ljava/lang/StringBuilder;
    const-string v5, "logStaticNonVoid: \n"

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 177
    invoke-static {}, Lgosec/mylog/Utils;->head()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 178
    const-string v5, "invoke parameters: \n"

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 179
    const-string v5, "para"

    invoke-static {v5, v2}, Lgosec/mylog/Utils;->logData(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 180
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "invoke result:\n"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "res"

    const/4 v7, 0x1

    new-array v7, v7, [Ljava/lang/Object;

    const/4 v8, 0x0

    aput-object p0, v7, v8

    invoke-static {v6, v7}, Lgosec/mylog/Utils;->handleParas(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 181
    sget-object v5, Lgosec/mylog/Log;->logDataLocal:Ljava/lang/ThreadLocal;

    invoke-virtual {v5}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/util/Stack;

    invoke-virtual {v5}, Ljava/util/Stack;->peek()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lgosec/mylog/Utils;->endLine(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 183
    return-void
.end method

.method public static logStaticVoid()V
    .registers 7

    .prologue
    .line 153
    invoke-static {}, Lgosec/mylog/Log;->checkLocal()V

    .line 154
    sget-object v5, Lgosec/mylog/Log;->threadLocal:Ljava/lang/ThreadLocal;

    invoke-virtual {v5}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lgosec/mylog/DataStack;

    .line 155
    .local v0, "dataStack":Lgosec/mylog/DataStack;
    invoke-virtual {v0}, Lgosec/mylog/DataStack;->getData()Ljava/util/Stack;

    move-result-object v4

    .line 156
    .local v4, "stack":Ljava/util/Stack;, "Ljava/util/Stack<Ljava/lang/Object;>;"
    invoke-virtual {v4}, Ljava/util/Stack;->size()I

    move-result v5

    new-array v2, v5, [Ljava/lang/Object;

    .line 157
    .local v2, "objs":[Ljava/lang/Object;
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_16
    array-length v5, v2

    if-ge v1, v5, :cond_22

    invoke-virtual {v4}, Ljava/util/Stack;->pop()Ljava/lang/Object;

    move-result-object v5

    aput-object v5, v2, v1

    add-int/lit8 v1, v1, 0x1

    goto :goto_16

    .line 158
    :cond_22
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    .line 159
    .local v3, "sb":Ljava/lang/StringBuilder;
    const-string v5, "logStaticVoid: \n"

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 160
    invoke-static {}, Lgosec/mylog/Utils;->head()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 161
    const-string v5, "invoke parameters: \n"

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 162
    const-string v5, "para"

    invoke-static {v5, v2}, Lgosec/mylog/Utils;->logData(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 163
    const-string v5, "return type is void\n"

    invoke-virtual {v3, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 164
    sget-object v5, Lgosec/mylog/Log;->logDataLocal:Ljava/lang/ThreadLocal;

    invoke-virtual {v5}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/util/Stack;

    invoke-virtual {v5}, Ljava/util/Stack;->peek()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lgosec/mylog/Utils;->endLine(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 166
    return-void
.end method

.method public static logVariables()V
    .registers 7

    .prologue
    .line 98
    invoke-static {}, Lgosec/mylog/Log;->checkLocal()V

    .line 99
    sget-object v5, Lgosec/mylog/Log;->threadLocal:Ljava/lang/ThreadLocal;

    invoke-virtual {v5}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lgosec/mylog/DataStack;

    .line 100
    .local v0, "dataStack":Lgosec/mylog/DataStack;
    invoke-virtual {v0}, Lgosec/mylog/DataStack;->getData()Ljava/util/Stack;

    move-result-object v4

    .line 101
    .local v4, "stack":Ljava/util/Stack;, "Ljava/util/Stack<Ljava/lang/Object;>;"
    invoke-virtual {v4}, Ljava/util/Stack;->size()I

    move-result v5

    new-array v2, v5, [Ljava/lang/Object;

    .line 102
    .local v2, "objs":[Ljava/lang/Object;
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_16
    array-length v5, v2

    if-ge v1, v5, :cond_22

    invoke-virtual {v4}, Ljava/util/Stack;->pop()Ljava/lang/Object;

    move-result-object v5

    aput-object v5, v2, v1

    add-int/lit8 v1, v1, 0x1

    goto :goto_16

    .line 103
    :cond_22
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "logVariables: \n"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-static {}, Lgosec/mylog/Utils;->head()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "variable:\n"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "vari"

    invoke-static {v6, v2}, Lgosec/mylog/Utils;->logData(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 104
    .local v3, "res":Ljava/lang/String;
    sget-object v5, Lgosec/mylog/Log;->logDataLocal:Ljava/lang/ThreadLocal;

    invoke-virtual {v5}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/util/Stack;

    invoke-virtual {v5}, Ljava/util/Stack;->peek()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/StringBuilder;

    invoke-static {v3}, Lgosec/mylog/Utils;->endLine(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 106
    return-void
.end method

.method public static main([Ljava/lang/String;)V
    .registers 1
    .param p0, "args"    # [Ljava/lang/String;

    .prologue
    .line 39
    invoke-static {}, Lgosec/mylog/Log;->start()V

    .line 40
    invoke-static {}, Lgosec/mylog/Log;->end()V

    .line 41
    return-void
.end method

.method public static start()V
    .registers 9

    .prologue
    const/4 v8, 0x2

    const/4 v7, 0x0

    const/4 v6, 0x1

    .line 22
    invoke-static {}, Lgosec/mylog/Log;->checkLocal()V

    .line 23
    new-instance v3, Ljava/lang/Throwable;

    invoke-direct {v3}, Ljava/lang/Throwable;-><init>()V

    invoke-virtual {v3}, Ljava/lang/Throwable;->getStackTrace()[Ljava/lang/StackTraceElement;

    move-result-object v2

    .line 24
    .local v2, "stackElements":[Ljava/lang/StackTraceElement;
    const-string v3, "Method Name: %s.%s\n"

    new-array v4, v8, [Ljava/lang/Object;

    aget-object v5, v2, v6

    invoke-virtual {v5}, Ljava/lang/StackTraceElement;->getClassName()Ljava/lang/String;

    move-result-object v5

    aput-object v5, v4, v7

    aget-object v5, v2, v6

    invoke-virtual {v5}, Ljava/lang/StackTraceElement;->getMethodName()Ljava/lang/String;

    move-result-object v5

    aput-object v5, v4, v6

    invoke-static {v3, v4}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    .line 25
    .local v0, "head1":Ljava/lang/String;
    const-string v3, "Method Start Time: %s %s\n"

    new-array v4, v8, [Ljava/lang/Object;

    invoke-static {}, Lgosec/mylog/Utils;->getCurrentTimeMillis()Ljava/lang/String;

    move-result-object v5

    aput-object v5, v4, v7

    invoke-static {}, Lgosec/mylog/Utils;->getCurrentTimeFormat()Ljava/lang/String;

    move-result-object v5

    aput-object v5, v4, v6

    invoke-static {v3, v4}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 26
    .local v1, "head2":Ljava/lang/String;
    sget-object v3, Lgosec/mylog/Log;->logDataLocal:Ljava/lang/ThreadLocal;

    invoke-virtual {v3}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/util/Stack;

    new-instance v4, Ljava/lang/StringBuilder;

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "-----------------------------------------"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "\n"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-direct {v4, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, v4}, Ljava/util/Stack;->push(Ljava/lang/Object;)Ljava/lang/Object;

    .line 27
    return-void
.end method

.method public static stopAdding()V
    .registers 2

    .prologue
    .line 50
    invoke-static {}, Lgosec/mylog/Log;->checkLocal()V

    .line 51
    sget-object v1, Lgosec/mylog/Log;->threadLocal:Ljava/lang/ThreadLocal;

    invoke-virtual {v1}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lgosec/mylog/DataStack;

    .line 52
    .local v0, "dataStack":Lgosec/mylog/DataStack;
    invoke-virtual {v0}, Lgosec/mylog/DataStack;->stopAdding()V

    .line 53
    return-void
.end method
