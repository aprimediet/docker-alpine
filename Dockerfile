FROM alpine:3.10
LABEL maintainer="<Aditya Prima> aditya.prima@qti.co.id"

# Add s6-overlay
ENV S6_OVERLAY_VERSION=v1.21.4.0

# Install base dependencies
RUN apk add --update --no-cache bash libcap

# Get S6-OVERLAY
ADD https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-amd64.tar.gz /tmp/

# Install S6-Overlay
RUN tar xvf /tmp/s6-overlay-amd64.tar.gz -C /

ENTRYPOINT [ "/init" ]
