const path = require('path');
const { blue, green } = require('chalk');

const OUTPUT = require('./config/output-directory');
const EXTENSION = require('./config/output-extension');
const { BOT } = require('./config/resource.types');
const execute = require('./utils/execute');
const getDate = require('./utils/get-date');
const writeHost = require('./utils/write-host');
const getSingleUnfiltered = require('./get-single-unfiltered');

const REGION = require('./config/region');
const { EN_US } = require('./config/locale');

const additionalFlags = {
  [BOT]: `--locale ${EN_US} --no-child-directed`
};

const putSingleResource = (resourceTypeSingle, resourceName, resourceChecksum) => {
  const filePath = path.join(process.env.PWD, ...OUTPUT, resourceTypeSingle, `${resourceName}.${EXTENSION}`);

  return execute(`aws lex-models put-${resourceTypeSingle} --region ${REGION} --name ${resourceName} --checksum ${resourceChecksum} ${additionalFlags[resourceTypeSingle] || ''} --cli-input-json file://${filePath}`);
};

async function importSingle (resourceType, resourceName) {
  writeHost(blue(`${getDate()} Region: ${REGION}`));
  writeHost(green(`${getDate()} ${resourceType} Name: ${resourceName}`));

  try {
    const { checksum } = await getSingleUnfiltered(resourceType, resourceName);
    const data = await putSingleResource(resourceType, resourceName, checksum);

    writeHost(`${getDate()} ${resourceType} ${resourceName} updated`);

    return data;
  } catch (e) {
    console.trace(e);

    writeHost(`${getDate()} ${resourceName} Failure`);

    process.exit(1);
  }
}

module.exports = importSingle;
