## debian-android-sdk

Is built from the Empathetech [debian-gh](../debian-gh/Dockerfile) base and has the Android SDK installed. Nothing more, nothing less.

### Versioning

Check the 

```Dockerfile
ENV ANDROID_HOME...
```

layer at the start of the [Dockerfile](Dockerfile) to see the current SDK and build versions.

### Credits

Shout-out to [Cirrus Labs](https://github.com/cirruslabs/) for [inspiration](https://github.com/cirruslabs/docker-images-android/tree/master/sdk/tools/Dockerfile)