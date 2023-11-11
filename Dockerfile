FROM alpine:3.15
LABEL maintainer="<Aditya Prima> aprimediet@gmail.com"

# Add s6-overlay
ENV S6_OVERLAY_VERSION=v2.2.0.3

# Install base dependencies
RUN apk add --update --no-cache bash libcap

# Get S6-OVERLAY
ADD https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-amd64.tar.gz /tmp/

# Install S6-Overlay
RUN tar xvf /tmp/s6-overlay-amd64.tar.gz -C /

# Remove S6-Overlay
RUN rm -f /tmp/s6-overlay-amd64.tar.gz

ENTRYPOINT [ "/init" ]
