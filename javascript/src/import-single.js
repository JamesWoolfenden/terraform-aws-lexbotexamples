const path = require('path');
const { blue, green } = require('chalk');

const OUTPUT = require('./config/output-directory');
const { BOT } = require('./config/resource.types');
const execute = require('./utils/execute');
const getDate = require('./utils/get-date');
const writeHost = require('./utils/write-host');

const REGION = require('./config/region');
const { EN_US } = require('./config/locale');

const additionalFlags = {
  [BOT]: `--locale ${EN_US} --no-child-directed`
};

const putSingleResource = (resourceTypeSingle, resourceName) => {
  const filePath = path.join(process.env.PWD, ...OUTPUT, resourceTypeSingle, `${resourceName}.json`);

  return execute(`aws lex-models put-${resourceTypeSingle} --region ${REGION} --name ${resourceName} ${additionalFlags[resourceTypeSingle] || ''} --cli-input-json file://${filePath}`);
};

async function importSingle (resourceType, resourceName) {
  writeHost(blue(`${getDate()} Region: ${REGION}`));
  writeHost(green(`${getDate()} ${resourceType} Name: ${resourceName}`));

  try {
    const data = await putSingleResource(resourceType, resourceName);

    writeHost(`${getDate()} ${resourceType} ${resourceName} imported`);

    return data;
  } catch (e) {
    console.trace(e);

    writeHost(`${getDate()} ${resourceName} Failure`);

    process.exit(1);
  }
}

module.exports = importSingle;
