ARG ALPINE_VERSION=3.18

FROM alpine:${ALPINE_VERSION} AS base
LABEL maintainer="<Aditya Prima> aprimediet@gmail.com"

# Add s6-overlay
ENV S6_OVERLAY_VERSION=v3.1.5.0

# Install base dependencies
RUN apk add --update --no-cache bash libcap curl

# Get S6-OVERLAY
ADD https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz /tmp
ADD https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz /tmp
ADD https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-symlinks-noarch.tar.xz /tmp

# Install S6-Overlay
RUN tar -Jxpf /tmp/s6-overlay-noarch.tar.xz -C /
RUN tar -Jxpf /tmp/s6-overlay-x86_64.tar.xz -C /
RUN tar -Jxpf /tmp/s6-overlay-symlinks-noarch.tar.xz -C /

# Remove S6-Overlay
RUN rm -f /tmp/s6-overlay-noarch.tar.xz
RUN rm -f /tmp/s6-overlay-x76_64.tar.xz
RUN rm -f /tmp/s6-overlay-symlinks-noarch.tar.xz

ENTRYPOINT [ "/init" ]
