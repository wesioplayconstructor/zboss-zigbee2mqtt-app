#!/bin/sh
if [ -f /data/options.json ]; then
    sed -i 's|"/config/zigbee2mqtt"|"/config/zboss_zigbee2mqtt"|g' /data/options.json
fi

if [ -f /docker-entrypoint.sh ]; then
    exec /docker-entrypoint.sh "$@"
elif [ -f /run.sh ]; then
    exec /run.sh "$@"
elif [ -f /usr/local/bin/docker-entrypoint.sh ]; then
    exec /usr/local/bin/docker-entrypoint.sh "$@"
else
    echo "[zboss_zigbee2mqtt] Script de entrypoint nativo nao encontrado. Arquivos em /:"
    ls -la /
    export ZIGBEE2MQTT_DATA="${ZIGBEE2MQTT_DATA:-/config/zboss_zigbee2mqtt}"
    mkdir -p "$ZIGBEE2MQTT_DATA"
    cd /app
    exec node index.js "$@"
fi
