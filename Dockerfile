FROM riccardoblb/nginx-lua:amd64
MAINTAINER Riccardo Balbo <riccardo0blb@gmail.com>
USER root
ENV PORT=8080
COPY home/WWW/corsproxy/html /opt/html
COPY config /opt/templates
COPY run.sh /opt/run.sh

RUN apk add --no-cache --virtual .build-deps  build-base &&\
 apk add --no-cache  gettext &&\
  chmod +x /opt/run.sh &&\
  luarocks install  luafilesystem  &&\
  luarocks install  lub &&\
  luarocks install yaml &&\
  luarocks install lrexlib-POSIX &&\
  apk del .build-deps

RUN mkdir -p /opt/conf
CMD ["/opt/run.sh" ]

