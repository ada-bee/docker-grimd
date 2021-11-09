FROM golang AS build

ENV GOARCH=$TARGETPLATFORM
WORKDIR /go/src/grimd/

RUN git clone https://github.com/looterz/grimd.git /go/src/grimd/
RUN go build -o /bin/grimd



FROM gcr.io/distroless/base

COPY --from=build /bin/grimd /bin/grimd

EXPOSE 53:53/udp
EXPOSE 53:53/tcp
EXPOSE 8080:8080/tcp

VOLUME ["/config"]

ENTRYPOINT ["/bin/grimd", "-config", "/config/grimd.toml", "-update"]