#!/bin/sh
if [ -f /data/options.json ]; then
    # Substitui a pasta antiga /config/zigbee2mqtt por /config/zboss_zigbee2mqtt no options.json
    sed -i 's|"/config/zigbee2mqtt"|"/config/zboss_zigbee2mqtt"|g' /data/options.json
fi

# Executa o entrypoint oficial do Add-on Z2M com Bashio
exec /docker-entrypoint.sh "$@"
