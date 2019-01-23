const { blue, green, red } = require('chalk');
const omit = require('lodash/omit');

const OMIT_DATA = require('./config/omit-data');
const REGION = require('./config/region');
const writeHost = require('./utils/write-host');

const getSingleUnfiltered = require('./get-single-unfiltered');
const checkExists = require('./check-exists');

async function getSingle (resourceTypeSingle, resourceName) {
  const resourceType = `${resourceTypeSingle}s`;

  writeHost(blue(`Region: ${REGION}`));
  writeHost(green(`${resourceType} Name: ${resourceName}`));

  try {
    await checkExists(resourceTypeSingle, resourceName);

    writeHost(`Get ${resourceTypeSingle} details ${resourceName}`);

    const singleResource = await getSingleUnfiltered(resourceTypeSingle, resourceName);
    const filteredData = omit(singleResource, OMIT_DATA);

    return filteredData;
  } catch (e) {
    writeHost(red(`${resourceName} Failure`));

    console.trace(e);

    process.exit(1);
  }
}

module.exports = getSingle;
