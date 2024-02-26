#!/bin/sh

apt-get update && \
    apt-get install -y --no-install-recommends \
    dnsutils \
    telnet \
    net-tools && \
    rm -rf /var/lib/apt/lists/*

# Install dnstools
# apk --no-cache update

# Install DNS utilities, telnet, and nslookup
# apk --no-cache add bind-tools busybox-extras util-linux
