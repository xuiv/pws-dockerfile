FROM ubuntu:16.04
MAINTAINER https://github.com/cloudfoundry-incubator/diego-dockerfiles

ENV PORT 8080
ENV HOME /root
ENV GOPATH /root/go
ENV PATH /root/go/bin:/usr/local/go/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN mkdir -p $GOPATH \
  && apt-get update && apt-get -y install iptables curl \
  && curl -L -s https://github.com/xuiv/gost-heroku/releases/download/1.01/gost-linux -o /usr/bin/gost \
  && curl -L -s https://github.com/xuiv/v2ray-heroku/releases/download/1.01/v2ray-linux -o /usr/bin/ray \
  && curl -L -s https://github.com/xuiv/v2ray-heroku/releases/download/1.01/server.json -o /usr/bin/config.json \
  && chmod +x /usr/bin/ray /usr/bin/gost \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/*

EXPOSE 8080
WORKDIR /root

CMD gost -L quic+ws://:8080 -L :1080
