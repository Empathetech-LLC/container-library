FROM empathetech/debian-gh

# Install basic requirements
# See https://docs.flutter.dev/get-started/install/linux
RUN apt-get update -yq \
  && apt-get install -yq --no-install-recommends \
    file unzip xz-utils zip \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Install Flutter SDK
ENV FLUTTER_VERSION=3.10.6
ENV FLUTTER_URL=https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz

RUN curl -o /tmp/flutter.tar.xz -L ${FLUTTER_URL} \
  && tar xf /tmp/flutter.tar.xz -C /opt \
  && rm /tmp/flutter.tar.xz

# Install Android SDK
ENV ANDROID_SDK_VER=9477386
ENV ANDROID_SDK_ZIP=commandlinetools-linux-${ANDROID_SDK_VER}_latest.zip
ENV ANDROID_SDK_URL=https://dl.google.com/android/repository/${ANDROID_SDK_ZIP}
ENV ANDROID_SDK_DIR=/opt/android-sdk

RUN mkdir -p ${ANDROID_SDK_DIR} \
  && curl -o /tmp/cmdline-tools.zip -L ${ANDROID_SDK_URL} \
  && unzip /tmp/cmdline-tools.zip -d ${ANDROID_SDK_DIR} \
  && rm /tmp/cmdline-tools.zip

# Accept Android SDK licenses
RUN yes | ./${ANDROID_SDK_DIR}/cmdline-tools/latest/bin/sdkmanager --licenses

# Create a new user and switch to it
RUN useradd -m -s /usr/bin/bash tester
USER tester
WORKDIR /home/tester

# Add Flutter and Android SDK to PATH
ENV PATH=$PATH:/opt/flutter/bin:${ANDROID_SDK_DIR}/cmdline-tools/latest/bin:${ANDROID_SDK_DIR}/platform-tools

# Disable Flutter telemetry,
# set Flutter to use our custom Android SDK location,
# and pre-download Dart SDK and Flutter dependencies
RUN flutter --disable-telemetry \
  && flutter config --android-sdk $ANDROID_SDK_DIR \
  && flutter precache