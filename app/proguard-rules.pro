# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile




# 代码混淆压缩比，在0~7之间，默认为5，一般不做修改
-optimizationpasses 5

# 混合时不使用大小写混合，混合后的类名为小写
-dontusemixedcaseclassnames

# 指定不去忽略非公共库的类
-dontskipnonpubliclibraryclasses

# 这句话能够使我们的项目混淆后产生映射文件
# 包含有类名->混淆后类名的映射关系
-verbose

# 指定不去忽略非公共库的类成员
-dontskipnonpubliclibraryclassmembers

# 不做预校验，preverify是proguard的四个步骤之一，Android不需要preverify，去掉这一步能够加快混淆速度。
-dontpreverify

# 保留Annotation不混淆
-keepattributes *Annotation*,InnerClasses

# 避免混淆泛型
-keepattributes Signature

# 抛出异常时保留代码行号
-keepattributes SourceFile,LineNumberTable

# 指定混淆是采用的算法，后面的参数是一个过滤器
# 这个过滤器是谷歌推荐的算法，一般不做更改
-optimizations !code/simplification/cast,!field/*,!class/merging/*


#############################################
#
# Android开发中一些需要保留的公共部分
#
#############################################

-keep public class * extends android.app.Fragment
-keep public class * extends android.app.Activity
-keep public class * extends android.app.Application
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.preference.Preference
-keep public class * extends android.content.ContentProvider
-keep public class * extends android.support.v4.**
-keep public class * extends android.support.annotation.**
-keep public class * extends android.support.v7.**
-keep public class * extends android.view.View
-keep public class com.android.vending.licensing.ILicensingService

#=============================实体类=============================

-keep @com.module.weight.NotProguard class * {*;}
-keep class * {
    @com.module.weight.NotProguard <fields>;
}
-keepclassmembers class * {
    @com.module.weight.NotProguard <methods>;
}
-keep class com.yunqin.bearmall.bean.** { *; }
-keep class com.bbcoupon.ui.bean.**{ *; }
-keep class com.newreward.bean.**{ *; }
-keep class com.yunqin.bearmall.api.** { *; }
-keep class com.bytedance.sdk.openadsdk.** { *; }
-keep class com.bbcoupon.ui.contract.**{ *; }
-keep class com.bbcoupon.util.**{ *; }
-keep class com.newversions.tbk.entity.**{ *; }
-keep class com.yunqin.bearmall.util.**{ *; }
-keep class com.bumptech.glide.**{ *; }
-keep class com.newversions.util.**{ *; }
#-keep class com.module.user.model.**{ *; }

#=============================End================================
# 保留Parcelable序列化类不被混淆
-keep class * implements android.os.Parcelable {
    public static final android.os.Parcelable$Creator *;
}
#=============================自定义View=========================
-keep class com.yunqin.bearmall.widget.** { *; }
#=============================End==============================
#表示不混淆任何一个View中的setXxx()和getXxx()方法，
#因为属性动画需要有相应的setter和getter的方法实现，混淆了就无法工作了。
-keep public class * extends android.view.View{
    *** get*();
    void set*(***);
    public <init>(android.content.Context);
    public <init>(android.content.Context, android.util.AttributeSet);
    public <init>(android.content.Context, android.util.AttributeSet, int);
}

#=============================EventBus=============================
-keepattributes *Annotation*
-keepclassmembers class ** {
    @org.greenrobot.eventbus.Subscribe <methods>;
}
-keep enum org.greenrobot.eventbus.ThreadMode { *; }

# Only required if you use AsyncExecutor
-keepclassmembers class * extends org.greenrobot.eventbus.util.ThrowableFailureEvent {
    <init>(java.lang.Throwable);
}
#=============================End=============================


#=============================GSON=============================
#-keepattributes Signature-keepattributes *Annotation*
-keep class sun.misc.Unsafe { *; }
-keep class com.google.gson.** { *; }
#=============================End=============================

#=======================开屏广告加载==================
-keep  class permison.** { *; }
-keep  class com.bbcoupon.ui.contract.** { *; }
#=============================A库=============================
-keep public class com.example.lamor.**
#=============================End=============================

#=============================Butter Knife====================
-keep class butterknife.** { *; }
-dontwarn butterknife.internal.**
-keep class **$$ViewBinder { *; }
-keepclasseswithmembernames class * {
   @butterknife.* <fields>;
}
-keepclasseswithmembernames class * {
   @butterknife.* <methods>;
}
#=============================End=============================

#=============================Retrofit========================
-dontwarn retrofit2.**
-keep class retrofit2.** { *; }
-keepattributes Signature
-keepattributes Exceptions
#=============================End=============================

#========================RxJava RxAndroid=====================
-dontwarn sun.misc.**
-keepclassmembers class rx.internal.util.unsafe.*ArrayQueue*Field* {
    long producerIndex; long consumerIndex;
}
-keepclassmembers class rx.internal.util.unsafe.BaseLinkedQueueProducerNodeRef {
    rx.internal.util.atomic.LinkedQueueNode producerNode;
}
-keepclassmembers class rx.internal.util.unsafe.BaseLinkedQueueConsumerNodeRef {
    rx.internal.util.atomic.LinkedQueueNode consumerNode;
}
#=============================End=============================

#===========================OK HTTP===========================
-dontwarn com.squareup.okhttp3.**
-keep class com.squareup.okhttp3.** { *;}
-dontwarn okio.**
#=============================End=============================

#=============================Glide===========================
-keep public class * implements com.bumptech.glide.module.GlideModule
-keep public enum com.bumptech.glide.load.resource.bitmap.ImageHeaderParser$** {
    **[] $VALUES;
    public *;
}
#=============================End=============================

#===========================ShareSDK==========================
-keep class cn.sharesdk.**{*;}
-keep class com.sina.**{*;}
-keep class **.R$* {*;}
-keep class **.R{*;}
-keep class com.mob.**{*;}
-keep class m.framework.**{*;}

-dontwarn cn.sharesdk.**
-dontwarn com.sina.**
-dontwarn com.mob.**
-dontwarn **.R$*
#=============================End=============================

#===========================GitHub============================
-keep class com.donkingliang.**{*;}
-keep class chihane.jdaddressselector.**{*;}
-keep class com.raizlabs.**{*;}
-keep class com.androidkun.**{*;}



#=============================End=============================

#=============================微信=============================
-keep class com.tencent.** { *;}
#=============================End=============================

#=============================支付宝==========================
-keep class com.alipay.**{*;}
-keep class com.ta.utdid2.**{*;}
-keep class com.ut.**{*;}
-keep class org.json.alipay.**{*;}
-dontwarn android.net.**
-keep class android.net.SSLCertificateSocketFactory{*;}
-dontwarn com.alipay.android.app.**
#=============================End=============================

#=============================个推============================
-dontwarn com.igexin.**
-keep class com.igexin.** { *; }
-keep class org.json.** { *; }
#=============================End=============================

#============================未知库===========================
-keep class org.json.simple.** { *; }
#=============================End=============================

#=============================刷新库==========================
-keep class com.lcodecore.tkrefreshlayout.** { *; }
#===========================友盟统计=============================
-keep class com.umeng.** {*;}

-keepclassmembers class * {
   public <init> (org.json.JSONObject);
}

-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}
#=============================End=============================

#===========================阿里百川=============================
-keepattributes Signature
-ignorewarnings
-keep class javax.ws.rs.** { *; }
-keep class com.alibaba.fastjson.** { *; }
-dontwarn com.alibaba.fastjson.**
-keep class sun.misc.Unsafe { *; }
-dontwarn sun.misc.**
-keep class com.taobao.** {*;}
-keep class com.alibaba.** {*;}
-keep class com.alipay.** {*;}
-dontwarn com.taobao.**
-dontwarn com.alibaba.**
-dontwarn com.alipay.**
-keep class com.ut.** {*;}
-dontwarn com.ut.**
-keep class com.ta.** {*;}
-dontwarn com.ta.**
-keep class org.json.** {*;}
-keep class com.ali.auth.**  {*;}
-dontwarn com.ali.auth.**
-keep class com.taobao.securityjni.** {*;}
-keep class com.taobao.wireless.security.** {*;}
-keep class com.taobao.dp.**{*;}
-keep class com.alibaba.wireless.security.**{*;}
-keep interface mtopsdk.mtop.global.init.IMtopInitTask {*;}
-keep class * implements mtopsdk.mtop.global.init.IMtopInitTask {*;}
#=============================End=============================

#===========================移动安全联盟=============================
-keep class com.bun.miitmdid.core.** {*;}
#=============================End=============================

#===========================京东联盟=============================
-keep class com.kepler.jd.**{ public <fields>; public <methods>; public *; }
#=============================End=============================

-keep public class cn.jzvd.JZMediaSystem {*; }
#-keep public class cn.jzvd.demo.CustomMedia.CustomMedia {*; }
#-keep public class cn.jzvd.demo.CustomMedia.JZMediaIjk {*; }
#-keep public class cn.jzvd.demo.CustomMedia.JZMediaSystemAssertFolder {*; }
#
#-keep class tv.danmaku.ijk.media.player.** {*; }
#-dontwarn tv.danmaku.ijk.media.player.*
#-keep interface tv.danmaku.ijk.media.player.** { *; }






