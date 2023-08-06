FROM empathetech/debian-android-sdk

USER root
WORKDIR /

# Setup environment
ENV FLUTTER_HOME=${HOME}/sdks/flutter \
  FLUTTER_VERSION=3.10.6

ENV FLUTTER_ROOT=$FLUTTER_HOME \
  PATH=${PATH}:${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin

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
RUN flutter --disable-telemetry \
  && flutter precache