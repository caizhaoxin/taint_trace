.class public Lgosec/mylog/Writer;
.super Ljava/lang/Object;
.source "Writer.java"


# static fields
.field private static final bufSize:I = 0x400

.field public static bufWriMap:Ljava/util/concurrent/ConcurrentHashMap; = null
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/ConcurrentHashMap<",
            "Ljava/lang/String;",
            "Ljava/io/BufferedWriter;",
            ">;"
        }
    .end annotation
.end field

.field public static bufferedWriter:Ljava/io/BufferedWriter; = null

.field public static dataLogFileName:Ljava/lang/String; = null

.field public static endLBQ:Ljava/util/concurrent/LinkedBlockingQueue; = null
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/concurrent/LinkedBlockingQueue<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field public static fileName:Ljava/lang/String; = null

.field private static final itemSize:I = 0x3e8

.field public static packageName:Ljava/lang/String; = null

.field public static procedureLBQList:Ljava/util/List; = null
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/util/concurrent/LinkedBlockingQueue<",
            "Lgosec/mylog/ProcedureItem;",
            ">;>;"
        }
    .end annotation
.end field

.field public static final produreWriterNum:I = 0xa

.field public static rootPath:Ljava/lang/String;

.field public static tmpPath:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 8

    .line 29
    const-string v0, "cn.demo.demo"

    sput-object v0, Lgosec/mylog/Writer;->packageName:Ljava/lang/String;

    .line 31
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

    .line 32
    const-string v0, "log_tmp"

    sput-object v0, Lgosec/mylog/Writer;->tmpPath:Ljava/lang/String;

    .line 33
    const-string v0, "data.txt"

    sput-object v0, Lgosec/mylog/Writer;->fileName:Ljava/lang/String;

    .line 42
    new-instance v0, Ljava/util/concurrent/LinkedBlockingQueue;

    const/16 v1, 0x3e8

    invoke-direct {v0, v1}, Ljava/util/concurrent/LinkedBlockingQueue;-><init>(I)V

    sput-object v0, Lgosec/mylog/Writer;->endLBQ:Ljava/util/concurrent/LinkedBlockingQueue;

    .line 43
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    sput-object v0, Lgosec/mylog/Writer;->bufWriMap:Ljava/util/concurrent/ConcurrentHashMap;

    .line 47
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v2, Lgosec/mylog/Writer;->rootPath:Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, "%s/%s"

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v3, 0x2

    new-array v4, v3, [Ljava/lang/Object;

    sget-object v5, Lgosec/mylog/Writer;->packageName:Ljava/lang/String;

    const/4 v6, 0x0

    aput-object v5, v4, v6

    sget-object v5, Lgosec/mylog/Writer;->fileName:Ljava/lang/String;

    const/4 v7, 0x1

    aput-object v5, v4, v7

    invoke-static {v0, v4}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lgosec/mylog/Writer;->dataLogFileName:Ljava/lang/String;

    .line 48
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v4, Lgosec/mylog/Writer;->rootPath:Ljava/lang/String;

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    new-array v2, v3, [Ljava/lang/Object;

    sget-object v3, Lgosec/mylog/Writer;->packageName:Ljava/lang/String;

    aput-object v3, v2, v6

    sget-object v3, Lgosec/mylog/Writer;->tmpPath:Ljava/lang/String;

    aput-object v3, v2, v7

    invoke-static {v0, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lgosec/mylog/Writer;->tmpPath:Ljava/lang/String;

    .line 49
    new-instance v0, Ljava/io/File;

    sget-object v2, Lgosec/mylog/Writer;->dataLogFileName:Ljava/lang/String;

    invoke-direct {v0, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 50
    .local v0, "dataLogFile":Ljava/io/File;
    new-instance v2, Ljava/io/File;

    sget-object v3, Lgosec/mylog/Writer;->tmpPath:Ljava/lang/String;

    invoke-direct {v2, v3}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 52
    .local v2, "tmpLogDir":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v3

    invoke-virtual {v3}, Ljava/io/File;->exists()Z

    move-result v3

    const-string v4, "\u521b\u5efa\u5931\u8d25"

    if-nez v3, :cond_0

    .line 53
    invoke-virtual {v0}, Ljava/io/File;->getParentFile()Ljava/io/File;

    move-result-object v3

    invoke-virtual {v3}, Ljava/io/File;->mkdirs()Z

    move-result v3

    .line 54
    .local v3, "result":Z
    if-nez v3, :cond_0

    .line 55
    sget-object v5, Ljava/lang/System;->out:Ljava/io/PrintStream;

    invoke-virtual {v5, v4}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 59
    .end local v3    # "result":Z
    :cond_0
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v3

    if-nez v3, :cond_1

    .line 60
    invoke-virtual {v2}, Ljava/io/File;->mkdirs()Z

    move-result v3

    .line 61
    .restart local v3    # "result":Z
    if-nez v3, :cond_1

    .line 62
    sget-object v5, Ljava/lang/System;->out:Ljava/io/PrintStream;

    invoke-virtual {v5, v4}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    .line 66
    .end local v3    # "result":Z
    :cond_1
    :try_start_0
    new-instance v3, Ljava/io/BufferedWriter;

    new-instance v4, Ljava/io/OutputStreamWriter;

    new-instance v5, Ljava/io/FileOutputStream;

    invoke-direct {v5, v0, v7}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;Z)V

    invoke-direct {v4, v5}, Ljava/io/OutputStreamWriter;-><init>(Ljava/io/OutputStream;)V

    const/16 v5, 0x400

    invoke-direct {v3, v4, v5}, Ljava/io/BufferedWriter;-><init>(Ljava/io/Writer;I)V

    sput-object v3, Lgosec/mylog/Writer;->bufferedWriter:Ljava/io/BufferedWriter;
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 70
    goto :goto_0

    .line 68
    :catch_0
    move-exception v3

    .line 69
    .local v3, "e":Ljava/io/FileNotFoundException;
    invoke-virtual {v3}, Ljava/io/FileNotFoundException;->printStackTrace()V

    .line 73
    .end local v3    # "e":Ljava/io/FileNotFoundException;
    :goto_0
    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3}, Ljava/util/ArrayList;-><init>()V

    sput-object v3, Lgosec/mylog/Writer;->procedureLBQList:Ljava/util/List;

    .line 74
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_1
    const/16 v4, 0xa

    if-ge v3, v4, :cond_2

    .line 75
    sget-object v4, Lgosec/mylog/Writer;->procedureLBQList:Ljava/util/List;

    new-instance v5, Ljava/util/concurrent/LinkedBlockingQueue;

    invoke-direct {v5, v1}, Ljava/util/concurrent/LinkedBlockingQueue;-><init>(I)V

    invoke-interface {v4, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 74
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .line 76
    .end local v3    # "i":I
    :cond_2
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_2
    if-ge v1, v4, :cond_3

    .line 77
    move v3, v1

    .line 78
    .local v3, "index":I
    new-instance v5, Ljava/lang/Thread;

    new-instance v6, Lgosec/mylog/Writer$$ExternalSyntheticLambda0;

    invoke-direct {v6, v3}, Lgosec/mylog/Writer$$ExternalSyntheticLambda0;-><init>(I)V

    invoke-direct {v5, v6}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 99
    invoke-virtual {v5}, Ljava/lang/Thread;->start()V

    .line 76
    .end local v3    # "index":I
    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    .line 103
    .end local v1    # "i":I
    :cond_3
    new-instance v1, Ljava/lang/Thread;

    sget-object v3, Lgosec/mylog/Writer$$ExternalSyntheticLambda1;->INSTANCE:Lgosec/mylog/Writer$$ExternalSyntheticLambda1;

    invoke-direct {v1, v3}, Ljava/lang/Thread;-><init>(Ljava/lang/Runnable;)V

    .line 129
    invoke-virtual {v1}, Ljava/lang/Thread;->start()V

    .line 130
    .end local v0    # "dataLogFile":Ljava/io/File;
    .end local v2    # "tmpLogDir":Ljava/io/File;
    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 28
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static deleteFileByFileName(Ljava/lang/String;)V
    .locals 2
    .param p0, "fileName"    # Ljava/lang/String;

    .line 162
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

    invoke-static {v0}, Lgosec/mylog/Writer;->deleteFileByFilePath(Ljava/lang/String;)V

    .line 163
    return-void
.end method

.method public static deleteFileByFilePath(Ljava/lang/String;)V
    .locals 2
    .param p0, "filePath"    # Ljava/lang/String;

    .line 147
    :try_start_0
    new-instance v0, Ljava/io/File;

    invoke-direct {v0, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 148
    .local v0, "file":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-virtual {v0}, Ljava/io/File;->isFile()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 149
    invoke-virtual {v0}, Ljava/io/File;->delete()Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 158
    .end local v0    # "file":Ljava/io/File;
    :cond_0
    goto :goto_0

    .line 156
    :catch_0
    move-exception v0

    .line 157
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 159
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_0
    return-void
.end method

.method static synthetic lambda$static$0(I)V
    .locals 4
    .param p0, "index"    # I

    .line 82
    :goto_0
    :try_start_0
    sget-object v0, Lgosec/mylog/Writer;->procedureLBQList:Ljava/util/List;

    invoke-interface {v0, p0}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/concurrent/LinkedBlockingQueue;

    invoke-virtual {v0}, Ljava/util/concurrent/LinkedBlockingQueue;->take()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lgosec/mylog/ProcedureItem;

    .line 83
    .local v0, "procedureItem":Lgosec/mylog/ProcedureItem;
    sget-object v1, Lgosec/mylog/Writer;->bufWriMap:Ljava/util/concurrent/ConcurrentHashMap;

    iget-object v2, v0, Lgosec/mylog/ProcedureItem;->fileName:Ljava/lang/String;

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Ljava/util/concurrent/ConcurrentHashMap;->getOrDefault(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/io/BufferedWriter;

    .line 84
    .local v1, "bw":Ljava/io/BufferedWriter;
    if-nez v1, :cond_0

    goto :goto_0

    .line 85
    :cond_0
    iget-object v2, v0, Lgosec/mylog/ProcedureItem;->content:Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/io/BufferedWriter;->write(Ljava/lang/String;)V

    .line 89
    iget-boolean v2, v0, Lgosec/mylog/ProcedureItem;->over:Z

    if-eqz v2, :cond_1

    .line 90
    invoke-virtual {v1}, Ljava/io/BufferedWriter;->flush()V

    .line 91
    invoke-virtual {v1}, Ljava/io/BufferedWriter;->close()V

    .line 92
    sget-object v2, Lgosec/mylog/Writer;->bufWriMap:Ljava/util/concurrent/ConcurrentHashMap;

    iget-object v3, v0, Lgosec/mylog/ProcedureItem;->fileName:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/util/concurrent/ConcurrentHashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    .line 93
    sget-object v2, Lgosec/mylog/Writer;->endLBQ:Ljava/util/concurrent/LinkedBlockingQueue;

    iget-object v3, v0, Lgosec/mylog/ProcedureItem;->fileName:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/util/concurrent/LinkedBlockingQueue;->put(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2

    .line 95
    .end local v0    # "procedureItem":Lgosec/mylog/ProcedureItem;
    .end local v1    # "bw":Ljava/io/BufferedWriter;
    :catch_0
    move-exception v0

    goto :goto_1

    :catch_1
    move-exception v0

    .line 96
    .local v0, "e":Ljava/lang/Exception;
    :goto_1
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 97
    .end local v0    # "e":Ljava/lang/Exception;
    :cond_1
    :goto_2
    goto :goto_0
.end method

.method static synthetic lambda$static$1()V
    .locals 5

    .line 105
    :goto_0
    const-string v0, ""

    .line 106
    .local v0, "tmpLogFile":Ljava/lang/String;
    const/4 v1, 0x0

    .line 108
    .local v1, "in":Ljava/io/BufferedReader;
    :try_start_0
    sget-object v2, Lgosec/mylog/Writer;->endLBQ:Ljava/util/concurrent/LinkedBlockingQueue;

    invoke-virtual {v2}, Ljava/util/concurrent/LinkedBlockingQueue;->take()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    move-object v0, v2

    .line 109
    new-instance v2, Ljava/io/BufferedReader;

    new-instance v3, Ljava/io/FileReader;

    invoke-direct {v3, v0}, Ljava/io/FileReader;-><init>(Ljava/lang/String;)V

    invoke-direct {v2, v3}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    move-object v1, v2

    .line 111
    :goto_1
    invoke-virtual {v1}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v2

    move-object v3, v2

    .local v3, "str":Ljava/lang/String;
    if-eqz v2, :cond_0

    .line 112
    sget-object v2, Lgosec/mylog/Writer;->bufferedWriter:Ljava/io/BufferedWriter;

    invoke-virtual {v2, v3}, Ljava/io/BufferedWriter;->write(Ljava/lang/String;)V

    .line 113
    sget-object v2, Lgosec/mylog/Writer;->bufferedWriter:Ljava/io/BufferedWriter;

    const-string v4, "\n"

    invoke-virtual {v2, v4}, Ljava/io/BufferedWriter;->write(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_1

    .line 121
    .end local v3    # "str":Ljava/lang/String;
    :cond_0
    :try_start_1
    sget-object v2, Lgosec/mylog/Writer;->bufferedWriter:Ljava/io/BufferedWriter;

    invoke-virtual {v2}, Ljava/io/BufferedWriter;->flush()V

    .line 122
    invoke-virtual {v1}, Ljava/io/BufferedReader;->close()V

    .line 123
    invoke-static {v0}, Lgosec/mylog/Writer;->deleteFileByFilePath(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_2

    goto :goto_2

    .line 120
    :catchall_0
    move-exception v2

    goto :goto_4

    .line 117
    :catch_0
    move-exception v2

    .line 118
    .local v2, "e":Ljava/lang/InterruptedException;
    :try_start_2
    invoke-virtual {v2}, Ljava/lang/InterruptedException;->printStackTrace()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 121
    .end local v2    # "e":Ljava/lang/InterruptedException;
    :try_start_3
    sget-object v2, Lgosec/mylog/Writer;->bufferedWriter:Ljava/io/BufferedWriter;

    invoke-virtual {v2}, Ljava/io/BufferedWriter;->flush()V

    .line 122
    invoke-virtual {v1}, Ljava/io/BufferedReader;->close()V

    .line 123
    invoke-static {v0}, Lgosec/mylog/Writer;->deleteFileByFilePath(Ljava/lang/String;)V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_2

    goto :goto_2

    .line 115
    :catch_1
    move-exception v2

    .line 116
    .local v2, "e":Ljava/io/IOException;
    :try_start_4
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    .line 121
    .end local v2    # "e":Ljava/io/IOException;
    :try_start_5
    sget-object v2, Lgosec/mylog/Writer;->bufferedWriter:Ljava/io/BufferedWriter;

    invoke-virtual {v2}, Ljava/io/BufferedWriter;->flush()V

    .line 122
    invoke-virtual {v1}, Ljava/io/BufferedReader;->close()V

    .line 123
    invoke-static {v0}, Lgosec/mylog/Writer;->deleteFileByFilePath(Ljava/lang/String;)V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_2

    .line 126
    :goto_2
    goto :goto_3

    .line 124
    :catch_2
    move-exception v2

    .line 125
    .restart local v2    # "e":Ljava/io/IOException;
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    .line 127
    .end local v2    # "e":Ljava/io/IOException;
    nop

    .line 128
    .end local v0    # "tmpLogFile":Ljava/lang/String;
    .end local v1    # "in":Ljava/io/BufferedReader;
    :goto_3
    goto :goto_0

    .line 121
    .restart local v0    # "tmpLogFile":Ljava/lang/String;
    .restart local v1    # "in":Ljava/io/BufferedReader;
    :goto_4
    :try_start_6
    sget-object v3, Lgosec/mylog/Writer;->bufferedWriter:Ljava/io/BufferedWriter;

    invoke-virtual {v3}, Ljava/io/BufferedWriter;->flush()V

    .line 122
    invoke-virtual {v1}, Ljava/io/BufferedReader;->close()V

    .line 123
    invoke-static {v0}, Lgosec/mylog/Writer;->deleteFileByFilePath(Ljava/lang/String;)V
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_3

    .line 126
    goto :goto_5

    .line 124
    :catch_3
    move-exception v3

    .line 125
    .local v3, "e":Ljava/io/IOException;
    invoke-virtual {v3}, Ljava/io/IOException;->printStackTrace()V

    .line 127
    .end local v3    # "e":Ljava/io/IOException;
    :goto_5
    throw v2
.end method

.method public static write(Ljava/lang/String;Ljava/lang/String;Z)V
    .locals 6
    .param p0, "hash"    # Ljava/lang/String;
    .param p1, "content"    # Ljava/lang/String;
    .param p2, "over"    # Z

    .line 135
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

    .line 136
    .local v0, "fileName":Ljava/lang/String;
    sget-object v1, Lgosec/mylog/Writer;->bufWriMap:Ljava/util/concurrent/ConcurrentHashMap;

    invoke-virtual {v1, v0}, Ljava/util/concurrent/ConcurrentHashMap;->containsKey(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    .line 137
    sget-object v1, Lgosec/mylog/Writer;->bufWriMap:Ljava/util/concurrent/ConcurrentHashMap;

    new-instance v2, Ljava/io/BufferedWriter;

    new-instance v3, Ljava/io/OutputStreamWriter;

    new-instance v4, Ljava/io/FileOutputStream;

    const/4 v5, 0x1

    invoke-direct {v4, v0, v5}, Ljava/io/FileOutputStream;-><init>(Ljava/lang/String;Z)V

    invoke-direct {v3, v4}, Ljava/io/OutputStreamWriter;-><init>(Ljava/io/OutputStream;)V

    const/16 v4, 0x400

    invoke-direct {v2, v3, v4}, Ljava/io/BufferedWriter;-><init>(Ljava/io/Writer;I)V

    invoke-virtual {v1, v0, v2}, Ljava/util/concurrent/ConcurrentHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 139
    :cond_0
    sget-object v1, Lgosec/mylog/Writer;->procedureLBQList:Ljava/util/List;

    invoke-static {p0}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v2

    const-wide/16 v4, 0xa

    rem-long/2addr v2, v4

    long-to-int v2, v2

    invoke-interface {v1, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/concurrent/LinkedBlockingQueue;

    new-instance v2, Lgosec/mylog/ProcedureItem;

    invoke-direct {v2, v0, p1, p2}, Lgosec/mylog/ProcedureItem;-><init>(Ljava/lang/String;Ljava/lang/String;Z)V

    invoke-virtual {v1, v2}, Ljava/util/concurrent/LinkedBlockingQueue;->put(Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 142
    .end local v0    # "fileName":Ljava/lang/String;
    goto :goto_1

    .line 140
    :catch_0
    move-exception v0

    goto :goto_0

    :catch_1
    move-exception v0

    .line 141
    .local v0, "e":Ljava/lang/Exception;
    :goto_0
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 143
    .end local v0    # "e":Ljava/lang/Exception;
    :goto_1
    return-void
.end method
