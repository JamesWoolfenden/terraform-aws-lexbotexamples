const { blue, green, red } = require('chalk');

const execute = require('./utils/execute');
const getDate = require('./utils/get-date');

const REGION = require('./config/region');

const writeHost = require('./utils/write-host');

const getAllResource = resourceType =>
  execute(`aws lex-models get-${resourceType} --region ${REGION}`);

async function getAll (resourceTypeSingle, resourceName) {
  const resourceType = `${resourceTypeSingle}s`;

  writeHost(blue(`${getDate()} Region: ${REGION}`));
  writeHost(green(`${getDate()} ${resourceType} Name: ${resourceName}`));

  try {
    writeHost(`${getDate()} Get ${resourceType}`);

    const resource = await getAllResource(resourceType).then(JSON.parse);

    return resource;
  } catch (e) {
    console.trace(e);

    writeHost(red(`${getDate()} ${resourceName} Failure`));

    process.exit(1);
  }
}

module.exports = getAll;
