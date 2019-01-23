const { blue, green } = require('chalk');

const REGION = require('./config/region');
const {
  BOT,
  INTENT,
  SLOT_TYPE
} = require('./config/resource.types');
const execute = require('./utils/execute');
const getDate = require('./utils/get-date');
const writeHost = require('./utils/write-host');

const additionalFlags = {
  [BOT]: `--region ${REGION}`,
  [INTENT]: `--region ${REGION}`,
  [SLOT_TYPE]: `--region ${REGION}`
};

const deleteSingleResource = (resourceTypeSingle, resourceName, aliasName) => {
  let nameFlags = `--name ${resourceName}`;

  if (aliasName) {
    nameFlags = `--name ${aliasName} --bot-name ${resourceName}`;
  }

  return execute(`aws lex-models delete-${resourceTypeSingle} ${nameFlags} ${additionalFlags[resourceTypeSingle] || ''}`);
};

async function deleteSingle (resourceType, resourceName, aliasName) {
  writeHost(blue(`${getDate()} Region: ${REGION}`));
  writeHost(green(`${getDate()} ${resourceType} Name: ${resourceName}`));

  try {
    const data = await deleteSingleResource(resourceType, resourceName, aliasName);

    writeHost(`${getDate()} ${resourceType} ${resourceName} deleted`);

    return data;
  } catch (e) {
    console.trace(e);

    writeHost(`${getDate()} ${resourceName} Failure`);

    process.exit(1);
  }
}

module.exports = deleteSingle;
