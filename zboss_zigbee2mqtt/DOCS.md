# 📶 Zigbee2MQTT ZBOSS (ESP32-C6 / ESP32-H2) — Home Assistant Add-on

Este Add-on permite executar o **Zigbee2MQTT** perfeitamente integrado ao **Home Assistant OS (HAOS)** com suporte nativo aos microcontroladores **ESP32-C6** e **ESP32-H2** rodando o firmware ZBOSS NCP.

---

## 🚀 Recursos

- **Suporte Nativo ZBOSS:** Pré-configurado com a imagem otimizada (`tostmann/esp-coordinator`) contendo os patches necessários no `zigbee-herdsman`.
- **Seleção Automática de Porta Serial:** Suporte ao seletor visual de portas USB do Home Assistant (`device(subsystem=tty)`).
- **Auto-descoberta MQTT:** Integração automática com o add-on Mosquitto Broker oficial via API do HA Supervisor.
- **Painel Ingress:** Acesso direto à Web UI do Zigbee2MQTT no menu lateral do Home Assistant.
- **Isolamento de Dados:** Por padrão, salva em `/config/zigbee2mqtt_zboss`, permitindo rodar em paralelo com o ZHA ou com o Zigbee2MQTT oficial sem conflitos.

---

## ⚙️ Instalação e Configuração

1. **Adicionar o Repositório:**
   - No Home Assistant, vá em **Configurações** → **Add-ons** → **Loja de Add-ons**.
   - No menu (3 pontinhos no canto superior direito), selecione **Repositórios**.
   - Adicione a URL: `https://github.com/wesioplayconstructor/zboss-zigbee2mqtt-app`

2. **Instalar o Add-on:**
   - Procure por **Zigbee2MQTT ZBOSS (ESP32-C6)** na loja e clique em **Instalar**.

3. **Configurar a Porta Serial:**
   - Na aba **Configuração** do Add-on, escolha seu dispositivo ESP32-C6/H2 no campo **serial.port**.
   - O adaptador já vem pré-selecionado como `zboss`.

4. **Iniciar:**
   - Clique em **Iniciar** e ative a opção **Mostrar na barra lateral** (Ingress).

---

## 🔧 Exemplo de Configuração (Aba Opções / YAML)

```yaml
data_path: /config/zigbee2mqtt_zboss
mqtt:
  base_topic: zboss_zigbee2mqtt
serial:
  port: /dev/serial/by-id/usb-Espressif_USB_JTAG_serial_debug_unit_98:A3:16:BF:20:A0-if00
  adapter: zboss
  baudrate: 115200
```

---

## 💡 Notas de Compatibilidade

- **Firmware recomendado no ESP32-C6:** `tostmann/esp-coordinator` ou `andryblack/esp-coordinator`.
- **Velocidade Serial:** 115200 baudrate.
- **Controle de Fluxo:** Desativado (`rtscts: false`).
