FROM ubuntu:16.04
MAINTAINER https://github.com/cloudfoundry-incubator/diego-dockerfiles

ENV PORT 8080
ENV HOME /root
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN apt-get update && apt-get -y install socat \
  && curl -L -s https://github.com/xuiv/gost-heroku/releases/download/1.01/gost-linux -o /usr/bin/gost \
  && curl -L -s https://github.com/xuiv/v2ray-heroku/releases/download/1.01/v2ray-linux -o /usr/bin/ray \
  && curl -L -s https://github.com/xuiv/v2ray-heroku/releases/download/1.01/server.json -o /usr/bin/config.json \
  && curl -L -s https://github.com/xuiv/pws-dockerfile/releases/download/0.001/udpspeeder -o /usr/bin/udpspeeder \
  && chmod +x /usr/bin/ray /usr/bin/gost /usr/bin/udpspeeder \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/*

EXPOSE 8080
WORKDIR /root

CMD (gost -L quic+ws://:8080 -L :1080 -L quic://:1081 &) && (socat tcp-listen:1082,reuseaddr,fork udp:127.0.0.1:1081 &)
