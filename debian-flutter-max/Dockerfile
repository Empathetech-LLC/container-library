FROM empathetech/debian-android-sdk

USER root
WORKDIR /

# Setup environment
#
# SDK versioning: https://github.com/flutter/flutter/releases
ENV FLUTTER_HOME=${HOME}/sdks/flutter \
  FLUTTER_VERSION=3.16.5

ENV FLUTTER_ROOT=$FLUTTER_HOME \
  CHROME_EXECUTABLE=/usr/bin/chromium \
  PATH=${PATH}:${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin

# Install basic requirements
# See https://docs.flutter.dev/get-started/install/linux
RUN apt-get update -yq \
  && apt-get install -yq --no-install-recommends \
    clang cmake ninja-build pkg-config libgtk-3-dev liblzma-dev chromium \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Clone Flutter from source
RUN git clone --depth 1 --branch ${FLUTTER_VERSION} https://github.com/flutter/flutter.git ${FLUTTER_HOME}

# Create Flutter group
RUN groupadd flutterers \
  && usermod -a -G flutterers empath

# Agree to licenses and update permissions
RUN yes | flutter doctor --android-licenses \
  && chown -R root:flutterers ${FLUTTER_HOME} \
  && chmod -R g+rwx ${FLUTTER_HOME}

# Switch back to functional user
USER empath
WORKDIR /home/empath

# Disable telemtry and pre-download binaries
RUN git config --global --add safe.directory /sdks/flutter \
  && flutter --disable-analytics \
  && flutter precache