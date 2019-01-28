const { red } = require('chalk');

const ACTION_TYPES = require('./config/action.types');
const RESOURCE_TYPES = require('./config/resource.types');
const writeHost = require('./utils/write-host');

const deleteSingle = require('./delete-single');
const exportAllFromBot = require('./export-allfrombot');
const exportSingle = require('./export-single');
const exportSlotFromIntent = require('./export-slotfromintent');
const importSingle = require('./import-single');
const updateSingle = require('./update-single');

const {
  DELETE,
  EXPORT_ALL_FROM,
  EXPORT,
  IMPORT,
  UPDATE
} = ACTION_TYPES;
const { BOT, INTENT } = RESOURCE_TYPES;

const ERROR_UNKOWN_RESOURCE_TYPE = 'Unkown Resource type';
const ERROR_UNKOWN_COMMAND = 'Unknown Command';
const MESSAGE_ACCEPTABLE_VALUES = 'Acceptable values are:';

const actionType = process.argv[2];
const resourceType = process.argv[3];
const resourceName = process.argv[4];
const aliasName = process.argv[5];

function checkList (list, type) {
  const resourceList = Object.values(list);

  if (!resourceList.includes(type)) {
    writeHost(red(ERROR_UNKOWN_RESOURCE_TYPE));
    writeHost(MESSAGE_ACCEPTABLE_VALUES);

    resourceList.map(value =>
      writeHost(`- ${value}`)
    );

    process.exit(1);
  }
}

checkList(ACTION_TYPES, actionType);
checkList(RESOURCE_TYPES, resourceType);

(async function routine () {
  try {
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

    if (actionType === DELETE) {
      await deleteSingle(resourceType, resourceName, aliasName);

      return;
    }

    writeHost(red(ERROR_UNKOWN_COMMAND));
  } catch (e) {
    writeHost(red(`${actionType} ${resourceName} Failure`));

    console.trace(e);

    process.exit(1);
  }
})();
