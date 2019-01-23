const { red } = require('chalk');

const writeHost = require('./utils/write-host');

const getAllResource = require('./get-all');

async function isExists (resourceTypeSingle, resourceName) {
  writeHost(`check ${resourceTypeSingle} ${resourceName} exists`);

  const resourceType = `${resourceTypeSingle}s`;

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

module.exports = isExists;
