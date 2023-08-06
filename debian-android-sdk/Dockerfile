FROM empathetech/debian-gh

USER root
WORKDIR /

# Setup environment
ENV ANDROID_HOME=/opt/android-sdk-linux \
  ANDROID_SDK_VERSION=9477386 \
  ANDROID_PLATFORM_VERSION=33 \
  ANDROID_BUILD_VERSION=33.0.2

ENV ANDROID_SDK_URL=https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_SDK_VERSION}_latest.zip

ENV ANDROID_SDK_ROOT=$ANDROID_HOME \
  PATH=${PATH}:${ANDROID_HOME}/cmdline-tools/latest/bin:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/emulator

# Install basic requirements
RUN apt-get update -yq \
  && apt-get install -yq --no-install-recommends \
    zip unzip openjdk-17-jdk \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Install SDK
RUN mkdir -p ${ANDROID_HOME}/cmdline-tools/latest \
  && curl -o /tmp/cmdline-tools.zip -L ${ANDROID_SDK_URL} \
  && unzip /tmp/cmdline-tools.zip -d /tmp/cmdline-dump \
  && mv /tmp/cmdline-dump/cmdline-tools/* ${ANDROID_HOME}/cmdline-tools/latest/ \
  && rm -rf /tmp/cmdline*

# Accept licenses and install necessary packages
RUN yes | sdkmanager --licenses \
  && sdkmanager "platform-tools" "emulator" "platforms;android-$ANDROID_PLATFORM_VERSION" "build-tools;$ANDROID_BUILD_VERSION"

USER empath
WORKDIR /home/empath