.class public Lgosec/mylog/Demo;
.super Ljava/lang/Object;
.source "Demo.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 4
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static main([Ljava/lang/String;)V
    .locals 6
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 10
    new-instance p0, Ljava/lang/Double;

    const-wide v0, 0x405ecccccccccccdL    # 123.2

    invoke-direct {p0, v0, v1}, Ljava/lang/Double;-><init>(D)V

    const/4 p0, 0x5

    new-array p0, p0, [I

    .line 11
    fill-array-data p0, :array_0

    const-string v0, "asdasdsa"

    .line 12
    invoke-virtual {v0}, Ljava/lang/String;->getBytes()[B

    move-result-object v0

    const/4 v1, 0x2

    new-array v1, v1, [Lgosec/mylog/Info;

    .line 14
    new-instance v2, Lgosec/mylog/Info;

    const-string v3, "123"

    invoke-direct {v2, v3}, Lgosec/mylog/Info;-><init>(Ljava/lang/String;)V

    const/4 v3, 0x0

    aput-object v2, v1, v3

    new-instance v2, Lgosec/mylog/Info;

    const-string v3, "5555"

    invoke-direct {v2, v3}, Lgosec/mylog/Info;-><init>(Ljava/lang/String;)V

    const/4 v3, 0x1

    aput-object v2, v1, v3

    .line 19
    invoke-static {}, Lgosec/mylog/Log;->logInvokeStack()V

    const/16 v2, 0x7b

    .line 21
    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-static {v2}, Lgosec/mylog/Log;->add(Ljava/lang/Object;)V

    .line 22
    invoke-static {}, Lgosec/mylog/Log;->stopAdding()V

    invoke-static {}, Lgosec/mylog/Log;->logParameters()V

    const/16 v3, 0x61

    .line 24
    invoke-static {v3}, Ljava/lang/Character;->valueOf(C)Ljava/lang/Character;

    move-result-object v3

    invoke-static {v3}, Lgosec/mylog/Log;->add(Ljava/lang/Object;)V

    .line 25
    invoke-static {}, Lgosec/mylog/Log;->stopAdding()V

    invoke-static {}, Lgosec/mylog/Log;->logVariables()V

    const-wide v4, 0x406d49999999999aL    # 234.3

    .line 27
    invoke-static {v4, v5}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v4

    invoke-static {v4}, Lgosec/mylog/Log;->add(Ljava/lang/Object;)V

    .line 28
    invoke-static {}, Lgosec/mylog/Log;->stopAdding()V

    invoke-static {}, Lgosec/mylog/Log;->logReturnVal()V

    .line 30
    invoke-static {v4}, Lgosec/mylog/Log;->add(Ljava/lang/Object;)V

    invoke-static {v3}, Lgosec/mylog/Log;->add(Ljava/lang/Object;)V

    .line 31
    invoke-static {}, Lgosec/mylog/Log;->stopAdding()V

    invoke-static {}, Lgosec/mylog/Log;->logStaticVoid()V

    .line 33
    invoke-static {v4}, Lgosec/mylog/Log;->add(Ljava/lang/Object;)V

    invoke-static {v3}, Lgosec/mylog/Log;->add(Ljava/lang/Object;)V

    .line 34
    invoke-static {}, Lgosec/mylog/Log;->stopAdding()V

    invoke-static {}, Lgosec/mylog/Log;->logNonStaticVoid()V

    .line 36
    invoke-static {v2}, Lgosec/mylog/Log;->add(Ljava/lang/Object;)V

    invoke-static {p0}, Lgosec/mylog/Log;->add(Ljava/lang/Object;)V

    .line 37
    invoke-static {}, Lgosec/mylog/Log;->stopAdding()V

    invoke-static {v1}, Lgosec/mylog/Log;->logStaticNonVoid(Ljava/lang/Object;)V

    .line 39
    invoke-static {v2}, Lgosec/mylog/Log;->add(Ljava/lang/Object;)V

    invoke-static {v0}, Lgosec/mylog/Log;->add(Ljava/lang/Object;)V

    .line 40
    invoke-static {}, Lgosec/mylog/Log;->stopAdding()V

    invoke-static {v1}, Lgosec/mylog/Log;->logNonStaticNonVoid(Ljava/lang/Object;)V

    return-void

    nop

    :array_0
    .array-data 4
        0x7b
        0xc
        0x138
        0x138
        0x3
    .end array-data
.end method
