FROM dsuite/alpine-data

ARG DOCKER_IMAGE_CREATED
ARG DOCKER_IMAGE_REVISION

LABEL maintainer="Hexosse <hexosse@gmail.com>" \
    org.opencontainers.image.title="docker-suite dsuite/hub-updater image" \
    org.opencontainers.image.description="Update docker hub full description" \
    org.opencontainers.image.authors="Hexosse <hexosse@gmail.com>" \
    org.opencontainers.image.vendor="docker-suite" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://github.com/docker-suite/hub-updater" \
    org.opencontainers.image.source="https://github.com/docker-suite/hub-updater" \
    org.opencontainers.image.documentation="https://github.com/docker-suite/hub-updater/blob/master/Readme.md" \
    org.opencontainers.image.created="${DOCKER_IMAGE_CREATED}" \
    org.opencontainers.image.revision="${DOCKER_IMAGE_REVISION}"


## Copy files
COPY entrypoint.sh /entrypoint.sh


## Make entrypoint executable
RUN chmod +x /entrypoint.sh


## Default working dir
WORKDIR /data


## Volumes
VOLUME ["/data"]


## Entrypoint
ENTRYPOINT ["/entrypoint.sh"]
