const { red } = require('chalk');

const REGION = require('./config/region');
const VERSION_FLAGS = require('./config/version-flags');
const execute = require('./utils/execute');
const writeHost = require('./utils/write-host');

const VERSION = '$LATEST';

const getSingleResource = (resourceTypeSingle, resourceName) =>
  execute(`aws lex-models get-${resourceTypeSingle} --region ${REGION} --name ${resourceName} ${VERSION_FLAGS[resourceTypeSingle]} ${VERSION}`);

async function getSingleUnfiltered (resourceTypeSingle, resourceName) {
  try {
    const singleResource = await getSingleResource(resourceTypeSingle, resourceName).then(JSON.parse);

    return singleResource;
  } catch (e) {
    writeHost(red(`${resourceName} Failure`));

    console.trace(e);

    process.exit(1);
  }
}

module.exports = getSingleUnfiltered;
