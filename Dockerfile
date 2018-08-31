ARG ALPINE_TAG=3.8

FROM alpine:$ALPINE_TAG

ARG ALPINE_TAG

LABEL maintainer="Spritsail <alpine@spritsail.io>" \
      org.label-schema.vendor="Spritsail" \
      org.label-schema.name="Alpine Linux" \
      org.label-schema.url="https://github.com/gliderlabs/docker-alpine" \
      org.label-schema.description="Alpine Linux base image" \
      org.label-schema.version=${ALPINE_TAG}

# Override shell for sh-y debugging goodness
SHELL ["/bin/sh", "-exc"]

COPY skel/ /
ENV ENV="/etc/profile"
RUN sed -i '1ihttp://alpine.spritsail.io/spritsail' /etc/apk/repositories \
 && wget -P /etc/apk/keys https://alpine.spritsail.io/spritsail-alpine.rsa.pub \
 && apk --no-cache add \
        su-exec \
        tini

ENTRYPOINT ["/sbin/tini" , "--"]
