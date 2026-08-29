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

const dataPath = options.data_path || process.env.ZIGBEE2MQTT_DATA || '/config/zigbee2mqtt';
process.env.ZIGBEE2MQTT_DATA = dataPath;
process.env.Z2M_DATA = dataPath;

if (!fs.existsSync(dataPath)) {
  try {
    fs.mkdirSync(dataPath, { recursive: true });
  } catch (e) {
    console.error(`[zboss] Nao foi possivel criar o diretorio ${dataPath}:`, e.message);
  }
}

// Configura porta padrao do frontend para Ingress do HA se nao definida
if (!options.frontend) {
  process.env.ZIGBEE2MQTT_CONFIG_FRONTEND_ENABLED = 'true';
  process.env.ZIGBEE2MQTT_CONFIG_FRONTEND_PORT = '8099';
}

// Converte a arvore de opcoes do HA em variaveis ZIGBEE2MQTT_CONFIG_*
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

console.log(`[zboss_zigbee2mqtt] Inspecionando data_path: '${dataPath}'`);

// Executa o ponto de entrada principal do Zigbee2MQTT
const child = spawn('node', ['index.js'], {
  cwd: '/app',
  stdio: 'inherit',
  env: process.env
});

child.on('exit', (code, signal) => {
  process.exit(code || 0);
});
