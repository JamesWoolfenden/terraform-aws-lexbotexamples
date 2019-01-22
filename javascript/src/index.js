const exportSingle = require('./export-single');
const exportSlotFromIntent = require('./export-slotfromintent');
const exportAllFromBot = require('./export-allfrombot');

const actionType = process.argv[2];
const resourceType = process.argv[3];
const resourceName = process.argv[4];

(async function routine () {
  if (actionType === 'export-all-from' && resourceType === 'bot') {
    await exportAllFromBot(resourceName);
    return;
  }

  if (actionType === 'export-all-from' && resourceType === 'intent') {
    await exportSlotFromIntent(resourceName);
    return;
  }

  if (actionType === 'export') {
    await exportSingle(resourceType, resourceName);
    return;
  }

  console.log('unknown');
})();
