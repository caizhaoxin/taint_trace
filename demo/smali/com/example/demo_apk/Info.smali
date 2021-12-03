.class Lcom/example/demo_apk/Info;
.super Ljava/lang/Object;
.source "Util.java"


# instance fields
.field public arr:[B

.field public code:I


# direct methods
.method constructor <init>([B)V
    .locals 1

    .line 8
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 9
    iput-object p1, p0, Lcom/example/demo_apk/Info;->arr:[B

    .line 10
    new-instance p1, Ljava/util/Random;

    invoke-direct {p1}, Ljava/util/Random;-><init>()V

    const v0, 0x186a0

    invoke-virtual {p1, v0}, Ljava/util/Random;->nextInt(I)I

    move-result p1

    iput p1, p0, Lcom/example/demo_apk/Info;->code:I

    return-void
.end method
