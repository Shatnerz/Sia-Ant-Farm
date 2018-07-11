FROM golang:1.10.3
MAINTAINER Joshua Noble <acejam@gmail.com>

RUN go get -u github.com/NebulousLabs/Sia-Ant-Farm/...
RUN cd $GOPATH/src/github.com/NebulousLabs/Sia-Ant-Farm && \
    make dependencies && make

COPY config.json /go

RUN apt-get update && apt-get install -y --no-install-recommends \
		socat && \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT socat tcp-listen:8000,reuseaddr,fork tcp:localhost:9980 & sia-antfarm
