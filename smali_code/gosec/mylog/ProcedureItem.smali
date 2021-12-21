.class Lgosec/mylog/ProcedureItem;
.super Ljava/lang/Object;
.source "Writer.java"


# instance fields
.field public content:Ljava/lang/String;

.field public fileName:Ljava/lang/String;

.field public over:Z


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Z)V
    .locals 0
    .param p1, "fileName"    # Ljava/lang/String;
    .param p2, "content"    # Ljava/lang/String;
    .param p3, "over"    # Z

    .line 21
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 22
    iput-object p1, p0, Lgosec/mylog/ProcedureItem;->fileName:Ljava/lang/String;

    .line 23
    iput-object p2, p0, Lgosec/mylog/ProcedureItem;->content:Ljava/lang/String;

    .line 24
    iput-boolean p3, p0, Lgosec/mylog/ProcedureItem;->over:Z

    .line 25
    return-void
.end method
