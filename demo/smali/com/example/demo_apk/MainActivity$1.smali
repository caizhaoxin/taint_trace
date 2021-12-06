.class Lcom/example/demo_apk/MainActivity$1;
.super Ljava/lang/Object;
.source "MainActivity.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/example/demo_apk/MainActivity;->onCreate(Landroid/os/Bundle;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/example/demo_apk/MainActivity;


# direct methods
.method constructor <init>(Lcom/example/demo_apk/MainActivity;)V
    .locals 0

    .line 17
    iput-object p1, p0, Lcom/example/demo_apk/MainActivity$1;->this$0:Lcom/example/demo_apk/MainActivity;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1

    .line 20
    new-instance p1, Lcom/example/demo_apk/Util;

    invoke-direct {p1}, Lcom/example/demo_apk/Util;-><init>()V

    const-string v0, "\u6cc4\u6f0f\u4e86"

    .line 21
    invoke-virtual {p1, v0}, Lcom/example/demo_apk/Util;->send(Ljava/lang/String;)Z

    .line 22
    invoke-virtual {p1, v0}, Lcom/example/demo_apk/Util;->myEncry(Ljava/lang/String;)[B

    return-void
.end method
