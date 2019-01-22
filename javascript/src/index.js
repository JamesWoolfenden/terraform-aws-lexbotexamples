const { EXPORT, EXPORT_ALL_FROM } = require('./config/action.types');
const { BOT, INTENT } = require('./config/resource.types');
const exportAllFromBot = require('./export-allfrombot');
const exportSingle = require('./export-single');
const exportSlotFromIntent = require('./export-slotfromintent');

const actionType = process.argv[2];
const resourceType = process.argv[3];
const resourceName = process.argv[4];

(async function routine () {
  if (actionType === EXPORT_ALL_FROM &&
    resourceType === BOT) {
    await exportAllFromBot(resourceName);
    return;
  }

  if (actionType === EXPORT_ALL_FROM &&
    resourceType === INTENT) {
    await exportSlotFromIntent(resourceName);
    return;
  }

  if (actionType === EXPORT) {
    await exportSingle(resourceType, resourceName);
    return;
  }

  console.log('unknown');
})();
