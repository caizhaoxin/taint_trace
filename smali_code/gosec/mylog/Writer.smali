.class public Lgosec/mylog/Writer;
.super Ljava/lang/Object;
.source "Writer.java"


# static fields
.field public static bufferedWriter:Ljava/io/BufferedWriter;

.field public static dataLogFileName:Ljava/lang/String;

.field public static endLBQ:Ljava/util/concurrent/LinkedBlockingQueue;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/LinkedBlockingQueue<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field public static fileName:Ljava/lang/String;

.field public static packageName:Ljava/lang/String;

.field public static procedureLBQ:Ljava/util/concurrent/LinkedBlockingQueue;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/LinkedBlockingQueue<",
            "Lgosec/mylog/ProcedureItem;",
            ">;"
        }
    .end annotation
.end field

.field public static rootPath:Ljava/lang/String;

.field public static tmpPath:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 8

    .line 27
    const-string v0, "cn.demo.demo"

    sput-object v0, Lgosec/mylog/Writer;->packageName:Ljava/lang/String;

    .line 29
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "data"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v2, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lgosec/mylog/Writer;->rootPath:Ljava/lang/String;

    .line 30
    const-string v0, "log_tmp"

    sput-object v0, Lgosec/mylog/Writer;->tmpPath:Ljava/lang/String;

    .line 31
    const-string v0, "data.txt"

    sput-object v0, Lgosec/mylog/Writer;->fileName:Ljava/lang/String;

    .line 34
    new-instance v0, Ljava/util/concurrent/LinkedBlockingQueue;

    const/16 v1, 0x2710

    invoke-direct {v0, v1}, Ljava/util/concurrent/LinkedBlockingQueue;-><init>(I)V

    sput-object v0, Lgosec/mylog/Writer;->procedureLBQ:Ljava/util/concurrent/LinkedBlockingQueue;

    .line 35
    new-instance v0, Ljava/util/concurrent/LinkedBlockingQueue;

    const/16 v1, 0x7d0

    invoke-direct {v0, v1}, Ljava/util/concurrent/LinkedBlockingQueue;-><init>(I)V

    sput-object v0, Lgosec/mylog/Writer;->endLBQ:Ljava/util/concurrent/LinkedBlockingQueue;

    .line 38
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Lgosec/mylog/Writer;->rootPath:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "%s/%s"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v2, 0x2

    new-array v3, v2, [Ljava/lang/Object;

    sget-object v4, Lgosec/mylog/Writer;->packageName:Ljava/lang/String;

    const/4 v5, 0x0

    aput-object v4, v3, v5

    sget-object v4, Lgosec/mylog/Writer;->fileName:Ljava/lang/String;

    const/4 v6, 0x1

    aput-object v4, v3, v6

    invoke-static {v0, v3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lgosec/mylog/Writer;->dataLogFileName:Ljava/lang/String;

    .line 39
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v3, Lgosec/mylog/Writer;->rootPath:Ljava/lang/String;

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-array v1, v2, [Ljava/lang/Object;

    sget-object v2, Lgosec/mylog/Writer;->packageName:Ljava/lang/String;

    aput-object v2, v1, v5

    sget-object v2, Lgosec/mylog/Writer;->tmpPath:Ljava/lang/String;

    aput-object v2, v1, v6

    invoke-static {v0, v1}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lgosec/mylog/Writer;->tmpPath:Ljava/lang/String;

    .line 40
    new-instance v0, Ljava/io/File;

    sget-object v1, Lgosec/mylog/Writer;->dataLogFileName:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 41
    .local v0, "dataLogFile":Ljava/io/File;
    new-instance v1, Ljava/io/File;

    sget-object v2, Lgosec/mylog/Writer;->tmpPath:Ljava/lang/String;

    invoke-direct {v1, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 43
    .local v1, "tmpLogDir":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v2

    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v2

    const-string v3, "\u521b\u5efa\u5931\u8d25"

    if-nez v2, :cond_0

    .line 44
    invoke-virtual {v0}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v2

    invoke-virtual {v2}, Ljava/io/File;->mkdirs()Z

    move-result v2

    .line 45
    .local v2, "result":Z
    if-nez v2, :cond_0

    .line 46
    sget-object v4, Ljava/lang/System;->out:Ljava/io/PrintStream;

    invoke-virtual {v4, v3}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 50
    .end local v2    # "result":Z
    :cond_0
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v2

    if-nez v2, :cond_1

    .line 51
    invoke-virtual {v1}, Ljava/io/File;->mkdirs()Z

    move-result v2

    .line 52
    .restart local v2    # "result":Z
    if-nez v2, :cond_1

    .line 53
    sget-object v4, Ljava/lang/System;->out:Ljava/io/PrintStream;

    invoke-virtual {v4, v3}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 57
    .end local v2    # "result":Z
    :cond_1
    :try_start_0
    new-instance v2, Ljava/io/BufferedWriter;

    new-instance v3, Ljava/io/OutputStreamWriter;

    new-instance v4, Ljava/io/FileOutputStream;

    invoke-direct {v4, v0, v6}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;Z)V

    invoke-direct {v3, v4}, Ljava/io/OutputStreamWriter;-><init>(Ljava/io/OutputStream;)V

    const-wide/high16 v4, 0x4090000000000000L    # 1024.0

    const-wide/high16 v6, 0x4000000000000000L    # 2.0

    .line 58
    invoke-static {v4, v5, v6, v7}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v4

    double-to-int v4, v4

    invoke-direct {v2, v3, v4}, Ljava/io/BufferedWriter;-><init>(Ljava/io/Writer;I)V

    sput-object v2, Lgosec/mylog/Writer;->bufferedWriter:Ljava/io/BufferedWriter;
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 61
    goto :goto_0

    .line 59
    :catch_0
    move-exception v2

    .line 60
    .local v2, "e":Ljava/io/FileNotFoundException;
    invoke-virtual {v2}, Ljava/io/FileNotFoundException;->printStackTrace()V

    .line 63
    .end local v2    # "e":Ljava/io/FileNotFoundException;
    :goto_0
    new-instance v2, Ljava/lang/Thread;

    sget-object v3, Lgosec/mylog/Writer$$ExternalSyntheticLambda0;->INSTANCE:Lgosec/mylog/Writer$$ExternalSyntheticLambda0;

    invoke-direct {v2, v3}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 77
    invoke-virtual {v2}, Ljava/lang/Thread;->start()V

    .line 79
    new-instance v2, Ljava/lang/Thread;

    sget-object v3, Lgosec/mylog/Writer$$ExternalSyntheticLambda1;->INSTANCE:Lgosec/mylog/Writer$$ExternalSyntheticLambda1;

    invoke-direct {v2, v3}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 104
    invoke-virtual {v2}, Ljava/lang/Thread;->start()V

    .line 115
    .end local v0    # "dataLogFile":Ljava/io/File;
    .end local v1    # "tmpLogDir":Ljava/io/File;
    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 26
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static deleteFile(Ljava/lang/String;)V
    .locals 4
    .param p0, "fileName"    # Ljava/lang/String;

    .line 129
    :try_start_0
    new-instance v0, Ljava/io/File;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v2, Lgosec/mylog/Writer;->tmpPath:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    sget-object v2, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 130
    .local v0, "file":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 131
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "\u6210\u529f\u5220\u9664\u6587\u4ef6\uff1a"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v0}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 135
    .end local v0    # "file":Ljava/io/File;
    :cond_0
    goto :goto_0

    .line 133
    :catch_0
    move-exception v0

    .line 134
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 136
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method

.method static synthetic lambda$static$0()V
    .locals 4

    .line 66
    :goto_0
    :try_start_0
    sget-object v0, Lgosec/mylog/Writer;->procedureLBQ:Ljava/util/concurrent/LinkedBlockingQueue;

    invoke-virtual {v0}, Ljava/util/concurrent/LinkedBlockingQueue;->take()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lgosec/mylog/ProcedureItem;

    .line 67
    .local v0, "procedureItem":Lgosec/mylog/ProcedureItem;
    new-instance v1, Ljava/io/FileWriter;

    iget-object v2, v0, Lgosec/mylog/ProcedureItem;->fileName:Ljava/lang/String;

    const/4 v3, 0x1

    invoke-direct {v1, v2, v3}, Ljava/io/FileWriter;-><init>(Ljava/lang/String;Z)V

    .line 68
    .local v1, "fileWriter":Ljava/io/FileWriter;
    iget-object v2, v0, Lgosec/mylog/ProcedureItem;->content:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/io/FileWriter;->append(Ljava/lang/CharSequence;)Ljava/io/Writer;

    .line 69
    invoke-virtual {v1}, Ljava/io/FileWriter;->flush()V

    .line 70
    iget-boolean v2, v0, Lgosec/mylog/ProcedureItem;->over:Z

    if-eqz v2, :cond_0

    .line 71
    sget-object v2, Lgosec/mylog/Writer;->endLBQ:Ljava/util/concurrent/LinkedBlockingQueue;

    iget-object v3, v0, Lgosec/mylog/ProcedureItem;->fileName:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/util/concurrent/LinkedBlockingQueue;->put(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2

    .line 73
    .end local v0    # "procedureItem":Lgosec/mylog/ProcedureItem;
    .end local v1    # "fileWriter":Ljava/io/FileWriter;
    :catch_0
    move-exception v0

    goto :goto_1

    :catch_1
    move-exception v0

    .line 74
    .local v0, "e":Ljava/lang/Exception;
    :goto_1
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 75
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_0
    :goto_2
    goto :goto_0
.end method

.method static synthetic lambda$static$1()V
    .locals 5

    .line 82
    :goto_0
    :try_start_0
    sget-object v0, Lgosec/mylog/Writer;->endLBQ:Ljava/util/concurrent/LinkedBlockingQueue;

    invoke-virtual {v0}, Ljava/util/concurrent/LinkedBlockingQueue;->take()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    .line 83
    .local v0, "tmpLogFile":Ljava/lang/String;
    new-instance v1, Ljava/io/BufferedReader;

    new-instance v2, Ljava/io/FileReader;

    invoke-direct {v2, v0}, Ljava/io/FileReader;-><init>(Ljava/lang/String;)V

    invoke-direct {v1, v2}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    .line 85
    .local v1, "in":Ljava/io/BufferedReader;
    :goto_1
    invoke-virtual {v1}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v2

    move-object v3, v2

    .local v3, "str":Ljava/lang/String;
    if-eqz v2, :cond_0

    .line 87
    sget-object v2, Lgosec/mylog/Writer;->bufferedWriter:Ljava/io/BufferedWriter;

    invoke-virtual {v2, v3}, Ljava/io/BufferedWriter;->write(Ljava/lang/String;)V

    .line 88
    sget-object v2, Lgosec/mylog/Writer;->bufferedWriter:Ljava/io/BufferedWriter;

    const-string v4, "\n"

    invoke-virtual {v2, v4}, Ljava/io/BufferedWriter;->write(Ljava/lang/String;)V

    goto :goto_1

    .line 90
    :cond_0
    invoke-static {v0}, Lgosec/mylog/Writer;->deleteFile(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 97
    .end local v0    # "tmpLogFile":Ljava/lang/String;
    .end local v1    # "in":Ljava/io/BufferedReader;
    .end local v3    # "str":Ljava/lang/String;
    :try_start_1
    sget-object v0, Lgosec/mylog/Writer;->bufferedWriter:Ljava/io/BufferedWriter;

    invoke-virtual {v0}, Ljava/io/BufferedWriter;->flush()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_2

    goto :goto_2

    .line 96
    :catchall_0
    move-exception v0

    goto :goto_4

    .line 93
    :catch_0
    move-exception v0

    .line 94
    .local v0, "e":Ljava/lang/InterruptedException;
    :try_start_2
    invoke-virtual {v0}, Ljava/lang/InterruptedException;->printStackTrace()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 97
    .end local v0    # "e":Ljava/lang/InterruptedException;
    :try_start_3
    sget-object v0, Lgosec/mylog/Writer;->bufferedWriter:Ljava/io/BufferedWriter;

    invoke-virtual {v0}, Ljava/io/BufferedWriter;->flush()V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_2

    goto :goto_2

    .line 91
    :catch_1
    move-exception v0

    .line 92
    .local v0, "e":Ljava/io/IOException;
    :try_start_4
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 97
    .end local v0    # "e":Ljava/io/IOException;
    :try_start_5
    sget-object v0, Lgosec/mylog/Writer;->bufferedWriter:Ljava/io/BufferedWriter;

    invoke-virtual {v0}, Ljava/io/BufferedWriter;->flush()V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_2

    .line 100
    :goto_2
    goto :goto_3

    .line 98
    :catch_2
    move-exception v0

    .line 99
    .restart local v0    # "e":Ljava/io/IOException;
    invoke-virtual {v0}, Ljava/io/IOException;->printStackTrace()V

    .line 101
    .end local v0    # "e":Ljava/io/IOException;
    nop

    :goto_3
    goto :goto_0

    .line 97
    :goto_4
    :try_start_6
    sget-object v1, Lgosec/mylog/Writer;->bufferedWriter:Ljava/io/BufferedWriter;

    invoke-virtual {v1}, Ljava/io/BufferedWriter;->flush()V
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_3

    .line 100
    goto :goto_5

    .line 98
    :catch_3
    move-exception v1

    .line 99
    .local v1, "e":Ljava/io/IOException;
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    .line 101
    .end local v1    # "e":Ljava/io/IOException;
    :goto_5
    throw v0
.end method

.method public static write(Ljava/lang/String;Ljava/lang/String;Z)V
    .locals 3
    .param p0, "hash"    # Ljava/lang/String;
    .param p1, "content"    # Ljava/lang/String;
    .param p2, "over"    # Z

    .line 120
    :try_start_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v1, Lgosec/mylog/Writer;->tmpPath:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 121
    .local v0, "fileName":Ljava/lang/String;
    sget-object v1, Lgosec/mylog/Writer;->procedureLBQ:Ljava/util/concurrent/LinkedBlockingQueue;

    new-instance v2, Lgosec/mylog/ProcedureItem;

    invoke-direct {v2, v0, p1, p2}, Lgosec/mylog/ProcedureItem;-><init>(Ljava/lang/String;Ljava/lang/String;Z)V

    invoke-virtual {v1, v2}, Ljava/util/concurrent/LinkedBlockingQueue;->put(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0

    .line 124
    .end local v0    # "fileName":Ljava/lang/String;
    goto :goto_0

    .line 122
    :catch_0
    move-exception v0

    .line 123
    .local v0, "e":Ljava/lang/InterruptedException;
    invoke-virtual {v0}, Ljava/lang/InterruptedException;->printStackTrace()V

    .line 125
    .end local v0    # "e":Ljava/lang/InterruptedException;
    :goto_0
    return-void
.end method
