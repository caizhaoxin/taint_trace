.class public Lgosec/mylog/Log;
.super Ljava/lang/Object;
.source "Log.java"


# static fields
.field private static index:Ljava/util/concurrent/atomic/AtomicLong;

.field static logDataLocal:Ljava/lang/ThreadLocal;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ThreadLocal<",
            "Ljava/util/Stack<",
            "Ljava/lang/String;",
            ">;>;"
        }
    .end annotation
.end field

.field static threadLocal:Ljava/lang/ThreadLocal;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ThreadLocal<",
            "Lgosec/mylog/DataStack;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .line 14
    new-instance v0, Ljava/util/concurrent/atomic/AtomicLong;

    const-wide/16 v1, 0x1

    invoke-direct {v0, v1, v2}, Ljava/util/concurrent/atomic/AtomicLong;-><init>(J)V

    sput-object v0, Lgosec/mylog/Log;->index:Ljava/util/concurrent/atomic/AtomicLong;

    .line 19
    new-instance v0, Ljava/lang/ThreadLocal;

    invoke-direct {v0}, Ljava/lang/ThreadLocal;-><init>()V

    sput-object v0, Lgosec/mylog/Log;->logDataLocal:Ljava/lang/ThreadLocal;

    .line 20
    new-instance v0, Ljava/lang/ThreadLocal;

    invoke-direct {v0}, Ljava/lang/ThreadLocal;-><init>()V

    sput-object v0, Lgosec/mylog/Log;->threadLocal:Ljava/lang/ThreadLocal;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 6
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static add(Ljava/lang/Object;)V
    .locals 1
    .param p0, "obj"    # Ljava/lang/Object;

    .line 55
    invoke-static {}, Lgosec/mylog/Log;->checkLocal()V

    .line 56
    sget-object v0, Lgosec/mylog/Log;->threadLocal:Ljava/lang/ThreadLocal;

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lgosec/mylog/DataStack;

    .line 57
    .local v0, "dataStack":Lgosec/mylog/DataStack;
    invoke-virtual {v0, p0}, Lgosec/mylog/DataStack;->addData(Ljava/lang/Object;)V

    .line 58
    return-void
.end method

.method private static checkLocal()V
    .locals 2

    .line 23
    sget-object v0, Lgosec/mylog/Log;->logDataLocal:Ljava/lang/ThreadLocal;

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_0

    sget-object v0, Lgosec/mylog/Log;->logDataLocal:Ljava/lang/ThreadLocal;

    new-instance v1, Ljava/util/Stack;

    invoke-direct {v1}, Ljava/util/Stack;-><init>()V

    invoke-virtual {v0, v1}, Ljava/lang/ThreadLocal;->set(Ljava/lang/Object;)V

    .line 24
    :cond_0
    sget-object v0, Lgosec/mylog/Log;->threadLocal:Ljava/lang/ThreadLocal;

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    if-nez v0, :cond_1

    sget-object v0, Lgosec/mylog/Log;->threadLocal:Ljava/lang/ThreadLocal;

    new-instance v1, Lgosec/mylog/DataStack;

    invoke-direct {v1}, Lgosec/mylog/DataStack;-><init>()V

    invoke-virtual {v0, v1}, Ljava/lang/ThreadLocal;->set(Ljava/lang/Object;)V

    .line 25
    :cond_1
    return-void
.end method

