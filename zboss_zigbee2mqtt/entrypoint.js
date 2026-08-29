const fs = require('fs');
const path = require('path');
const { spawn } = require('child_process');

let options = {};
try {
  if (fs.existsSync('/data/options.json')) {
    options = JSON.parse(fs.readFileSync('/data/options.json', 'utf8'));
  }
} catch (e) {
  console.error('[zboss] Erro ao ler /data/options.json:', e.message);
}

const dataPath = options.data_path || process.env.ZIGBEE2MQTT_DATA || '/config/zigbee2mqtt_zboss';
process.env.ZIGBEE2MQTT_DATA = dataPath;
process.env.Z2M_DATA = dataPath;

if (!fs.existsSync(dataPath)) {
  try {
    fs.mkdirSync(dataPath, { recursive: true });
  } catch (e) {
    console.error(`[zboss] Nao foi possivel criar ${dataPath}:`, e.message);
  }
}

const configFilePath = path.join(dataPath, 'configuration.yaml');

// Se configuration.yaml nao existir no diretorio de dados, gera um padrao completo em YAML
if (!fs.existsSync(configFilePath)) {
  console.log(`[zboss_zigbee2mqtt] Criando configuration.yaml inicial em ${configFilePath}...`);
  
  const mqttServer = (options.mqtt && options.mqtt.server) || 'mqtt://core-mosquitto:1883';
  const mqttUser = (options.mqtt && options.mqtt.user) || 'wesio';
  const mqttPass = (options.mqtt && options.mqtt.password) || 'wasd';
  const mqttTopic = (options.mqtt && options.mqtt.base_topic) || 'zboss_zigbee2mqtt';
  
  const serialPort = (options.serial && options.serial.port) || '/dev/serial/by-id/usb-Espressif_USB_JTAG_serial_debug_unit_98:A3:16:BF:20:A0-if00';
  const serialAdapter = (options.serial && options.serial.adapter) || 'zboss';
  const serialBaud = (options.serial && options.serial.baudrate) || 115200;

  let yamlContent = `homeassistant: true\npermit_join: false\nmqtt:\n  base_topic: ${mqttTopic}\n  server: '${mqttServer}'\n`;
  if (mqttUser) yamlContent += `  user: '${mqttUser}'\n`;
  if (mqttPass) yamlContent += `  password: '${mqttPass}'\n`;
  
  yamlContent += `serial:\n  port: ${serialPort}\n  adapter: ${serialAdapter}\n  baudrate: ${serialBaud}\n  rtscts: false\nfrontend:\n  port: 8099\nadvanced:\n  log_level: info\n`;
  
  try {
    fs.writeFileSync(configFilePath, yamlContent, 'utf8');
    console.log('[zboss_zigbee2mqtt] configuration.yaml criado com sucesso!');
  } catch (e) {
    console.error('[zboss_zigbee2mqtt] Erro ao escrever configuration.yaml:', e.message);
  }
}

function exportConfig(obj, prefix = 'ZIGBEE2MQTT_CONFIG_') {
  for (const [key, val] of Object.entries(obj)) {
    if (key === 'data_path' || key === 'socat') continue;
    const envKey = prefix + key.toUpperCase();
    if (typeof val === 'object' && val !== null && !Array.isArray(val)) {
      exportConfig(val, `${envKey}_`);
    } else if (val !== undefined && val !== null) {
      process.env[envKey] = String(val);
    }
  }
}

exportConfig(options);

console.log(`[zboss_zigbee2mqtt] Iniciando Zigbee2MQTT em '${dataPath}'`);

const child = spawn('node', ['index.js'], {
  cwd: '/app',
  stdio: 'inherit',
  env: process.env
});

child.on('exit', (code, signal) => {
  process.exit(code || 0);
});
