FROM golang:1.9.2-alpine
MAINTAINER Joshua Noble <acejam@gmail.com>

RUN apk --no-cache add git
RUN go get -u github.com/acejam/Sia-Ant-Farm/...
RUN cd $GOPATH/src/github.com/acejam/Sia-Ant-Farm
RUN make dependencies && make
