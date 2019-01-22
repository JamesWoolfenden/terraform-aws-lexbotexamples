const exportSingle = require('./export-single');
const exportSlotFromIntent = require('./export-slotfromintent');

const grabIntents = ({ intents }) => intents.map(({ intentName }) => intentName);

async function exportAllfromBot (botName) {
  const botIntents = await exportSingle('bot', botName).then(grabIntents);

  const promiseArray = [];

  botIntents.forEach(intent => {
    promiseArray.push(exportSingle('intent', intent));
    promiseArray.push(exportSlotFromIntent(intent));
  });

  await Promise.all(promiseArray.filter(i => i));
}

module.exports = exportAllfromBot;
