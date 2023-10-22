FROM jenkins/inbound-agent:jdk17

USER root
WORKDIR /

# Setup environment
#
# CMD tools versioning: https://developer.android.com/studio#command-line-tools-only
# Platforms versioning: https://developer.android.com/tools/releases/platforms
# Builds versioning: https://developer.android.com/tools/releases/build-tools
ENV ANDROID_HOME=/opt/android-sdk-linux \
  CMD_TOOLS_VERSION=10406996 \
  ANDROID_PLATFORM_VERSION=33 \
  ANDROID_BUILD_VERSION=33.0.2

ENV ANDROID_SDK_URL=https://dl.google.com/android/repository/commandlinetools-linux-${CMD_TOOLS_VERSION}_latest.zip

ENV ANDROID_SDK_ROOT=${ANDROID_HOME} \
  PATH=${PATH}:${ANDROID_HOME}/cmdline-tools/latest/bin:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/emulator

# Install basic requirements
# And Flutter requirements: see https://docs.flutter.dev/get-started/install/linux
RUN apt-get update -yq \
  && apt-get install -yq --no-install-recommends \
    curl ca-certificates git zip unzip  \
    clang cmake ninja-build pkg-config libgtk-3-dev liblzma-dev chromium

# Install GitHub CLI
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
  && chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
  && apt-get update -yq \
  && apt-get install -yq --no-install-recommends \
    gh \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Install Android SDK
RUN mkdir -p ${ANDROID_HOME}/cmdline-tools/latest \
  && curl -o /tmp/cmdline-tools.zip -L ${ANDROID_SDK_URL} \
  && unzip /tmp/cmdline-tools.zip -d /tmp/cmdline-dump \
  && mv /tmp/cmdline-dump/cmdline-tools/* ${ANDROID_HOME}/cmdline-tools/latest/ \
  && rm -rf /tmp/cmdline*

# Accept licenses and install necessary packages
RUN yes | sdkmanager --licenses \
  && sdkmanager "platform-tools" "emulator" "platforms;android-$ANDROID_PLATFORM_VERSION" "build-tools;$ANDROID_BUILD_VERSION"

# Setup Flutter environment
ENV FLUTTER_HOME=${HOME}/sdks/flutter \
  FLUTTER_VERSION=3.13.8

ENV FLUTTER_ROOT=$FLUTTER_HOME \
  CHROME_EXECUTABLE=/usr/bin/chromium \
  PATH=${PATH}:${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin

# Clone Flutter from source
RUN git clone --depth 1 --branch ${FLUTTER_VERSION} https://github.com/flutter/flutter.git ${FLUTTER_HOME}

# Create Flutter group
RUN groupadd flutterers \
  && usermod -a -G flutterers jenkins

# Agree to licenses and update permissions
RUN yes | flutter doctor --android-licenses \
  && chown -R root:flutterers ${FLUTTER_HOME} \
  && chmod -R g+rwx ${FLUTTER_HOME}

# Switch to the agent user
USER jenkins

# Create a /tmp directory that the jenkins user can use
WORKDIR /home/jenkins

RUN mkdir tmp

# Disable telemtry and pre-download binaries
RUN git config --global --add safe.directory /sdks/flutter \
  && flutter --disable-telemetry \
  && flutter precache
