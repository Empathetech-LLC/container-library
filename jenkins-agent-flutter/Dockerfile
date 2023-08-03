FROM jenkins/inbound-agent

USER root
WORKDIR /

# Setup Android environment
ENV ANDROID_HOME=/opt/android-sdk-linux \
  ANDROID_SDK_VERSION=9477386 \
  ANDROID_PLATFORM_VERSION=33 \
  ANDROID_BUILD_VERSION=33.0.2

ENV ANDROID_SDK_URL=https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_SDK_VERSION}_latest.zip

ENV ANDROID_SDK_ROOT=${ANDROID_HOME} \
  PATH=${PATH}:${ANDROID_HOME}/cmdline-tools/latest/bin:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/emulator

# Install basic requirements
RUN apt-get update -yq \
  && apt-get install -yq --no-install-recommends \
    curl git ca-certificates zip unzip

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
  && sdkmanager "platform-tools" "platforms;android-$ANDROID_PLATFORM_VERSION" "build-tools;$ANDROID_BUILD_VERSION"

# Setup Flutter environment
ENV FLUTTER_HOME=${HOME}/sdks/flutter \
  FLUTTER_VERSION=3.10.6

ENV FLUTTER_ROOT=$FLUTTER_HOME \
  PATH=${PATH}:${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin

# Clone Flutter from source
RUN git clone --depth 1 --branch ${FLUTTER_VERSION} https://github.com/flutter/flutter.git ${FLUTTER_HOME}

# Create Flutter group
RUN groupadd flutterers \
  && usermod -a -G flutterers jenkins

# Agree to licenses and update permissions
RUN yes | flutter doctor --android-licenses \
  && chown -R jenkins:flutterers ${FLUTTER_HOME} \
  && chmod -R g+rwx ${FLUTTER_HOME}

# Switch back to functional user
USER jenkins
WORKDIR /home/jenkins

# Disable telemtry and pre-download binaries
RUN flutter --disable-telemetry \
  && flutter precache
