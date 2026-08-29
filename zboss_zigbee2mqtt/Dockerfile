FROM ghcr.io/tostmann/zigbee2mqtt-esp32:latest

# Persistent data directory under Home Assistant config folder
ENV ZIGBEE2MQTT_DATA=/config/zboss_zigbee2mqtt
ENV Z2M_DATA=/config/zboss_zigbee2mqtt

WORKDIR /app

COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

CMD ["/app/run.sh"]
