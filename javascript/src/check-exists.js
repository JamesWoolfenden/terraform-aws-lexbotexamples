const { red } = require('chalk');

const writeHost = require('./utils/write-host');

const getAllResource = require('./get-all');

async function checkExists (resourceTypeSingle, resourceName) {
  const resourceType = `${resourceTypeSingle}s`;
  writeHost(`check ${resourceTypeSingle} ${resourceName} exists`);

  try {
    const singleResource = await getAllResource(resourceTypeSingle, resourceName);
    const isExisting = singleResource[resourceType].some(({ name }) => name === resourceName);

    if (isExisting) {
      return isExisting;
    }

    throw new Error();
  } catch (e) {
    writeHost(red(`${resourceName} does not exist`));

    console.trace(e);

    process.exit(1);
  }
}

module.exports = checkExists;
