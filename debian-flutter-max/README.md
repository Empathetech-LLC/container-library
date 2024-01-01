## debian-flutter-max

An image built from Empathetech's [debian-android-sdk](../debian-android-sdk/Dockerfile) base that includes the Flutter SDK and all additional packages required for linux and web development.

Running `flutter doctor -v` in max returns

```bash
[!] Flutter (Channel [user-branch], 3.13.1, on Debian GNU/Linux 12 (bookworm) 6.2.0-26-generic, locale en_US)
    ! Flutter version 3.13.1 on channel [user-branch] at /sdks/flutter
      Currently on an unknown channel. Run `flutter channel` to switch to an official channel.
      If that doesn't fix the issue, reinstall Flutter by following instructions at https://flutter.dev/docs/get-started/install.
    ! Upstream repository unknown source is not a standard remote.
      Set environment variable "FLUTTER_GIT_URL" to unknown source to dismiss this error.
    • Framework revision e1e47221e8 (3 days ago), 2023-08-22 21:43:18 -0700
    • Engine revision b20183e040
    • Dart version 3.1.0
    • DevTools version 2.25.0
    • If those were intentional, you can disregard the above warnings; however it is recommended to use "git" directly to perform update checks and upgrades.

[✓] Android toolchain - develop for Android devices (Android SDK version 33.0.2)
    • Android SDK at /opt/android-sdk-linux
    • Platform android-33, build-tools 33.0.2
    • ANDROID_HOME = /opt/android-sdk-linux
    • ANDROID_SDK_ROOT = /opt/android-sdk-linux
    • Java binary at: /usr/bin/java
    • Java version OpenJDK Runtime Environment (build 17.0.8+7-Debian-1deb12u1)
    • All Android licenses accepted.

[✓] Chrome - develop for the web
    • CHROME_EXECUTABLE = /usr/bin/chromium

[✓] Linux toolchain - develop for Linux desktop
    • Debian clang version 14.0.6
    • cmake version 3.25.1
    • ninja version 1.11.1
    • pkg-config version 1.8.1

[!] Android Studio (not installed)
    • Android Studio not found; download from https://developer.android.com/studio/index.html
      (or visit https://flutter.dev/docs/get-started/install/linux#android-setup for detailed instructions).

[✓] Connected device (2 available)
    • Linux (desktop) • linux  • linux-x64      • Debian GNU/Linux 12 (bookworm) 6.2.0-26-generic
    • Chrome (web)    • chrome • web-javascript • Chromium 116.0.5845.110 built on Debian 12.1, running on Debian 12.1

[✓] Network resources
    • All expected network resources are available.

! Doctor found issues in 2 categories.
```
* Doctor readout last updated: August 25th 2023, Version 1.0.2

### Credits

[Source documentation](https://docs.flutter.dev/get-started/install/linux)

Shout-out to [Cirrus Labs](https://github.com/cirruslabs/) for [inspiration](https://github.com/cirruslabs/docker-images-flutter/tree/master/sdk/Dockerfile)