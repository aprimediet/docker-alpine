ARG ALPINE_VERSION=3.18

FROM alpine:${ALPINE_VERSION} AS base
LABEL maintainer="<Aditya Prima> aprimediet@gmail.com"

ARG ALPINE_VERSION=3.18
ARG S6_VERSION=3.1.5.0
ARG ALPINE_MIRROR=http://foobar.turbo.net.id/alpine
ARG TZ=Asia/Jakarta

# SET REPOSITORY MIRROR TO INDONESIA
RUN touch /etc/apk/repositories
RUN echo "${ALPINE_MIRROR}/v${ALPINE_VERSION}/main" > /etc/apk/repositories
RUN echo "${ALPINE_MIRROR}/v${ALPINE_VERSION}/community" >> /etc/apk/repositories

# INSTALL BASE DEPENDENCIES
RUN --mount=type=cache,target=/var/cache/apk \
    apk add --update \
    bash libcap tzdata

# SET LOCAL TIMEZONE
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Get S6-OVERLAY
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_VERSION}/s6-overlay-noarch.tar.xz /tmp
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_VERSION}/s6-overlay-x86_64.tar.xz /tmp
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_VERSION}/s6-overlay-symlinks-noarch.tar.xz /tmp

# Install S6-Overlay
RUN tar -Jxpf /tmp/s6-overlay-noarch.tar.xz -C / && \
    tar -Jxpf /tmp/s6-overlay-x86_64.tar.xz -C / && \
    tar -Jxpf /tmp/s6-overlay-symlinks-noarch.tar.xz -C /

# Remove S6-Overlay
RUN rm -f /tmp/s6-overlay-noarch.tar.xz && \
    rm -f /tmp/s6-overlay-x86_64.tar.xz && \
    rm -f /tmp/s6-overlay-symlinks-noarch.tar.xz

ENTRYPOINT [ "/init" ]
