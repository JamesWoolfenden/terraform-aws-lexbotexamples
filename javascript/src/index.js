const { red } = require('chalk');

const ACTION_TYPES = require('./config/action.types');
const RESOURCE_TYPES = require('./config/resource.types');
const exportAllFromBot = require('./export-allfrombot');
const exportSingle = require('./export-single');
const exportSlotFromIntent = require('./export-slotfromintent');
const importSingle = require('./import-single');
const writeHost = require('./utils/write-host');

const actionType = process.argv[2];
const resourceType = process.argv[3];
const resourceName = process.argv[4];

const { EXPORT, EXPORT_ALL_FROM, IMPORT } = ACTION_TYPES;
const { BOT, INTENT } = RESOURCE_TYPES;

const actionList = Object.values(ACTION_TYPES);
if (!actionList.includes(actionType)) {
  writeHost(red('Unkown Action type'));
  writeHost('Acceptable values are:');
  actionList.map(value => writeHost(`- ${value}`));

  process.exit(1);
}

const resourceList = Object.values(RESOURCE_TYPES);
if (!resourceList.includes(resourceType)) {
  writeHost(red('Unkown Resource type'));
  writeHost('Acceptable values are:');
  resourceList.map(value => writeHost(`- ${value}`));

  process.exit(1);
}

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

  if (actionType === IMPORT) {
    await importSingle(resourceType, resourceName);
    return;
  }

  console.log('Unknown Command');
})();
