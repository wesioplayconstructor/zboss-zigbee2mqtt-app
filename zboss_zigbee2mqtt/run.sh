#!/bin/sh
DATA_DIR="/config/zboss_zigbee2mqtt"
mkdir -p "$DATA_DIR"

if [ ! -f "$DATA_DIR/configuration.yaml" ]; then
    echo "[zboss_zigbee2mqtt] Criando configuration.yaml padrao em $DATA_DIR..."
    cat << 'EOF' > "$DATA_DIR/configuration.yaml"
homeassistant: true
permit_join: false
mqtt:
  base_topic: zboss_zigbee2mqtt
  server: 'mqtt://core-mosquitto:1883'
  user: 'wesio'
  password: 'wasd'
serial:
  port: /dev/serial/by-id/usb-Espressif_USB_JTAG_serial_debug_unit_98:A3:16:BF:20:A0-if00
  adapter: zboss
  baudrate: 115200
  rtscts: false
frontend:
  port: 8099
advanced:
  log_level: info
EOF
fi

if [ -f /data/options.json ]; then
    sed -i 's|"/config/zigbee2mqtt"|"/config/zboss_zigbee2mqtt"|g' /data/options.json
    sed -i 's|98:A3:16:BF:27:18|98:A3:16:BF:20:A0|g' /data/options.json
fi

if [ -f /docker-entrypoint.sh ]; then
    exec /docker-entrypoint.sh "$@"
elif [ -f /run.sh ]; then
    exec /run.sh "$@"
elif [ -f /usr/local/bin/docker-entrypoint.sh ]; then
    exec /usr/local/bin/docker-entrypoint.sh "$@"
else
    export ZIGBEE2MQTT_DATA="$DATA_DIR"
    cd /app
    exec node index.js "$@"
fi
