FROM docker:cli

ENV DOCKER_BUILDKIT=1 \
  BUILDX_BUILDER=1 \
  BUILDX_VERSION=v0.11.2

RUN mkdir -p $HOME/.docker/cli-plugins/ \
  && wget -O $HOME/.docker/cli-plugins/docker-buildx https://github.com/docker/buildx/releases/download/${BUILDX_VERSION}/buildx-${BUILDX_VERSION}.linux-amd64 \
  && chmod a+x $HOME/.docker/cli-plugins/docker-buildx