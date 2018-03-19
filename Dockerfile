
FROM golang:1.10.0-alpine3.7 as builder

ENV \
  TERM=xterm \
  BUILD_DATE="2018-03-19" \
  TZ='Europe/Berlin'

# ---------------------------------------------------------------------------------------

WORKDIR /opt/go

RUN \
  apk update --no-cache && \
  apk upgrade --no-cache && \
  apk add \
    ca-certificates curl g++ git make python libuv nodejs nodejs-npm tzdata && \
  cp /usr/share/zoneinfo/${TZ} /etc/localtime && \
  echo ${TZ} > /etc/timezone && \
  echo "export TZ=${TZ}" > /etc/enviroment && \
  echo "export BUILD_DATE=${BUILD_DATE}" >> /etc/enviroment

RUN \
  export GOPATH=/opt/go && \
  go get github.com/aerth/markdownd || true && \
  mkdir /tmp/markdownd && \
  export GOPATH=/opt/go && \
  export GOMAXPROCS=4 && \
  export GOARCH=amd64 && \
  cd ${GOPATH}/src/github.com/aerth/markdownd && \
  ls -1 && \
  /bin/sh ./build.sh && \
  mv markdownd /tmp/markdownd/ && \
  mv theme /tmp/markdownd/

CMD [ "/bin/sh" ]

# ---------------------------------------------------------------------------------------

# ---------------------------------------------------------------------------------------

FROM alpine:3.7

EXPOSE 8080

LABEL \
  version="1803" \
  maintainer="Bodo Schulz <bodo@boone-schulz.de>" \
  org.label-schema.build-date=${BUILD_DATE} \
  org.label-schema.name="markdownd Docker Image" \
  org.label-schema.description="Inofficial markdownd Docker Image" \
  org.label-schema.url="https://markdownd.herokuapp.com/" \
  org.label-schema.vcs-url="https://github.com/bodsch/docker-markdownd" \
  org.label-schema.vendor="Bodo Schulz" \
  org.label-schema.schema-version="1.0" \
  com.microscaling.docker.dockerfile="/Dockerfile" \
  com.microscaling.license="MIT License"

COPY --from=builder /etc/enviroment /etc/enviroment
COPY --from=builder /tmp/markdownd/ /markdownd

RUN \
  apk --quiet --no-cache update && \
  if [ -f /etc/enviroment ] ; then . /etc/enviroment; fi && \
  rm -rf \
    /tmp/* \
    /var/cache/apk/*

VOLUME [ "/markdownd", "/data" ]

WORKDIR /markdownd

ENTRYPOINT [ "/markdownd/markdownd" ]

CMD [ "-toc", "-footer", "/data/themes/footer.html", "-header", "/data/themes/header.html", "-index", "index.md", "/data" ]
