#!/usr/bin/env bashio

bashio::log.info "Iniciando Zigbee2MQTT ZBOSS (ESP32-C6)..."

# Define data_path a partir da opção ou usa padrão limpo
if bashio::config.has_value 'data_path'; then
    export ZIGBEE2MQTT_DATA="$(bashio::config 'data_path')"
else
    export ZIGBEE2MQTT_DATA="/config/zigbee2mqtt_zboss"
fi

mkdir -p "$ZIGBEE2MQTT_DATA"
bashio::log.info "Diretório de dados: ${ZIGBEE2MQTT_DATA}"

# Variáveis globais do Node e Ingress do HA
export NODE_PATH=/app/node_modules
export ZIGBEE2MQTT_CONFIG_FRONTEND_ENABLED='true'
export ZIGBEE2MQTT_CONFIG_FRONTEND_PORT='8099'
export ZIGBEE2MQTT_CONFIG_HOMEASSISTANT_ENABLED='true'

# Exporta subchaves do options.json para variáveis ZIGBEE2MQTT_CONFIG_*
function export_config() {
    local key=${1}
    local subkey
    if bashio::config.is_empty "${key}"; then
        return
    fi
    for subkey in $(bashio::jq "$(bashio::config "${key}")" 'keys[]'); do
        export "ZIGBEE2MQTT_CONFIG_$(bashio::string.upper "${key}")_$(bashio::string.upper "${subkey}")=$(bashio::config "${key}.${subkey}")"
    done
}

export_config 'mqtt'
export_config 'serial'

# Garante que o adapter padrão seja zboss se não especificado
if ! bashio::config.has_value 'serial.adapter'; then
    export ZIGBEE2MQTT_CONFIG_SERIAL_ADAPTER="zboss"
fi

# Auto-descoberta de credenciais do Mosquitto Broker via API do HA Supervisor
if (bashio::config.is_empty 'mqtt' || ! (bashio::config.has_value 'mqtt.server' || bashio::config.has_value 'mqtt.user' || bashio::config.has_value 'mqtt.password')) && bashio::var.has_value "$(bashio::services 'mqtt')"; then
    bashio::log.info "Configurando conexao MQTT automatica via Home Assistant Mosquitto..."
    if bashio::var.true "$(bashio::services 'mqtt' 'ssl')"; then
        export ZIGBEE2MQTT_CONFIG_MQTT_SERVER="mqtts://$(bashio::services 'mqtt' 'host'):$(bashio::services 'mqtt' 'port')"
    else
        export ZIGBEE2MQTT_CONFIG_MQTT_SERVER="mqtt://$(bashio::services 'mqtt' 'host'):$(bashio::services 'mqtt' 'port')"
    fi
    export ZIGBEE2MQTT_CONFIG_MQTT_USER="$(bashio::services 'mqtt' 'username')"
    export ZIGBEE2MQTT_CONFIG_MQTT_PASSWORD="$(bashio::services 'mqtt' 'password')"
fi

cd /app
exec node index.js
