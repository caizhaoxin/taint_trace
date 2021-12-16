.class public Lgosec/mylog/DataStack;
.super Ljava/lang/Object;
.source "DataStack.java"


# instance fields
.field dataLenStack:Ljava/util/Stack;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Stack<",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field dataStack:Ljava/util/Stack;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Stack<",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation
.end field

.field len:I


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 5
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 6
    new-instance v0, Ljava/util/Stack;

    invoke-direct {v0}, Ljava/util/Stack;-><init>()V

    iput-object v0, p0, Lgosec/mylog/DataStack;->dataLenStack:Ljava/util/Stack;

    .line 7
    new-instance v0, Ljava/util/Stack;

    invoke-direct {v0}, Ljava/util/Stack;-><init>()V

    iput-object v0, p0, Lgosec/mylog/DataStack;->dataStack:Ljava/util/Stack;

    .line 8
    const/4 v0, 0x0

    iput v0, p0, Lgosec/mylog/DataStack;->len:I

    return-void
.end method

.method public static main([Ljava/lang/String;)V
    .locals 8
    .param p0, "args"    # [Ljava/lang/String;

    .line 25
    const/4 v0, 0x1

    .line 26
    .local v0, "a":I
    const-wide/high16 v1, 0x4000000000000000L    # 2.0

    .line 27
    .local v1, "b":D
    const-string v3, "123"

    .line 28
    .local v3, "str":Ljava/lang/String;
    new-instance v4, Lgosec/mylog/DataStack;

    invoke-direct {v4}, Lgosec/mylog/DataStack;-><init>()V

    .line 29
    .local v4, "dataSta":Lgosec/mylog/DataStack;
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-virtual {v4, v5}, Lgosec/mylog/DataStack;->addData(Ljava/lang/Object;)V

    invoke-static {v1, v2}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v5

    invoke-virtual {v4, v5}, Lgosec/mylog/DataStack;->addData(Ljava/lang/Object;)V

    invoke-virtual {v4, v3}, Lgosec/mylog/DataStack;->addData(Ljava/lang/Object;)V

    .line 30
    invoke-virtual {v4}, Lgosec/mylog/DataStack;->stopAdding()V

    .line 31
    invoke-virtual {v4}, Lgosec/mylog/DataStack;->getData()Ljava/util/Stack;

    move-result-object v5

    .line 32
    .local v5, "stack":Ljava/util/Stack;, "Ljava/util/Stack<Ljava/lang/Object;>;"
    :goto_0
    invoke-virtual {v5}, Ljava/util/Stack;->isEmpty()Z

    move-result v6

    if-nez v6, :cond_0

    sget-object v6, Ljava/lang/System;->out:Ljava/io/PrintStream;

    invoke-virtual {v5}, Ljava/util/Stack;->pop()Ljava/lang/Object;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    goto :goto_0

    .line 33
    :cond_0
    return-void
.end method


# virtual methods
.method public addData(Ljava/lang/Object;)V
    .locals 1
    .param p1, "obj"    # Ljava/lang/Object;

    .line 10
    iget v0, p0, Lgosec/mylog/DataStack;->len:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lgosec/mylog/DataStack;->len:I

    .line 11
    iget-object v0, p0, Lgosec/mylog/DataStack;->dataStack:Ljava/util/Stack;

    invoke-virtual {v0, p1}, Ljava/util/Stack;->add(Ljava/lang/Object;)Z

    .line 12
    return-void
.end method

.method public getData()Ljava/util/Stack;
    .locals 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Stack<",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation

    .line 18
    new-instance v0, Ljava/util/Stack;

    invoke-direct {v0}, Ljava/util/Stack;-><init>()V

    .line 19
    .local v0, "resStack":Ljava/util/Stack;, "Ljava/util/Stack<Ljava/lang/Object;>;"
    iget-object v1, p0, Lgosec/mylog/DataStack;->dataLenStack:Ljava/util/Stack;

    invoke-virtual {v1}, Ljava/util/Stack;->size()I

    move-result v1

    if-eqz v1, :cond_2

    iget-object v1, p0, Lgosec/mylog/DataStack;->dataStack:Ljava/util/Stack;

    invoke-virtual {v1}, Ljava/util/Stack;->size()I

    move-result v1

    if-eqz v1, :cond_2

    iget-object v1, p0, Lgosec/mylog/DataStack;->dataStack:Ljava/util/Stack;

    invoke-virtual {v1}, Ljava/util/Stack;->size()I

    move-result v1

    iget-object v2, p0, Lgosec/mylog/DataStack;->dataLenStack:Ljava/util/Stack;

    invoke-virtual {v2}, Ljava/util/Stack;->firstElement()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Integer;

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    if-ge v1, v2, :cond_0

    goto :goto_1

    .line 20
    :cond_0
    iget-object v1, p0, Lgosec/mylog/DataStack;->dataLenStack:Ljava/util/Stack;

    invoke-virtual {v1}, Ljava/util/Stack;->pop()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    .line 21
    .local v1, "curLen":I
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    if-ge v2, v1, :cond_1

    iget-object v3, p0, Lgosec/mylog/DataStack;->dataStack:Ljava/util/Stack;

    invoke-virtual {v3}, Ljava/util/Stack;->pop()Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/util/Stack;->add(Ljava/lang/Object;)Z

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 22
    .end local v2    # "i":I
    :cond_1
    return-object v0

    .line 19
    .end local v1    # "curLen":I
    :cond_2
    :goto_1
    return-object v0
.end method

.method public stopAdding()V
    .locals 2

    .line 14
    iget-object v0, p0, Lgosec/mylog/DataStack;->dataLenStack:Ljava/util/Stack;

    iget v1, p0, Lgosec/mylog/DataStack;->len:I

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/Stack;->add(Ljava/lang/Object;)Z

    .line 15
    const/4 v0, 0x0

    iput v0, p0, Lgosec/mylog/DataStack;->len:I

    .line 16
    return-void
.end method
