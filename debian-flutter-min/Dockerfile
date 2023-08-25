FROM empathetech/debian-android-sdk

USER root
WORKDIR /

# Setup environment
#
# SDK versioning: https://github.com/flutter/flutter/releases
ENV FLUTTER_HOME=${HOME}/sdks/flutter \
  FLUTTER_VERSION=3.13.1

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
RUN git config --global --add safe.directory /sdks/flutter \
  && flutter --disable-telemetry \
  && flutter precache