#!/bin/sh

if [ "$REQ_MAX" = "" ];
then
    export REQ_MAX=100
fi

#DOMAIN


if [ "$DNS" = "" ];
then
    export DNS="8.8.8.8 8.8.4.4"
fi

if [ "$SPEED_LIMIT" = "" ];
then
    export SPEED_LIMIT="100k"
fi

if [ "$REQ_BURST" = "" ];
then
    export REQ_BURST=1000
fi

if [ "$LOGGER" != "" ];
then
    echo "$SETTINGS" > /opt/conf/settings.yml
fi

if [ "$LOGGER" != "" ];
then
    echo "$LOGGER" > /opt/conf/logger.lua
fi

(envsubst '${REQ_MAX} ${DOMAIN} ${DNS} ${SPEED_LIMIT} ${REQ_BURST} ${SETTINGS} ${LOGGER}' <\
 /opt/templates/nginx-corsproxy.conf.tmpl ) > /etc/nginx/nginx.conf


nginx -g 'daemon off;'