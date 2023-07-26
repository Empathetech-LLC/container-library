FROM empathetech/debian-gh

# Install basic requirements
# See https://docs.flutter.dev/get-started/install/linux
RUN apt-get update -yq \
  && apt-get install -yq --no-install-recommends \
    file unzip xz-utils zip \
    clang cmake ninja-build pkg-config libgtk-3-dev liblzma-dev \
  && apt-get clean

# Install Flutter SDK
ENV FLUTTER_VERSION=3.10.6 \
  FLUTTER_URL=https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz

RUN curl -o /tmp/flutter.tar.xz -L ${FLUTTER_URL} \
  && tar xf /tmp/flutter.tar.xz -C /opt \
  && rm /tmp/flutter.tar.xz

ENV PATH=$PATH:/opt/flutter/bin

# Install Android SDK
ENV CLI_TOOLS_VER=9477386 \
  CLI_TOOLS_ZIP=commandlinetools-linux-${CLI_TOOLS_VER}_latest.zip \
  CLI_TOOLS_URL=https://dl.google.com/android/repository/${CLI_TOOLS_ZIP}

ENV PATH=$PATH:/opt/android-sdk

# Create a new user and switch to it
RUN useradd -m -s /usr/bin/bash tester
USER tester

# Pre-download Dart SDK and Flutter dependencies
RUN flutter --disable-telemetry \
  && flutter config --no-analytics \
  && precache