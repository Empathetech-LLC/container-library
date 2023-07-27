FROM empathetech/debian-android-sdk

USER root

# Setup environment
ENV FLUTTER_HOME=${HOME}/sdks/flutter \
  FLUTTER_VERSION=3.10.6

ENV FLUTTER_ROOT=$FLUTTER_HOME \
  PATH=${PATH}:${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin

# Clone Flutter from source
RUN git clone --depth 1 --branch ${FLUTTER_VERSION} https://github.com/flutter/flutter.git ${FLUTTER_HOME}

# Run final setup and disable telemetry
RUN yes | flutter doctor --android-licenses \
  && chown -R root:root ${FLUTTER_HOME}

RUN flutter --disable-telemetry \
  && flutter precache