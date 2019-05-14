FROM cloudfoundry/inigo-ci
MAINTAINER https://github.com/cloudfoundry-incubator/diego-dockerfiles

RUN \
  curl -L -s https://github.com/xuiv/gost-heroku/releases/download/1.01/gost-linux -o /usr/bin/gost \
  && curl -L -s https://github.com/xuiv/v2ray-heroku/releases/download/1.01/v2ray-linux -o /usr/bin/ray \
  && curl -L -s https://github.com/xuiv/v2ray-heroku/releases/download/1.01/server.json -o /usr/bin/config.json \
  && chmod +x /usr/bin/ray /usr/bin/gost \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/*

ENV PORT 8080
EXPOSE 8080
WORKDIR /root

CMD gost -L quic+ws://:8080 -L :1080
