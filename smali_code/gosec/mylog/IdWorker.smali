.class public Lgosec/mylog/IdWorker;
.super Ljava/lang/Object;
.source "IdWorker.java"


# static fields
.field public static worker:Lgosec/mylog/IdWorker;


# instance fields
.field private datacenterId:J

.field private datacenterIdBits:J

.field private datacenterIdShift:J

.field private lastTimestamp:J

.field private maxDatacenterId:J

.field private maxWorkerId:J

.field private sequence:J

.field private sequenceBits:J

.field private sequenceMask:J

.field private timestampLeftShift:J

.field private twepoch:J

.field private workerId:J

.field private workerIdBits:J

.field private workerIdShift:J


# direct methods
.method static constructor <clinit>()V
    .locals 8

    .line 115
    new-instance v7, Lgosec/mylog/IdWorker;

    const-wide/16 v1, 0x1

    const-wide/16 v3, 0x1

    const-wide/16 v5, 0x1

    move-object v0, v7

    invoke-direct/range {v0 .. v6}, Lgosec/mylog/IdWorker;-><init>(JJJ)V

    sput-object v7, Lgosec/mylog/IdWorker;->worker:Lgosec/mylog/IdWorker;

    return-void
.end method

.method public constructor <init>(JJJ)V
    .locals 18
    .param p1, "workerId"    # J
    .param p3, "datacenterId"    # J
    .param p5, "sequence"    # J

    .line 11
    move-object/from16 v0, p0

    move-wide/from16 v1, p1

    move-wide/from16 v3, p3

    invoke-direct/range {p0 .. p0}, Ljava/lang/Object;-><init>()V

    .line 28
    const-wide v5, 0x12c148d03c1L

    iput-wide v5, v0, Lgosec/mylog/IdWorker;->twepoch:J

    .line 31
    const-wide/16 v5, 0x5

    iput-wide v5, v0, Lgosec/mylog/IdWorker;->workerIdBits:J

    .line 32
    iput-wide v5, v0, Lgosec/mylog/IdWorker;->datacenterIdBits:J

    .line 34
    long-to-int v7, v5

    const-wide/16 v8, -0x1

    shl-long v10, v8, v7

    xor-long/2addr v10, v8

    iput-wide v10, v0, Lgosec/mylog/IdWorker;->maxWorkerId:J

    .line 35
    long-to-int v7, v5

    shl-long v12, v8, v7

    xor-long/2addr v12, v8

    iput-wide v12, v0, Lgosec/mylog/IdWorker;->maxDatacenterId:J

    .line 37
    const-wide/16 v14, 0xc

    iput-wide v14, v0, Lgosec/mylog/IdWorker;->sequenceBits:J

    .line 39
    long-to-int v7, v14

    shl-long v16, v8, v7

    xor-long v5, v16, v8

    iput-wide v5, v0, Lgosec/mylog/IdWorker;->sequenceMask:J

    .line 42
    iput-wide v14, v0, Lgosec/mylog/IdWorker;->workerIdShift:J

    .line 44
    const-wide/16 v5, 0x5

    add-long v8, v14, v5

    iput-wide v8, v0, Lgosec/mylog/IdWorker;->datacenterIdShift:J

    .line 46
    add-long/2addr v14, v5

    add-long/2addr v14, v5

    iput-wide v14, v0, Lgosec/mylog/IdWorker;->timestampLeftShift:J

    .line 49
    const-wide/16 v5, -0x1

    iput-wide v5, v0, Lgosec/mylog/IdWorker;->lastTimestamp:J

    .line 13
    cmp-long v5, v1, v10

    const/4 v6, 0x0

    const/4 v7, 0x1

    if-gtz v5, :cond_1

    const-wide/16 v8, 0x0

    cmp-long v5, v1, v8

    if-ltz v5, :cond_1

    .line 16
    cmp-long v5, v3, v12

    if-gtz v5, :cond_0

    cmp-long v5, v3, v8

    if-ltz v5, :cond_0

    .line 19
    sget-object v5, Ljava/lang/System;->out:Ljava/io/PrintStream;

    const/4 v8, 0x5

    new-array v8, v8, [Ljava/lang/Object;

    iget-wide v9, v0, Lgosec/mylog/IdWorker;->timestampLeftShift:J

    .line 20
    invoke-static {v9, v10}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v9

    aput-object v9, v8, v6

    iget-wide v9, v0, Lgosec/mylog/IdWorker;->datacenterIdBits:J

    invoke-static {v9, v10}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v6

    aput-object v6, v8, v7

    const/4 v6, 0x2

    iget-wide v9, v0, Lgosec/mylog/IdWorker;->workerIdBits:J

    invoke-static {v9, v10}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v7

    aput-object v7, v8, v6

    const/4 v6, 0x3

    iget-wide v9, v0, Lgosec/mylog/IdWorker;->sequenceBits:J

    invoke-static {v9, v10}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v7

    aput-object v7, v8, v6

    const/4 v6, 0x4

    invoke-static/range {p1 .. p2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v7

    aput-object v7, v8, v6

    .line 19
    const-string v6, "worker starting. timestamp left shift %d, datacenter id bits %d, worker id bits %d, sequence bits %d, workerid %d"

    invoke-virtual {v5, v6, v8}, Ljava/io/PrintStream;->printf(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/PrintStream;

    .line 22
    iput-wide v1, v0, Lgosec/mylog/IdWorker;->workerId:J

    .line 23
    iput-wide v3, v0, Lgosec/mylog/IdWorker;->datacenterId:J

    .line 24
    move-wide/from16 v8, p5

    iput-wide v8, v0, Lgosec/mylog/IdWorker;->sequence:J

    .line 25
    return-void

    .line 16
    :cond_0
    move-wide/from16 v8, p5

    .line 17
    new-instance v5, Ljava/lang/IllegalArgumentException;

    new-array v7, v7, [Ljava/lang/Object;

    iget-wide v10, v0, Lgosec/mylog/IdWorker;->maxDatacenterId:J

    invoke-static {v10, v11}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v10

    aput-object v10, v7, v6

    const-string v6, "datacenter Id can\'t be greater than %d or less than 0"

    invoke-static {v6, v7}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v5

    .line 13
    :cond_1
    move-wide/from16 v8, p5

    .line 14
    new-instance v5, Ljava/lang/IllegalArgumentException;

    new-array v7, v7, [Ljava/lang/Object;

    iget-wide v10, v0, Lgosec/mylog/IdWorker;->maxWorkerId:J

    invoke-static {v10, v11}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v10

    aput-object v10, v7, v6

    const-string v6, "worker Id can\'t be greater than %d or less than 0"

    invoke-static {v6, v7}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v5
.end method

.method public static getId()J
    .locals 2

    .line 117
    sget-object v0, Lgosec/mylog/IdWorker;->worker:Lgosec/mylog/IdWorker;

    invoke-virtual {v0}, Lgosec/mylog/IdWorker;->nextId()J

    move-result-wide v0

    return-wide v0
.end method

.method public static main([Ljava/lang/String;)V
    .locals 8
    .param p0, "args"    # [Ljava/lang/String;

    .line 122
    new-instance v7, Lgosec/mylog/IdWorker;

    const-wide/16 v1, 0x1

    const-wide/16 v3, 0x1

    const-wide/16 v5, 0x1

    move-object v0, v7

    invoke-direct/range {v0 .. v6}, Lgosec/mylog/IdWorker;-><init>(JJJ)V

    .line 124
    .local v0, "worker":Lgosec/mylog/IdWorker;
    :goto_0
    sget-object v1, Ljava/lang/System;->out:Ljava/io/PrintStream;

    invoke-virtual {v0}, Lgosec/mylog/IdWorker;->nextId()J

    move-result-wide v2

    invoke-virtual {v1, v2, v3}, Ljava/io/PrintStream;->println(J)V

    goto :goto_0
.end method

.method private tilNextMillis(J)J
    .locals 3
    .param p1, "lastTimestamp"    # J

    .line 103
    invoke-direct {p0}, Lgosec/mylog/IdWorker;->timeGen()J

    move-result-wide v0

    .line 104
    .local v0, "timestamp":J
    :goto_0
    cmp-long v2, v0, p1

    if-gtz v2, :cond_0

    .line 105
    invoke-direct {p0}, Lgosec/mylog/IdWorker;->timeGen()J

    move-result-wide v0

    goto :goto_0

    .line 107
    :cond_0
    return-wide v0
.end method

.method private timeGen()J
    .locals 2

    .line 112
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    return-wide v0
.end method


# virtual methods
.method public getDatacenterId()J
    .locals 2

    .line 56
    iget-wide v0, p0, Lgosec/mylog/IdWorker;->datacenterId:J

    return-wide v0
.end method

.method public getTimestamp()J
    .locals 2

    .line 60
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    return-wide v0
.end method

.method public getWorkerId()J
    .locals 2

    .line 52
    iget-wide v0, p0, Lgosec/mylog/IdWorker;->workerId:J

    return-wide v0
.end method

.method public declared-synchronized nextId()J
    .locals 11

    monitor-enter p0

    .line 65
    :try_start_0
    invoke-direct {p0}, Lgosec/mylog/IdWorker;->timeGen()J

    move-result-wide v0

    .line 68
    .local v0, "timestamp":J
    iget-wide v2, p0, Lgosec/mylog/IdWorker;->lastTimestamp:J

    cmp-long v4, v0, v2

    if-ltz v4, :cond_2

    .line 75
    cmp-long v4, v2, v0

    const-wide/16 v5, 0x0

    if-nez v4, :cond_0

    .line 76
    iget-wide v7, p0, Lgosec/mylog/IdWorker;->sequence:J

    const-wide/16 v9, 0x1

    add-long/2addr v7, v9

    iget-wide v9, p0, Lgosec/mylog/IdWorker;->sequenceMask:J

    and-long/2addr v7, v9

    iput-wide v7, p0, Lgosec/mylog/IdWorker;->sequence:J

    .line 77
    cmp-long v4, v7, v5

    if-nez v4, :cond_1

    .line 78
    invoke-direct {p0, v2, v3}, Lgosec/mylog/IdWorker;->tilNextMillis(J)J

    move-result-wide v2

    move-wide v0, v2

    goto :goto_0

    .line 81
    .end local p0    # "this":Lgosec/mylog/IdWorker;
    :cond_0
    iput-wide v5, p0, Lgosec/mylog/IdWorker;->sequence:J

    .line 85
    :cond_1
    :goto_0
    iput-wide v0, p0, Lgosec/mylog/IdWorker;->lastTimestamp:J

    .line 95
    iget-wide v2, p0, Lgosec/mylog/IdWorker;->twepoch:J

    sub-long v2, v0, v2

    iget-wide v4, p0, Lgosec/mylog/IdWorker;->timestampLeftShift:J

    long-to-int v4, v4

    shl-long/2addr v2, v4

    iget-wide v4, p0, Lgosec/mylog/IdWorker;->datacenterId:J

    iget-wide v6, p0, Lgosec/mylog/IdWorker;->datacenterIdShift:J

    long-to-int v6, v6

    shl-long/2addr v4, v6

    or-long/2addr v2, v4

    iget-wide v4, p0, Lgosec/mylog/IdWorker;->workerId:J

    iget-wide v6, p0, Lgosec/mylog/IdWorker;->workerIdShift:J

    long-to-int v6, v6

    shl-long/2addr v4, v6

    or-long/2addr v2, v4

    iget-wide v4, p0, Lgosec/mylog/IdWorker;->sequence:J
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    or-long/2addr v2, v4

    monitor-exit p0

    return-wide v2

    .line 69
    :cond_2
    :try_start_1
    sget-object v2, Ljava/lang/System;->err:Ljava/io/PrintStream;

    const-string v3, "clock is moving backwards.  Rejecting requests until %d."

    const/4 v4, 0x1

    new-array v5, v4, [Ljava/lang/Object;

    iget-wide v6, p0, Lgosec/mylog/IdWorker;->lastTimestamp:J

    invoke-static {v6, v7}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v6

    const/4 v7, 0x0

    aput-object v6, v5, v7

    invoke-virtual {v2, v3, v5}, Ljava/io/PrintStream;->printf(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/PrintStream;

    .line 70
    new-instance v2, Ljava/lang/RuntimeException;

    const-string v3, "Clock moved backwards.  Refusing to generate id for %d milliseconds"

    new-array v4, v4, [Ljava/lang/Object;

    iget-wide v5, p0, Lgosec/mylog/IdWorker;->lastTimestamp:J

    sub-long/2addr v5, v0

    .line 71
    invoke-static {v5, v6}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v5

    aput-object v5, v4, v7

    .line 70
    invoke-static {v3, v4}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v2
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 64
    .end local v0    # "timestamp":J
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method
