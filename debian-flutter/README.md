## debian-flutter

An image built from Empathetech's [debian-gh base](../debian-gh/Dockerfile) that has two versions.

### min
min includes the Flutter SDK and the Android SDK. Running `Flutter doctor` in min returns

```bash
```

### max
max inclues the Flutter SDK, the Android SDK, and all required packages for linux and web development. Running `Flutter doctor` in max returns

```bash
```

It is recommended to pull a specific image, such as

```Dockerfile
FROM empathetech/debian-flutter:min
```

Empathetech will either remove or ignore the latest tag

### Credits

Shoutout to Cirrus Labs
* specifically: https://github.com/cirruslabs/docker-images-flutter/tree/master/sdk/Dockerfile

Source documentation: https://docs.flutter.dev/get-started/install/linux