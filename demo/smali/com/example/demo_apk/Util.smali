.class public Lcom/example/demo_apk/Util;
.super Ljava/lang/Object;
.source "Util.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 50
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public handleContent(Lcom/example/demo_apk/Info;)Z
    .locals 2

    .line 63
    new-instance v0, Lcom/example/demo_apk/Info;

    new-instance v1, Ljava/lang/String;

    iget-object p1, p1, Lcom/example/demo_apk/Info;->arr:[B

    invoke-direct {v1, p1}, Ljava/lang/String;-><init>([B)V

    invoke-virtual {p0, v1}, Lcom/example/demo_apk/Util;->myEncry(Ljava/lang/String;)[B

    move-result-object p1

    invoke-direct {v0, p1}, Lcom/example/demo_apk/Info;-><init>([B)V

    .line 64
    invoke-virtual {p0, v0}, Lcom/example/demo_apk/Util;->post(Lcom/example/demo_apk/Info;)Z

    move-result p1

    return p1
.end method

.method public myEncry(Ljava/lang/String;)[B
    .locals 4

    .line 56
    invoke-virtual {p1}, Ljava/lang/String;->toCharArray()[C

    move-result-object p1

    const/4 v0, 0x0

    .line 57
    :goto_0
    array-length v1, p1

    if-ge v0, v1, :cond_0

    .line 58
    aget-char v1, p1, v0

    new-instance v2, Ljava/util/Random;

    invoke-direct {v2}, Ljava/util/Random;-><init>()V

    const/16 v3, 0xff

    invoke-virtual {v2, v3}, Ljava/util/Random;->nextInt(I)I

    move-result v2

    xor-int/2addr v1, v2

    int-to-char v1, v1

    aput-char v1, p1, v0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 60
    :cond_0
    new-instance v0, Ljava/lang/String;

    invoke-direct {v0, p1}, Ljava/lang/String;-><init>([C)V

    invoke-virtual {v0}, Ljava/lang/String;->getBytes()[B

    move-result-object p1

    return-object p1
.end method

.method public post(Lcom/example/demo_apk/Info;)Z
    .locals 0

    const/4 p1, 0x1

    return p1
.end method

.method public send(Ljava/lang/String;)Z
    .locals 1

    .line 52
    new-instance v0, Lcom/example/demo_apk/Info;

    invoke-virtual {p0, p1}, Lcom/example/demo_apk/Util;->myEncry(Ljava/lang/String;)[B

    move-result-object p1

    invoke-direct {v0, p1}, Lcom/example/demo_apk/Info;-><init>([B)V

    .line 53
    invoke-virtual {p0, v0}, Lcom/example/demo_apk/Util;->handleContent(Lcom/example/demo_apk/Info;)Z

    move-result p1

    return p1
.end method
