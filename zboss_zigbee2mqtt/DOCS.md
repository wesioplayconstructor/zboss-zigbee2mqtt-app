# 📶 Zigbee2MQTT ZBOSS (ESP32-C6) — App Home Assistant

Este App permite executar o **Zigbee2MQTT** perfeitamente integrado ao Home Assistant OS (HAOS 2026.5+), pré-configurado e otimizado com a imagem Docker contendo o patch `zigbee-herdsman` do projeto `tostmann/esp-coordinator`.

---

## 🚀 Características & Vantagens

- **Imagem Customizada Otimizada:** Usa `ghcr.io/tostmann/zigbee2mqtt-esp32:latest`, resolvendo timeouts de inicialização na USB-CDC/JTAG do ESP32-C6.
- **Suporte Nativo ZBOSS:** Adaptador `zboss` configurado em 115200 baud.
- **Suporte Ingress & Painel Lateral:** Acesse a interface web do Zigbee2MQTT diretamente pelo menu lateral do Home Assistant!
- **Transmissão +20 dBm:** Aproveita a potência máxima de transmissão do silício do ESP32-C6.

---

## ⚙️ Configuração Padrão

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

## 🛠️ Como Adicionar o Repositório no HAOS

1. No seu Home Assistant, vá em **Configurações → Apps → App Store** (ou **Add-ons → Add-on Store**).
2. Clique nos **3 pontinhos** no canto superior direito e selecione **Repositórios**.
3. Adicione o URL:
   `https://github.com/wesioplayconstructor/zboss-zigbee2mqtt-app`
4. Clique em **Adicionar** e atualize a página.
5. O App **Zigbee2MQTT ZBOSS (ESP32-C6)** estará disponível para instalação!

---

*Desenvolvido por Deca (Programadora IoT) para o Mestre Wésio.* 👾✨
