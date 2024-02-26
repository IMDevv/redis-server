# syntax=docker/dockerfile:1
FROM alpine:latest as base
FROM base as build
COPY configSentinel /etc/redis/.

COPY init.sh /usr/local/bin/entrypoint
RUN chmod +x /usr/local/bin/entrypoint

# Add the installation commands directly
RUN apk --no-cache update && \
    apk --no-cache add bind-tools busybox-extras util-linux
################################################################################
# Create a final stage for running your application.
#
# The following commands copy the output from the "build" stage above and tell
# the container runtime to execute it when the image is run. Ideally this stage
# contains the minimal runtime dependencies for the application as to produce
# the smallest image possible. This often means using a different and smaller
# image than the one used for building the application, but for illustrative
# purposes the "base" image is used here.
FROM base AS final

# Create a non-privileged user that the app will run under.
# See https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#user
ARG UID=10001
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/nonexistent" \
    --shell "/sbin/nologin" \
    --no-create-home \
    --uid "${UID}" \
    redisuser
USER redisuser

# Copy the executable from the "build" stage.
# COPY --from=build /bin/hello.sh /bin/

# What the container should run when it is started.
# ENTRYPOINT [ "/usr/local/bin/entrypoint" ]

