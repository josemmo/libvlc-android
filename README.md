# libVLC for Android
[![Latest version](https://jitpack.io/v/josemmo/libvlc-android.svg)](https://jitpack.io/#josemmo/libvlc-android)
[![Travis](https://travis-ci.com/josemmo/libvlc-android.svg?branch=master)](https://travis-ci.com/josemmo/libvlc-android)
[![GitHub license](https://img.shields.io/github/license/josemmo/libvlc-android)](https://github.com/josemmo/libvlc-android/blob/master/COPYING)

Unofficial ready-to-use compiled version of libVLC for Android. Just add this library to your project dependencies.

## Usage
Add this in your root `build.gradle` at the end of `repositories`:
```
allprojects {
    repositories {
        [...]
        maven { url 'https://jitpack.io' }
    }
}
```

Then, add the following in your module `build.gradle` in `dependencies`:
```
dependencies {
    implementation 'com.github.josemmo:libvlc-android:X.X.X'
}
```

> NOTE: Replace `X.X.X` with the [latest release](https://github.com/josemmo/libvlc-android/releases/latest) version name.

Optionally, add this to build multiple APKs filtering by architecture:
```
splits {
    abi {
        enable true
        include "x86", "x86_64", "armeabi-v7a", "arm64-v8a"
    }
}
def abiCodes = ['x86':5, 'x86_64':8, 'armeabi-v7a':4, 'arm64-v8a':7]
applicationVariants.all { variant ->
    variant.outputs.each { output ->
        def abiName = output.getFilter(OutputFile.ABI)
        output.outputFileName = "MyApp-${variant.versionName}-${abiName}.apk"
        output.versionCodeOverride = defaultConfig.versionCode*10000000 + abiCodes.get(abiName, 0)
    }
}
```

## Documentation
This library is built from the official [videolan/vlc-android](https://code.videolan.org/videolan/vlc-android) repository. Check [this link](https://code.videolan.org/videolan/libvlc-android-samples) for a sample project.

For licensing, see [VideoLAN FAQ](https://wiki.videolan.org/Frequently_Asked_Questions/#May_I_redistribute_libVLC_in_my_application.3F).
