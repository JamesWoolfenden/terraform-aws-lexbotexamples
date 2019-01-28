const path = require('path');
const { blue, green } = require('chalk');

const REGION = require('./config/region');
const { EN_US } = require('./config/locale');
const OUTPUT = require('./config/output-directory');
const EXTENSION = require('./config/output-extension');
const { BOT } = require('./config/resource.types');
const execute = require('./utils/execute');
const writeHost = require('./utils/write-host');

const getSingleUnfiltered = require('./get-single-unfiltered');
const checkExists = require('./check-exists');

const additionalFlags = {
  [BOT]: `--locale ${EN_US} --no-child-directed`
};

const putSingleResource = (resourceTypeSingle, resourceName, resourceChecksum) => {
  const filePath = path.join(process.env.PWD, ...OUTPUT, resourceTypeSingle, `${resourceName}.${EXTENSION}`);

  return execute(`aws lex-models put-${resourceTypeSingle} --region ${REGION} --name ${resourceName} --checksum ${resourceChecksum} ${additionalFlags[resourceTypeSingle] || ''} --cli-input-json file://${filePath}`);
};

async function updateSingle (resourceType, resourceName) {
  writeHost(blue(`Region: ${REGION}`));
  writeHost(green(`${resourceType} Name: ${resourceName}`));

  try {
    await checkExists(resourceType, resourceName);

    const { checksum } = await getSingleUnfiltered(resourceType, resourceName);
    const data = await putSingleResource(resourceType, resourceName, checksum);

    writeHost(`${resourceType} ${resourceName} updated`);

    return data;
  } catch (e) {
    writeHost(`${resourceName} Failure`);

    console.trace(e);

    process.exit(1);
  }
}

module.exports = updateSingle;
