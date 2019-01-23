const { red } = require('chalk');

const VERSION_FLAGS = require('./config/version-flags');
const execute = require('./utils/execute');
const getDate = require('./utils/get-date');

const REGION = require('./config/region');
const VERSION = '$LATEST';

const writeHost = require('./utils/write-host');
const getSingleResource = (resourceTypeSingle, resourceName) =>
  execute(`aws lex-models get-${resourceTypeSingle} --region ${REGION} --name ${resourceName} ${VERSION_FLAGS[resourceTypeSingle]} ${VERSION}`);

async function getSingleUnfiltered (resourceTypeSingle, resourceName) {
  try {
    const singleResource = await getSingleResource(resourceTypeSingle, resourceName).then(JSON.parse);

    return singleResource;
  } catch (e) {
    console.trace(e);

    writeHost(red(`${getDate()} ${resourceName} Failure`));

    process.exit(1);
  }
}

module.exports = getSingleUnfiltered;
