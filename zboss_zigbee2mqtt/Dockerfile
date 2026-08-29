FROM ghcr.io/tostmann/zigbee2mqtt-esp32:latest

WORKDIR /app

COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

CMD ["/app/run.sh"]
