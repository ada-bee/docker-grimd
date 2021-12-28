FROM golang AS build

ENV VERSION=1.1.0
ENV GOARCH=$TARGETPLATFORM

WORKDIR /go/src/
RUN wget https://github.com/looterz/grimd/archive/refs/tags/v${VERSION}.tar.gz && tar -xvf v${VERSION}.tar.gz

WORKDIR /go/src/grimd-${VERSION}
RUN go build -o /bin/grimd


FROM gcr.io/distroless/base

COPY --from=build /bin/grimd /bin/grimd

EXPOSE 53:53/udp
EXPOSE 53:53/tcp
EXPOSE 8080:8080/tcp

VOLUME ["/config"]

ENTRYPOINT ["/bin/grimd", "-config", "/config/grimd.toml", "-update"]