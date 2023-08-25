## debian-android-sdk

An image built from Empathetech's [debian-gh](../debian-gh/Dockerfile) base that has the Android SDK installed. Nothing more, nothing less.

### Versioning

Check the 

```Dockerfile
ENV ANDROID_HOME...
```

layer at the start of the [Dockerfile](Dockerfile) to see the current SDK and build versions.

### Credits

Shoutout to [Cirrus Labs](https://github.com/cirruslabs/) for [inspiration](https://github.com/cirruslabs/docker-images-android/tree/master/sdk/tools/Dockerfile)