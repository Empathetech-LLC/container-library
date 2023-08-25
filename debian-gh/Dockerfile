FROM debian:stable-slim

# Verify root user and create a non-root user for later
USER root
WORKDIR /

RUN useradd -ms /bin/bash empath

# Install basic requirements
RUN apt-get update -yq \
  && apt-get install -yq --no-install-recommends \
    curl git ca-certificates

# Setup & install GitHub CLI tool
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
  && chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
  && apt-get update -yq \
  && apt-get install -yq --no-install-recommends \
    gh \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

USER empath
WORKDIR /home/empath