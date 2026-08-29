# 📶 Zigbee2MQTT ZBOSS (ESP32-C6 / ESP32-H2) — Home Assistant Add-on

Este repositório é um clone 1:1 do Add-on oficial do **Zigbee2MQTT** (`zigbee2mqtt/hassio-zigbee2mqtt`), porém compilado com a imagem Docker que inclui o suporte nativo ao rádio **ZBOSS NCP** para os chips **ESP32-C6** e **ESP32-H2** (`tostmann/esp-coordinator`).

---

## 🚀 Recursos

- **1:1 com o Add-on Oficial:** Mantém exatamente a mesma estrutura, esquemas de opção, ingress, socat e auto-descoberta MQTT do Zigbee2MQTT oficial.
- **Suporte ZBOSS Nativo:** Utiliza `ghcr.io/tostmann/zigbee2mqtt-esp32:latest`.
- **Integrado ao Home Assistant:** Ingress nativo e integração automática com o add-on Mosquitto Broker.

---

## ⚙️ Instalação

1. Adicione o repositório no Home Assistant (**Configurações → Add-ons → Loja de Add-ons → Repositórios**):
   `https://github.com/wesioplayconstructor/zboss-zigbee2mqtt-app`
2. Instale o **Zigbee2MQTT ZBOSS (ESP32-C6)**.
3. Configure a sua porta serial (`serial.port`) e o adapter `zboss` na aba de Configuração.
4. Inicie o add-on.
