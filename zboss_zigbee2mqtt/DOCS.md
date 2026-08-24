# 📶 Zigbee2MQTT ZBOSS (ESP32-C6) — App Home Assistant

Este App permite executar o **Zigbee2MQTT** perfeitamente integrado ao Home Assistant OS (HAOS), pré-configurado e otimizado com a imagem Docker contendo o patch `zigbee-herdsman` do projeto `tostmann/esp-coordinator`.

---

## 🚀 Características

- **Patch ZBOSS Otimizado:** Usa `ghcr.io/tostmann/zigbee2mqtt-esp32:latest`, eliminando timeouts de inicialização na USB-CDC/JTAG do ESP32-C6.
- **Suporte Nativo UART/USB:** `uart: true` ativado para acesso total às portas seriais.
- **Ingress Integrado:** Acesso direto à Web UI do Zigbee2MQTT no menu lateral do Home Assistant.
- **Potência +20 dBm:** Rádio 2.4 GHz em potência máxima no ESP32-C6.

---

## ⚙️ Opções de Configuração

```yaml
homeassistant: true
permit_join: true
mqtt:
  server: mqtt://core-mosquitto:1883
  user: wesio
  password: wasd
serial:
  port: /dev/serial/by-id/usb-Espressif_USB_JTAG_serial_debug_unit_98:A3:16:BF:20:A0-if00
  adapter: zboss
  baudrate: 115200
```

---

*Desenvolvido por Deca (Programadora IoT) para o Mestre Wésio.* 👾✨
