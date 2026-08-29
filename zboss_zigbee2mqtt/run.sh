#!/bin/sh
set -e

# Forçar overrides de ambiente para o Z2M nunca usar a pasta ou serial do outro Add-on/ZHA
export ZIGBEE2MQTT_DATA="/config/zboss_zigbee2mqtt"
export Z2M_DATA="/config/zboss_zigbee2mqtt"
export ZIGBEE2MQTT_CONFIG_SERIAL_PORT="/dev/serial/by-id/usb-Espressif_USB_JTAG_serial_debug_unit_98:A3:16:BF:20:A0-if00"
export ZIGBEE2MQTT_CONFIG_SERIAL_ADAPTER="zboss"
export ZIGBEE2MQTT_CONFIG_MQTT_BASE_TOPIC="zboss_zigbee2mqtt"
export ZIGBEE2MQTT_CONFIG_FRONTEND_PORT="8099"
export ZIGBEE2MQTT_CONFIG_HOMEASSISTANT_ENABLED="true"

mkdir -p "$ZIGBEE2MQTT_DATA"

if [ -f /data/options.json ]; then
    sed -i 's|/config/zigbee2mqtt|/config/zboss_zigbee2mqtt|g' /data/options.json 2>/dev/null || true
    sed -i 's|98:A3:16:BF:27:18|98:A3:16:BF:20:A0|g' /data/options.json 2>/dev/null || true
fi

cd /app
exec node index.js "$@"
