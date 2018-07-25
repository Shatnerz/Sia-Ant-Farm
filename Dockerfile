FROM ubuntu:16.04
MAINTAINER Joshua Noble <acejam@gmail.com>

RUN apt-get update && \
    apt-get install -y --no-install-recommends software-properties-common

RUN add-apt-repository ppa:gophers/archive && \
    apt-get update && \
    apt-get install -y golang-1.10-go ca-certificates git

RUN mkdir /go
ENV GOPATH /go
ENV PATH /go/bin:/usr/lib/go-1.10/bin:$PATH


RUN apt-get install -y locales locales-all
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# RUN go get -u gitlab.com/NebulousLabs/Sia-Ant-Farm/...
COPY / $GOPATH/src/gitlab.com/NebulousLabs/Sia-Ant-Farm/

RUN cd $GOPATH/src/gitlab.com/NebulousLabs/Sia-Ant-Farm && \
    make dependencies && make
#
COPY config.json $GOPATH/bin
# # # ENTRYPOINT socat tcp-listen:9980,reuseaddr,fork tcp:localhost:8000 & \
CMD $GOPATH/bin/sia-antfarm -config $GOPATH/bin/config.json

# COPY config.json /go


# COPY sia-antfarm-bin /go/bin
# RUN go get -u gitlab.com/NebulousLabs/Sia-Ant-Farm/... && \
#     cd $GOPATH/src/gitlab.com/NebulousLabs/Sia-Ant-Farm && \
#     make dependencies && make
#
# RUN sia-antfarm -c /go/config.json

# CMD env GOOS=macos GOARCH=amd64 /go/bin/sia-antfarm-bin -c /go/config.json
# ENTRYPOINT socat tcp-listen:9980,reuseaddr,fork tcp:localhost:8000 & sia-antfarm
