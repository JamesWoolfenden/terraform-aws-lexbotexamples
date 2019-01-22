const execute = require('./utils/execute');
const getDate = require('./utils/get-date');
const omit = require('lodash/omit');
const { blue, green, red } = require('chalk');

const REGION = 'eu-west-1';
const VERSION = '$LATEST';

const OMIT_DATA = [
  'version',
  'status',
  'lastUpdatedDate',
  'createdDate',
  'checksum'
];

const versionConfig = {
  bot: '--version-or-alias',
  intent: '--intent-version',
  'slot-type': '--slot-type-version'
};

const writeHost = console.log;
const getSingleResource = (resourceTypeSingle, resourceName) => execute(`aws lex-models get-${resourceTypeSingle} --region ${REGION} --name ${resourceName} ${versionConfig[resourceTypeSingle]} ${VERSION}`);

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
