const { BOT, INTENT } = require('./config/resource.types');

const exportSlotFromIntent = require('./export-slotfromintent');
const exportSingle = require('./export-single');

const grabIntents = ({ intents }) => intents.map(({ intentName }) => intentName);

async function exportAllfromBot (botName) {
  const botIntents = await exportSingle(BOT, botName).then(grabIntents);
  const promiseArray = [];

  botIntents.forEach(botIntent => {
    promiseArray.push(exportSingle(INTENT, botIntent));
    promiseArray.push(exportSlotFromIntent(botIntent));
  });

  await Promise.all(promiseArray.filter(i => i));
}

module.exports = exportAllfromBot;
