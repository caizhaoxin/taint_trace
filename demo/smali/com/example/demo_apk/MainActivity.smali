.class public Lcom/example/demo_apk/MainActivity;
.super Landroidx/appcompat/app/AppCompatActivity;
.source "MainActivity.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 9
    invoke-direct {p0}, Landroidx/appcompat/app/AppCompatActivity;-><init>()V

    return-void
.end method


# virtual methods
.method protected onCreate(Landroid/os/Bundle;)V
    .locals 1

    .line 13
    invoke-super {p0, p1}, Landroidx/appcompat/app/AppCompatActivity;->onCreate(Landroid/os/Bundle;)V

    const p1, 0x7f09001c

    .line 14
    invoke-virtual {p0, p1}, Lcom/example/demo_apk/MainActivity;->setContentView(I)V

    const p1, 0x7f070049

    .line 16
    invoke-virtual {p0, p1}, Lcom/example/demo_apk/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/Button;

    .line 17
    new-instance v0, Lcom/example/demo_apk/MainActivity$1;

    invoke-direct {v0, p0}, Lcom/example/demo_apk/MainActivity$1;-><init>(Lcom/example/demo_apk/MainActivity;)V

    invoke-virtual {p1, v0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    return-void
.end method
