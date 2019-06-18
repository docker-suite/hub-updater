FROM dsuite/alpine-data

LABEL maintainer="Hexosse <hexosse@gmail.com>" \
      description="Update docker hub full description." \
      vendor="docker-suite" \
      license="MIT"


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
