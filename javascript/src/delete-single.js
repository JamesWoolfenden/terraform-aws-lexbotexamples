const { blue, green } = require('chalk');

const REGION = require('./config/region');
const {
  BOT,
  INTENT,
  SLOT_TYPE
} = require('./config/resource.types');
const execute = require('./utils/execute');
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
  writeHost(blue(`Region: ${REGION}`));
  writeHost(green(`${resourceType} Name: ${resourceName}`));

  try {
    const data = await deleteSingleResource(resourceType, resourceName, aliasName);

    writeHost(`${resourceType} ${resourceName} deleted`);

    return data;
  } catch (e) {
    writeHost(`${resourceName} Failure`);

    console.trace(e);

    process.exit(1);
  }
}

module.exports = deleteSingle;
