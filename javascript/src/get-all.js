const { blue, green, red } = require('chalk');

const REGION = require('./config/region');
const execute = require('./utils/execute');
const writeHost = require('./utils/write-host');

const getAllResource = resourceType =>
  execute(`aws lex-models get-${resourceType} --region ${REGION}`);

async function getAll (resourceTypeSingle, resourceName) {
  const resourceType = `${resourceTypeSingle}s`;

  writeHost(blue(`Region: ${REGION}`));
  writeHost(green(`${resourceType} Name: ${resourceName}`));

  try {
    writeHost(`Get ${resourceType}`);

    const resource = await getAllResource(resourceType).then(JSON.parse);

    return resource;
  } catch (e) {
    writeHost(red(`${resourceName} Failure`));

    console.trace(e);

    process.exit(1);
  }
}

module.exports = getAll;
