const { blue, green, red } = require('chalk');
const omit = require('lodash/omit');

const OMIT_DATA = require('./config/omit-data');
const REGION = require('./config/region');
const getDate = require('./utils/get-date');
const writeHost = require('./utils/write-host');

const getSingleUnfiltered = require('./get-single-unfiltered');

async function getSingle (resourceTypeSingle, resourceName) {
  const resourceType = `${resourceTypeSingle}s`;

  writeHost(blue(`${getDate()} Region: ${REGION}`));
  writeHost(green(`${getDate()} ${resourceType} Name: ${resourceName}`));

  try {
    writeHost(`${getDate()} Get ${resourceTypeSingle} details ${resourceName}`);

    const singleResource = await getSingleUnfiltered(resourceTypeSingle, resourceName);
    const filteredData = omit(singleResource, OMIT_DATA);

    return filteredData;
  } catch (e) {
    console.trace(e);

    writeHost(red(`${getDate()} ${resourceName} Failure`));

    process.exit(1);
  }
}

module.exports = getSingle;
