#!/bin/sh
set -e

DATA_DIR="${ZIGBEE2MQTT_DATA:-/config/zboss_zigbee2mqtt}"
mkdir -p "$DATA_DIR"

if [ ! -f "$DATA_DIR/configuration.yaml" ]; then
    echo "[zboss_zigbee2mqtt] Inicializando configuration.yaml padrão em $DATA_DIR..."
    cat << 'EOF' > "$DATA_DIR/configuration.yaml"
homeassistant: true
permit_join: false
mqtt:
  base_topic: zboss_zigbee2mqtt
  server: 'mqtt://core-mosquitto:1883'
serial:
  port: /dev/serial/by-id/usb-Espressif_USB_JTAG_serial_debug_unit_98:A3:16:BF:27:18-if00
  adapter: zboss
  baudrate: 115200
  rtscts: false
frontend:
  port: 8099
EOF
fi

cd /app
exec node index.js