.method public static end()V
    .locals 7

    .line 44
    invoke-static {}, Lgosec/mylog/Log;->checkLocal()V

    .line 45
    new-instance v0, Ljava/lang/Throwable;

    invoke-direct {v0}, Ljava/lang/Throwable;-><init>()V

    invoke-virtual {v0}, Ljava/lang/Throwable;->getStackTrace()[Ljava/lang/StackTraceElement;

    move-result-object v0

    .line 46
    .local v0, "stackElements":[Ljava/lang/StackTraceElement;
    const/4 v1, 0x2

    new-array v2, v1, [Ljava/lang/Object;

    invoke-static {}, Lgosec/mylog/Utils;->getCurrentTimeMillis()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    aput-object v3, v2, v4

    invoke-static {}, Lgosec/mylog/Utils;->getCurrentTimeFormat()Ljava/lang/String;

    move-result-object v3

    const/4 v5, 0x1

    aput-object v3, v2, v5

    const-string v3, "Method End Time: %s %s\n"

    invoke-static {v3, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    .line 47
    .local v2, "end1":Ljava/lang/String;
    new-array v1, v1, [Ljava/lang/Object;

    aget-object v3, v0, v5

    invoke-virtual {v3}, Ljava/lang/StackTraceElement;->getClassName()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v1, v4

    aget-object v3, v0, v5

    invoke-virtual {v3}, Ljava/lang/StackTraceElement;->getMethodName()Ljava/lang/String;

    move-result-object v3

    aput-object v3, v1, v5

    const-string v3, "Method Name: %s.%s End!\n"

    invoke-static {v3, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 48
    .local v1, "end2":Ljava/lang/String;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "****************************************************************************************************************"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "\n"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 49
    .local v3, "content":Ljava/lang/String;
    sget-object v4, Lgosec/mylog/Log;->logDataLocal:Ljava/lang/ThreadLocal;

    invoke-virtual {v4}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/util/Stack;

    .line 50
    .local v4, "stack":Ljava/util/Stack;, "Ljava/util/Stack<Ljava/lang/String;>;"
    invoke-virtual {v4}, Ljava/util/Stack;->pop()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    .line 51
    .local v6, "curHash":Ljava/lang/String;
    invoke-static {v6, v3, v5}, Lgosec/mylog/Writer;->write(Ljava/lang/String;Ljava/lang/String;Z)V

    .line 52
    return-void
.end method

.method private static getHash()Ljava/lang/String;
    .locals 2

    .line 27
    sget-object v0, Lgosec/mylog/Log;->index:Ljava/util/concurrent/atomic/AtomicLong;

    invoke-virtual {v0}, Ljava/util/concurrent/atomic/AtomicLong;->getAndIncrement()J

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Long;->toString(J)Ljava/lang/String;

    move-result-object v0

    .line 28
    .local v0, "res":Ljava/lang/String;
    return-object v0
.end method

.method public static logInvokeStack()V
    .locals 5

    .line 79
    new-instance v0, Ljava/lang/Throwable;

    invoke-direct {v0}, Ljava/lang/Throwable;-><init>()V

    invoke-virtual {v0}, Ljava/lang/Throwable;->getStackTrace()[Ljava/lang/StackTraceElement;

    move-result-object v0

    .line 80
    .local v0, "stackElements":[Ljava/lang/StackTraceElement;
    new-instance v1, Ljava/lang/StringBuffer;

    invoke-direct {v1}, Ljava/lang/StringBuffer;-><init>()V

    .line 82
    .local v1, "sb":Ljava/lang/StringBuffer;
    invoke-static {}, Lgosec/mylog/Utils;->head()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 83
    if-eqz v0, :cond_1

    .line 84
    const-string v2, "invoke stack:\n"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 85
    const/4 v2, 0x1

    .local v2, "i":I
    :goto_0
    array-length v3, v0

    if-ge v2, v3, :cond_0

    .line 86
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v4, 0x4

    invoke-static {v4}, Lgosec/mylog/Utils;->indent(I)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    aget-object v4, v0, v2

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

    .line 85
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .end local v2    # "i":I
    :cond_0
    goto :goto_1

    .line 89
    :cond_1
    const-string v2, "invoke stack here is null, unknown reason\n"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 91
    :goto_1
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "getStack: \n"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v1}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lgosec/mylog/Utils;->endLine(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    .line 92
    .local v2, "content":Ljava/lang/String;
    sget-object v3, Lgosec/mylog/Log;->logDataLocal:Ljava/lang/ThreadLocal;

    invoke-virtual {v3}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/util/Stack;

    invoke-virtual {v3}, Ljava/util/Stack;->peek()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    const/4 v4, 0x0

    invoke-static {v3, v2, v4}, Lgosec/mylog/Writer;->write(Ljava/lang/String;Ljava/lang/String;Z)V

    .line 93
    return-void
.end method

.method public static logNonStaticNonVoid(Ljava/lang/Object;)V
    .locals 9
    .param p0, "result"    # Ljava/lang/Object;

    .line 142
    invoke-static {}, Lgosec/mylog/Log;->checkLocal()V

    .line 143
    sget-object v0, Lgosec/mylog/Log;->threadLocal:Ljava/lang/ThreadLocal;

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lgosec/mylog/DataStack;

    .line 144
    .local v0, "dataStack":Lgosec/mylog/DataStack;
    invoke-virtual {v0}, Lgosec/mylog/DataStack;->getData()Ljava/util/Stack;

    move-result-object v1

    .line 145
    .local v1, "stack":Ljava/util/Stack;, "Ljava/util/Stack<Ljava/lang/Object;>;"
    invoke-virtual {v1}, Ljava/util/Stack;->size()I

    move-result v2

    const/4 v3, 0x1

    sub-int/2addr v2, v3

    new-array v2, v2, [Ljava/lang/Object;

    .line 146
    .local v2, "objs":[Ljava/lang/Object;
    invoke-virtual {v1}, Ljava/util/Stack;->pop()Ljava/lang/Object;

    move-result-object v4

    .line 147
    .local v4, "source":Ljava/lang/Object;
    const/4 v5, 0x0

    .local v5, "i":I
    :goto_0
    array-length v6, v2

    if-ge v5, v6, :cond_0

    invoke-virtual {v1}, Ljava/util/Stack;->pop()Ljava/lang/Object;

    move-result-object v6

    aput-object v6, v2, v5

    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    .line 148
    .end local v5    # "i":I
    :cond_0
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    .line 149
    .local v5, "sb":Ljava/lang/StringBuilder;
    const-string v6, "logNonStaticNonVoid: \n"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 150
    invoke-static {}, Lgosec/mylog/Utils;->head()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 151
    if-nez v4, :cond_1

    const-string v6, "invoke source is null!\n"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_1

    .line 153
    :cond_1
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

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 154
    :goto_1
    const-string v6, "invoke parameters: \n"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 155
    const-string v6, "para"

    invoke-static {v6, v2}, Lgosec/mylog/Utils;->logData(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 156
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "invoke result:\n"

    invoke-virtual {v6, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v7, 0x0

    aput-object p0, v3, v7

    const-string v8, "res"

    invoke-static {v8, v3}, Lgosec/mylog/Utils;->handleParas(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v6, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v5, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 157
    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lgosec/mylog/Utils;->endLine(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 158
    .local v3, "content":Ljava/lang/String;
    sget-object v6, Lgosec/mylog/Log;->logDataLocal:Ljava/lang/ThreadLocal;

    invoke-virtual {v6}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/util/Stack;

    invoke-virtual {v6}, Ljava/util/Stack;->peek()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    invoke-static {v6, v3, v7}, Lgosec/mylog/Writer;->write(Ljava/lang/String;Ljava/lang/String;Z)V

    .line 159
    return-void
.end method

.method public static logNonStaticVoid()V
    .locals 8

    .line 121
    invoke-static {}, Lgosec/mylog/Log;->checkLocal()V

    .line 122
    sget-object v0, Lgosec/mylog/Log;->threadLocal:Ljava/lang/ThreadLocal;

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lgosec/mylog/DataStack;

    .line 123
    .local v0, "dataStack":Lgosec/mylog/DataStack;
    invoke-virtual {v0}, Lgosec/mylog/DataStack;->getData()Ljava/util/Stack;

    move-result-object v1

    .line 124
    .local v1, "stack":Ljava/util/Stack;, "Ljava/util/Stack<Ljava/lang/Object;>;"
    invoke-virtual {v1}, Ljava/util/Stack;->size()I

    move-result v2

    add-int/lit8 v2, v2, -0x1

    new-array v2, v2, [Ljava/lang/Object;

    .line 125
    .local v2, "objs":[Ljava/lang/Object;
    invoke-virtual {v1}, Ljava/util/Stack;->pop()Ljava/lang/Object;

    move-result-object v3

    .line 126
    .local v3, "source":Ljava/lang/Object;
    const/4 v4, 0x0

    .local v4, "i":I
    :goto_0
    array-length v5, v2

    if-ge v4, v5, :cond_0

    invoke-virtual {v1}, Ljava/util/Stack;->pop()Ljava/lang/Object;

    move-result-object v5

    aput-object v5, v2, v4

    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    .line 127
    .end local v4    # "i":I
    :cond_0
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    .line 128
    .local v4, "sb":Ljava/lang/StringBuilder;
    const-string v5, "logNonStaticVoid: \n"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 129
    invoke-static {}, Lgosec/mylog/Utils;->head()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 130
    if-nez v3, :cond_1

    const-string v5, "invoke source is null!\n"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_1

    .line 132
    :cond_1
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "invoke source: "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, " -> "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-static {v3}, Lgosec/mylog/Utils;->handlePara(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "\n"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 133
    :goto_1
    const-string v5, "invoke parameters: \n"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 134
    const-string v5, "para"

    invoke-static {v5, v2}, Lgosec/mylog/Utils;->logData(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 135
    const-string v5, "return type is void\n"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 136
    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lgosec/mylog/Utils;->endLine(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .line 137
    .local v5, "content":Ljava/lang/String;
    sget-object v6, Lgosec/mylog/Log;->logDataLocal:Ljava/lang/ThreadLocal;

    invoke-virtual {v6}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/util/Stack;

    invoke-virtual {v6}, Ljava/util/Stack;->peek()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    const/4 v7, 0x0

    invoke-static {v6, v5, v7}, Lgosec/mylog/Writer;->write(Ljava/lang/String;Ljava/lang/String;Z)V

    .line 138
    return-void
.end method

.method public static logParameters()V
    .locals 7

    .line 67
    invoke-static {}, Lgosec/mylog/Log;->checkLocal()V

    .line 68
    sget-object v0, Lgosec/mylog/Log;->threadLocal:Ljava/lang/ThreadLocal;

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lgosec/mylog/DataStack;

    .line 69
    .local v0, "dataStack":Lgosec/mylog/DataStack;
    invoke-virtual {v0}, Lgosec/mylog/DataStack;->getData()Ljava/util/Stack;

    move-result-object v1

    .line 70
    .local v1, "stack":Ljava/util/Stack;, "Ljava/util/Stack<Ljava/lang/Object;>;"
    invoke-virtual {v1}, Ljava/util/Stack;->size()I

    move-result v2

    new-array v2, v2, [Ljava/lang/Object;

    .line 71
    .local v2, "objs":[Ljava/lang/Object;
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_0
    array-length v4, v2

    if-ge v3, v4, :cond_0

    invoke-virtual {v1}, Ljava/util/Stack;->pop()Ljava/lang/Object;

    move-result-object v4

    aput-object v4, v2, v3

    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 72
    .end local v3    # "i":I
    :cond_0
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "logParameters: \n"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-static {}, Lgosec/mylog/Utils;->head()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "parameter:\n"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "parameter"

    invoke-static {v4, v2}, Lgosec/mylog/Utils;->logData(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 73
    .local v3, "res":Ljava/lang/String;
    invoke-static {v3}, Lgosec/mylog/Utils;->endLine(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 74
    .local v4, "content":Ljava/lang/String;
    sget-object v5, Lgosec/mylog/Log;->logDataLocal:Ljava/lang/ThreadLocal;

    invoke-virtual {v5}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/util/Stack;

    invoke-virtual {v5}, Ljava/util/Stack;->peek()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    const/4 v6, 0x0

    invoke-static {v5, v4, v6}, Lgosec/mylog/Writer;->write(Ljava/lang/String;Ljava/lang/String;Z)V

    .line 75
    return-void
.end method

.method public static logReturnVal()V
    .locals 7

    .line 97
    invoke-static {}, Lgosec/mylog/Log;->checkLocal()V

    .line 98
    sget-object v0, Lgosec/mylog/Log;->threadLocal:Ljava/lang/ThreadLocal;

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lgosec/mylog/DataStack;

    .line 99
    .local v0, "dataStack":Lgosec/mylog/DataStack;
    invoke-virtual {v0}, Lgosec/mylog/DataStack;->getData()Ljava/util/Stack;

    move-result-object v1

    .line 100
    .local v1, "stack":Ljava/util/Stack;, "Ljava/util/Stack<Ljava/lang/Object;>;"
    invoke-virtual {v1}, Ljava/util/Stack;->size()I

    move-result v2

    new-array v2, v2, [Ljava/lang/Object;

    .line 101
    .local v2, "objs":[Ljava/lang/Object;
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_0
    array-length v4, v2

    if-ge v3, v4, :cond_0

    invoke-virtual {v1}, Ljava/util/Stack;->pop()Ljava/lang/Object;

    move-result-object v4

    aput-object v4, v2, v3

    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 102
    .end local v3    # "i":I
    :cond_0
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "logReturnVal: \n"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-static {}, Lgosec/mylog/Utils;->head()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "return val:\n"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "retVal"

    invoke-static {v4, v2}, Lgosec/mylog/Utils;->logData(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 103
    .local v3, "res":Ljava/lang/String;
    invoke-static {v3}, Lgosec/mylog/Utils;->endLine(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 104
    .local v4, "content":Ljava/lang/String;
    sget-object v5, Lgosec/mylog/Log;->logDataLocal:Ljava/lang/ThreadLocal;

    invoke-virtual {v5}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/util/Stack;

    invoke-virtual {v5}, Ljava/util/Stack;->peek()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    const/4 v6, 0x0

    invoke-static {v5, v4, v6}, Lgosec/mylog/Writer;->write(Ljava/lang/String;Ljava/lang/String;Z)V

    .line 105
    return-void
.end method

.method public static logStaticNonVoid(Ljava/lang/Object;)V
    .locals 8
    .param p0, "obj"    # Ljava/lang/Object;

    .line 180
    invoke-static {}, Lgosec/mylog/Log;->checkLocal()V

    .line 181
    sget-object v0, Lgosec/mylog/Log;->threadLocal:Ljava/lang/ThreadLocal;

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lgosec/mylog/DataStack;

    .line 182
    .local v0, "dataStack":Lgosec/mylog/DataStack;
    invoke-virtual {v0}, Lgosec/mylog/DataStack;->getData()Ljava/util/Stack;

    move-result-object v1

    .line 183
    .local v1, "stack":Ljava/util/Stack;, "Ljava/util/Stack<Ljava/lang/Object;>;"
    invoke-virtual {v1}, Ljava/util/Stack;->size()I

    move-result v2

    new-array v2, v2, [Ljava/lang/Object;

    .line 184
    .local v2, "objs":[Ljava/lang/Object;
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_0
    array-length v4, v2

    if-ge v3, v4, :cond_0

    invoke-virtual {v1}, Ljava/util/Stack;->pop()Ljava/lang/Object;

    move-result-object v4

    aput-object v4, v2, v3

    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 185
    .end local v3    # "i":I
    :cond_0
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    .line 186
    .local v3, "sb":Ljava/lang/StringBuilder;
    const-string v4, "logStaticNonVoid: \n"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 187
    invoke-static {}, Lgosec/mylog/Utils;->head()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 188
    const-string v4, "invoke parameters: \n"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 189
    const-string v4, "para"

    invoke-static {v4, v2}, Lgosec/mylog/Utils;->logData(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 190
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "invoke result:\n"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const/4 v5, 0x1

    new-array v5, v5, [Ljava/lang/Object;

    const/4 v6, 0x0

    aput-object p0, v5, v6

    const-string v7, "res"

    invoke-static {v7, v5}, Lgosec/mylog/Utils;->handleParas(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 191
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lgosec/mylog/Utils;->endLine(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 192
    .local v4, "content":Ljava/lang/String;
    sget-object v5, Lgosec/mylog/Log;->logDataLocal:Ljava/lang/ThreadLocal;

    invoke-virtual {v5}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/util/Stack;

    invoke-virtual {v5}, Ljava/util/Stack;->peek()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    invoke-static {v5, v4, v6}, Lgosec/mylog/Writer;->write(Ljava/lang/String;Ljava/lang/String;Z)V

    .line 193
    return-void
.end method

.method public static logStaticVoid()V
    .locals 7

    .line 163
    invoke-static {}, Lgosec/mylog/Log;->checkLocal()V

    .line 164
    sget-object v0, Lgosec/mylog/Log;->threadLocal:Ljava/lang/ThreadLocal;

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lgosec/mylog/DataStack;

    .line 165
    .local v0, "dataStack":Lgosec/mylog/DataStack;
    invoke-virtual {v0}, Lgosec/mylog/DataStack;->getData()Ljava/util/Stack;

    move-result-object v1

    .line 166
    .local v1, "stack":Ljava/util/Stack;, "Ljava/util/Stack<Ljava/lang/Object;>;"
    invoke-virtual {v1}, Ljava/util/Stack;->size()I

    move-result v2

    new-array v2, v2, [Ljava/lang/Object;

    .line 167
    .local v2, "objs":[Ljava/lang/Object;
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_0
    array-length v4, v2

    if-ge v3, v4, :cond_0

    invoke-virtual {v1}, Ljava/util/Stack;->pop()Ljava/lang/Object;

    move-result-object v4

    aput-object v4, v2, v3

    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 168
    .end local v3    # "i":I
    :cond_0
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    .line 169
    .local v3, "sb":Ljava/lang/StringBuilder;
    const-string v4, "logStaticVoid: \n"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 170
    invoke-static {}, Lgosec/mylog/Utils;->head()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 171
    const-string v4, "invoke parameters: \n"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 172
    const-string v4, "para"

    invoke-static {v4, v2}, Lgosec/mylog/Utils;->logData(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 173
    const-string v4, "return type is void\n"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 174
    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lgosec/mylog/Utils;->endLine(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 175
    .local v4, "content":Ljava/lang/String;
    sget-object v5, Lgosec/mylog/Log;->logDataLocal:Ljava/lang/ThreadLocal;

    invoke-virtual {v5}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/util/Stack;

    invoke-virtual {v5}, Ljava/util/Stack;->peek()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    const/4 v6, 0x0

    invoke-static {v5, v4, v6}, Lgosec/mylog/Writer;->write(Ljava/lang/String;Ljava/lang/String;Z)V

    .line 176
    return-void
.end method

.method public static logVariables()V
    .locals 7

    .line 109
    invoke-static {}, Lgosec/mylog/Log;->checkLocal()V

    .line 110
    sget-object v0, Lgosec/mylog/Log;->threadLocal:Ljava/lang/ThreadLocal;

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lgosec/mylog/DataStack;

    .line 111
    .local v0, "dataStack":Lgosec/mylog/DataStack;
    invoke-virtual {v0}, Lgosec/mylog/DataStack;->getData()Ljava/util/Stack;

    move-result-object v1

    .line 112
    .local v1, "stack":Ljava/util/Stack;, "Ljava/util/Stack<Ljava/lang/Object;>;"
    invoke-virtual {v1}, Ljava/util/Stack;->size()I

    move-result v2

    new-array v2, v2, [Ljava/lang/Object;

    .line 113
    .local v2, "objs":[Ljava/lang/Object;
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_0
    array-length v4, v2

    if-ge v3, v4, :cond_0

    invoke-virtual {v1}, Ljava/util/Stack;->pop()Ljava/lang/Object;

    move-result-object v4

    aput-object v4, v2, v3

    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 114
    .end local v3    # "i":I
    :cond_0
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "logVariables: \n"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-static {}, Lgosec/mylog/Utils;->head()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "variable:\n"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "vari"

    invoke-static {v4, v2}, Lgosec/mylog/Utils;->logData(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 115
    .local v3, "res":Ljava/lang/String;
    invoke-static {v3}, Lgosec/mylog/Utils;->endLine(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 116
    .local v4, "content":Ljava/lang/String;
    sget-object v5, Lgosec/mylog/Log;->logDataLocal:Ljava/lang/ThreadLocal;

    invoke-virtual {v5}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/util/Stack;

    invoke-virtual {v5}, Ljava/util/Stack;->peek()Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/String;

    const/4 v6, 0x0

    invoke-static {v5, v4, v6}, Lgosec/mylog/Writer;->write(Ljava/lang/String;Ljava/lang/String;Z)V

    .line 117
    return-void
.end method

.method public static main([Ljava/lang/String;)V
    .locals 0
    .param p0, "args"    # [Ljava/lang/String;

    .line 17
    return-void
.end method

.method public static start()V
    .locals 7

    .line 32
    invoke-static {}, Lgosec/mylog/Log;->checkLocal()V

    .line 33
    new-instance v0, Ljava/lang/Throwable;

    invoke-direct {v0}, Ljava/lang/Throwable;-><init>()V

    invoke-virtual {v0}, Ljava/lang/Throwable;->getStackTrace()[Ljava/lang/StackTraceElement;

    move-result-object v0

    .line 34
    .local v0, "stackElements":[Ljava/lang/StackTraceElement;
    const/4 v1, 0x2

    new-array v2, v1, [Ljava/lang/Object;

    const/4 v3, 0x1

    aget-object v4, v0, v3

    invoke-virtual {v4}, Ljava/lang/StackTraceElement;->getClassName()Ljava/lang/String;

    move-result-object v4

    const/4 v5, 0x0

    aput-object v4, v2, v5

    aget-object v4, v0, v3

    invoke-virtual {v4}, Ljava/lang/StackTraceElement;->getMethodName()Ljava/lang/String;

    move-result-object v4

    aput-object v4, v2, v3

    const-string v4, "Method Name: %s.%s\n"

    invoke-static {v4, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    .line 35
    .local v2, "head1":Ljava/lang/String;
    new-array v1, v1, [Ljava/lang/Object;

    invoke-static {}, Lgosec/mylog/Utils;->getCurrentTimeMillis()Ljava/lang/String;

    move-result-object v4

    aput-object v4, v1, v5

    invoke-static {}, Lgosec/mylog/Utils;->getCurrentTimeFormat()Ljava/lang/String;

    move-result-object v4

    aput-object v4, v1, v3

    const-string v3, "Method Start Time: %s %s\n"

    invoke-static {v3, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 36
    .local v1, "head2":Ljava/lang/String;
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "-----------------------------------------"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "\n"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 37
    .local v3, "content":Ljava/lang/String;
    sget-object v4, Lgosec/mylog/Log;->logDataLocal:Ljava/lang/ThreadLocal;

    invoke-virtual {v4}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/util/Stack;

    .line 38
    .local v4, "stack":Ljava/util/Stack;, "Ljava/util/Stack<Ljava/lang/String;>;"
    invoke-static {}, Lgosec/mylog/Log;->getHash()Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v4, v6}, Ljava/util/Stack;->push(Ljava/lang/Object;)Ljava/lang/Object;

    .line 39
    invoke-virtual {v4}, Ljava/util/Stack;->peek()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    invoke-static {v6}, Lgosec/mylog/Writer;->deleteFile(Ljava/lang/String;)V

    .line 40
    invoke-virtual {v4}, Ljava/util/Stack;->peek()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/lang/String;

    invoke-static {v6, v3, v5}, Lgosec/mylog/Writer;->write(Ljava/lang/String;Ljava/lang/String;Z)V

    .line 41
    return-void
.end method

.method public static stopAdding()V
    .locals 1

    .line 61
    invoke-static {}, Lgosec/mylog/Log;->checkLocal()V

    .line 62
    sget-object v0, Lgosec/mylog/Log;->threadLocal:Ljava/lang/ThreadLocal;

    invoke-virtual {v0}, Ljava/lang/ThreadLocal;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lgosec/mylog/DataStack;

    .line 63
    .local v0, "dataStack":Lgosec/mylog/DataStack;
    invoke-virtual {v0}, Lgosec/mylog/DataStack;->stopAdding()V

    .line 64
    return-void
.end method
