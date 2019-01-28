const path = require('path');
const { blue, green } = require('chalk');

const { EN_US } = require('./config/locale');
const OUTPUT = require('./config/output-directory');
const EXTENSION = require('./config/output-extension');
const REGION = require('./config/region');
const { BOT } = require('./config/resource.types');
const execute = require('./utils/execute');
const writeHost = require('./utils/write-host');

const checkExists = require('./check-exists');

const additionalFlags = {
  [BOT]: `--locale ${EN_US} --no-child-directed`
};

const putSingleResource = (resourceTypeSingle, resourceName) => {
  const filePath = path.join(process.env.PWD, ...OUTPUT, resourceTypeSingle, `${resourceName}.${EXTENSION}`);

  return execute(`aws lex-models put-${resourceTypeSingle} --region ${REGION} --name ${resourceName} ${additionalFlags[resourceTypeSingle] || ''} --cli-input-json file://${filePath}`);
};

async function importSingle (resourceType, resourceName) {
  writeHost(blue(`Region: ${REGION}`));
  writeHost(green(`${resourceType} Name: ${resourceName}`));

  try {
    await checkExists(resourceType, resourceName);
    const data = await putSingleResource(resourceType, resourceName);

    writeHost(`${resourceType} ${resourceName} imported`);

    return data;
  } catch (e) {
    writeHost(`${resourceName} Failure`);

    console.trace(e);

    process.exit(1);
  }
}

module.exports = importSingle;
