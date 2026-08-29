FROM ghcr.io/tostmann/zigbee2mqtt-esp32:latest

WORKDIR /app

COPY run.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/sbin/tini", "--", "/entrypoint.sh"]
