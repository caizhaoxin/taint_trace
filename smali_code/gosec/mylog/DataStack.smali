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

    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 8
    new-instance v0, Ljava/util/Stack;

    invoke-direct {v0}, Ljava/util/Stack;-><init>()V

    iput-object v0, p0, Lgosec/mylog/DataStack;->dataLenStack:Ljava/util/Stack;

    .line 9
    new-instance v0, Ljava/util/Stack;

    invoke-direct {v0}, Ljava/util/Stack;-><init>()V

    iput-object v0, p0, Lgosec/mylog/DataStack;->dataStack:Ljava/util/Stack;

    const/4 v0, 0x0

    .line 10
    iput v0, p0, Lgosec/mylog/DataStack;->len:I

    return-void
.end method

.method public static main([Ljava/lang/String;)V
    .locals 2

    .line 30
    new-instance p0, Lgosec/mylog/DataStack;

    invoke-direct {p0}, Lgosec/mylog/DataStack;-><init>()V

    const/4 v0, 0x1

    .line 31
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {p0, v0}, Lgosec/mylog/DataStack;->addData(Ljava/lang/Object;)V

    const-wide/high16 v0, 0x4000000000000000L    # 2.0

    invoke-static {v0, v1}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v0

    invoke-virtual {p0, v0}, Lgosec/mylog/DataStack;->addData(Ljava/lang/Object;)V

    const-string v0, "123"

    invoke-virtual {p0, v0}, Lgosec/mylog/DataStack;->addData(Ljava/lang/Object;)V

    .line 32
    invoke-virtual {p0}, Lgosec/mylog/DataStack;->stopAdding()V

    .line 33
    invoke-virtual {p0}, Lgosec/mylog/DataStack;->getData()Ljava/util/Stack;

    move-result-object p0

    .line 34
    :goto_0
    invoke-virtual {p0}, Ljava/util/Stack;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_0

    sget-object v0, Ljava/lang/System;->out:Ljava/io/PrintStream;

    invoke-virtual {p0}, Ljava/util/Stack;->pop()Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/io/PrintStream;->println(Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    return-void
.end method


# virtual methods
.method public addData(Ljava/lang/Object;)V
    .locals 1

    .line 12
    iget v0, p0, Lgosec/mylog/DataStack;->len:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lgosec/mylog/DataStack;->len:I

    .line 13
    iget-object v0, p0, Lgosec/mylog/DataStack;->dataStack:Ljava/util/Stack;

    invoke-virtual {v0, p1}, Ljava/util/Stack;->add(Ljava/lang/Object;)Z

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

    .line 20
    new-instance v0, Ljava/util/Stack;

    invoke-direct {v0}, Ljava/util/Stack;-><init>()V

    .line 21
    iget-object v1, p0, Lgosec/mylog/DataStack;->dataLenStack:Ljava/util/Stack;

    invoke-virtual {v1}, Ljava/util/Stack;->size()I

    move-result v1

    if-eqz v1, :cond_1

    iget-object v1, p0, Lgosec/mylog/DataStack;->dataStack:Ljava/util/Stack;

    invoke-virtual {v1}, Ljava/util/Stack;->size()I

    move-result v1

    if-eqz v1, :cond_1

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

    .line 22
    :cond_0
    iget-object v1, p0, Lgosec/mylog/DataStack;->dataLenStack:Ljava/util/Stack;

    invoke-virtual {v1}, Ljava/util/Stack;->pop()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_1

    .line 23
    iget-object v3, p0, Lgosec/mylog/DataStack;->dataStack:Ljava/util/Stack;

    invoke-virtual {v3}, Ljava/util/Stack;->pop()Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v0, v3}, Ljava/util/Stack;->add(Ljava/lang/Object;)Z

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_1
    :goto_1
    return-object v0
.end method

.method public stopAdding()V
    .locals 2

    .line 16
    iget-object v0, p0, Lgosec/mylog/DataStack;->dataLenStack:Ljava/util/Stack;

    iget v1, p0, Lgosec/mylog/DataStack;->len:I

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/Stack;->add(Ljava/lang/Object;)Z

    const/4 v0, 0x0

    .line 17
    iput v0, p0, Lgosec/mylog/DataStack;->len:I

    return-void
.end method
