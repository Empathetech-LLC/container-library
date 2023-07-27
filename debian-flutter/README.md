## debian-flutter

An image built from Empathetech's debian-gh base that has two versions.

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

Speaking of latest, generally all of the sub-pieces will be (latest stable/LTS). At the time of writing that is...

### Versions

* Debian: bookworm
* Flutter: 3.10.6
* Android SDK: 9477386 (thanks, Google)
  * OpenJDK: 17
  * SDK platform: 33
  * SDK platform tools: latest
  * SDK build tools (max only): 33
* chromium (max only): latest