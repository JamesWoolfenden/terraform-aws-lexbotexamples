const omit = require('lodash/omit');
const { blue, green, red } = require('chalk');

const OMIT_DATA = require('./config/omit-data');
const VERSION_FLAGS = require('./config/version-flags');
const execute = require('./utils/execute');
const getDate = require('./utils/get-date');

const REGION = 'eu-west-1';
const VERSION = '$LATEST';

const writeHost = require('./utils/write-host');
const getSingleResource = (resourceTypeSingle, resourceName) =>
  execute(`aws lex-models get-${resourceTypeSingle} --region ${REGION} --name ${resourceName} ${VERSION_FLAGS[resourceTypeSingle]} ${VERSION}`);

async function getSingle (resourceTypeSingle, resourceName, write = true) {
  const resourceType = `${resourceTypeSingle}s`;

  writeHost(blue(`${getDate()} Region: ${REGION}`));
  writeHost(green(`${getDate()} ${resourceType} Name: ${resourceName}`));

  try {
    writeHost(`${getDate()} Get ${resourceTypeSingle} details ${resourceName}`);

    const singleResource = await getSingleResource(resourceTypeSingle, resourceName).then(JSON.parse);

    const filteredData = omit(singleResource, OMIT_DATA);

    return filteredData;
  } catch (e) {
    console.trace(e);

    writeHost(red(`${getDate()} ${resourceName} Failure`));

    process.exit(1);
  }
}

module.exports = getSingle;
