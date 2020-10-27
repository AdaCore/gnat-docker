FROM ubuntu:18.04

RUN set -xe \
    && DEBIAN_FRONTEND=noninteractive apt-get update -y \
    && apt-get install -y \
        make \
        gcc \
    && rm -rf /var/lib/apt/lists/*

