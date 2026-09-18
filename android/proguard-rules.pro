# Consumer R8 / ProGuard rules for myfatoorah_flutter.
#
# These rules are merged into EVERY host app's release build, so they must only
# cover what this plugin and the MyFatoorah Android SDK actually need. Never add a
# blanket `-keep class * { *; }` (or androidx.** / android.** / com.google.** /
# io.flutter.**) here: it disables shrinking and obfuscation for the whole app and
# Google Play flags the build ("DEX code optimization is below our threshold").
# Gson, Retrofit, OkHttp, Flutter and AndroidX all ship their own consumer rules.

# MyFatoorah Android SDK (com.myfatoorah:myfatoorah) ships no rules of its own and
# (de)serializes its request/response models with Gson through Retrofit, so its
# API surface and models must keep their names and fields.
-keep class com.myfatoorah.** { *; }
-keep interface com.myfatoorah.** { *; }
-dontwarn com.myfatoorah.**

# Plugin bridge: Flutter method-channel arguments are mapped onto these models
# with Gson (MFExtentions.toModel / toJson, MFJsonAdapterHelper).
-keep class com.myfatoorahflutter.** { *; }
-dontwarn com.myfatoorahflutter.**

# Gson needs generic signatures and annotations on the kept models.
-keepattributes Signature,*Annotation*,InnerClasses,EnclosingMethod

# XmlPull is referenced by the SDK.
-keep class org.xmlpull.** { *; }
-keepclassmembers class org.xmlpull.** { *; }
-dontwarn org.xmlpull.**

# Warnings only: references to JDK / desktop / platform-provided classes.
-dontwarn org.slf4j.impl.**
-dontwarn java.lang.invoke.StringConcatFactory
-dontwarn com.google.android.play.core.**
-dontwarn android.content.res.**
-dontwarn org.apache.http.**
