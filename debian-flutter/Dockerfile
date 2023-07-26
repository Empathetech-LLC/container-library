FROM empathetech/debian-gh

# Install basic requirements
RUN apt-get update -yq \
  && apt-get install -yq --no-install-recommends \
    jq xz-utils \
  && apt-get clean

# Install Flutter SDK
ENV FLUTTER_VERSION=3.10.6

RUN curl -o /tmp/flutter.tar.xz -L https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz \
  && tar xf /tmp/flutter.tar.xz -C /opt \
  && rm /tmp/flutter.tar.xz

ENV PATH=$PATH:/opt/flutter/bin

# Create a new user and switch to it
RUN useradd -m -s /usr/bin/bash tester
USER tester

# Pre-download Dart SDK and Flutter dependencies
RUN flutter precache
