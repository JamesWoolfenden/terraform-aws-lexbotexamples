const { red } = require('chalk');

const ACTION_TYPES = require('./config/action.types');
const RESOURCE_TYPES = require('./config/resource.types');
const exportAllFromBot = require('./export-allfrombot');
const exportSingle = require('./export-single');
const exportSlotFromIntent = require('./export-slotfromintent');
const importSingle = require('./import-single');
const updateSingle = require('./update-single');
const writeHost = require('./utils/write-host');

const { EXPORT, EXPORT_ALL_FROM, IMPORT, UPDATE } = ACTION_TYPES;
const { BOT, INTENT } = RESOURCE_TYPES;

const ERROR_UNKOWN_RESOURCE_TYPE = 'Unkown Resource type';
const ERROR_UNKOWN_COMMAND = 'Unknown Command';
const MESSAGE_ACCEPTABLE_VALUES = 'Acceptable values are:';

const actionType = process.argv[2];
const resourceType = process.argv[3];
const resourceName = process.argv[4];

function checkList (list, type) {
  const resourceList = Object.values(list);

  if (!resourceList.includes(type)) {
    writeHost(red(ERROR_UNKOWN_RESOURCE_TYPE));
    writeHost(MESSAGE_ACCEPTABLE_VALUES);
    resourceList.map(value => writeHost(`- ${value}`));

    process.exit(1);
  }
}

checkList(ACTION_TYPES, actionType);
checkList(RESOURCE_TYPES, resourceType);

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

  if (actionType === UPDATE) {
    await updateSingle(resourceType, resourceName);

    return;
  }

  writeHost(red(ERROR_UNKOWN_COMMAND));
})();
