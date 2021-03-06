FROM alpine:3.7 as build
MAINTAINER "Coleman Word <colemanword@gmail.com>"

RUN apk add --update --no-cache ca-certificates git

ARG VERSION=v2.9.1
ARG FILENAME=helm-${VERSION}-linux-amd64.tar.gz

WORKDIR /

RUN apk add --update -t deps curl tar gzip
RUN curl -L http://storage.googleapis.com/kubernetes-helm/${FILENAME} | tar zxv -C /tmp

# The image we keep
FROM alpine:3.7

RUN apk add --update --no-cache git ca-certificates
RUN git clone https://github.com/Thekubebro/helm.git && cd helm
COPY --from=build /tmp/linux-amd64/helm /bin/helm

ENTRYPOINT ["/bin/helm"]

