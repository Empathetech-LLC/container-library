FROM empathetech/debian-android-sdk

USER root

# Setup environment
ENV FLUTTER_HOME=${HOME}/sdks/flutter \
  FLUTTER_VERSION=3.10.6

ENV FLUTTER_ROOT=$FLUTTER_HOME \
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

# Set Flutter to use chromium
ENV CHROME_EXECUTABLE=/usr/bin/chromium

# Run final setup and disable telemetry
RUN yes | flutter doctor --android-licenses \
  && chown -R root:root ${FLUTTER_HOME}

RUN flutter --disable-telemetry \
  && flutter precache