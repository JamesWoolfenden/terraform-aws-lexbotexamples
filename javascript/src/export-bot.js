const execa = require('execa');
const { green, blue, red } = require('chalk');
const omit = require('lodash/omit');
const kebabCase = require('lodash/kebabCase');
const stringify = require('json-stringify-pretty-compact');

const {
  OUTPUT_DIR,
  OUTPUT_EXTENSION,
  REGION,
  VERSION
} = require('../config');

const promiseSeries = require('./utils/promise-series');
const writeFile = require('./utils/write-file');

const now = () => `[${new Date().toLocaleString()}] -`;

const OUTPUT_PREFIX = 'bot--';
const OMIT_DATA = [
  'version',
  'status',
  'lastUpdatedDate',
  'createdDate',
  'checksum'
];

const STATUS_EXPORT_SUCCESS = 'successfully exported';
const STATUS_GET_DETAILS = 'get details';
const STATUS_NO_RESOURCE_SPECIFIED = 'no resource argument specified';
const STATUS_NOT_FOUND = 'could not get details of';

const stampMessage = rawMessage => {
  let message = rawMessage;

  if (Array.isArray(rawMessage)) {
    message = rawMessage.join(' ');
  }

  return `${now()} ${message}`;
};

const initializeLog = resourceName => {
  console.log(
    green(`${now()} Region: ${blue.bold(REGION)}`)
  );
  console.log(
    green(`${now()} Bot Name: ${blue.bold(resourceName)}`)
  );
};

const getSingleResource = async resourceName => {
  if (!resourceName) {
    throw new Error(
      stampMessage(STATUS_NO_RESOURCE_SPECIFIED)
    );
  }

  try {
    console.log(
      stampMessage([STATUS_GET_DETAILS, resourceName])
    );

    const { stdout } = await execa('aws', [
      'lex-models', 'get-bot',
      '--name', resourceName,
      '--region', REGION,
      '--version-or-alias', VERSION
    ]);

    return stdout;
  } catch (e) {
    throw new Error(
      stampMessage([STATUS_NOT_FOUND, resourceName])
    );
  }
};

const filterData =
  (data, filter = OMIT_DATA) => omit(data, filter);

const writeData = data => {
  const { name } = data;
  const content = stringify(data);

  const kebabName = kebabCase(name);
  const fileName = [
    OUTPUT_DIR,
    `${OUTPUT_PREFIX}${kebabName}.${OUTPUT_EXTENSION}`
  ];

  writeFile(fileName, content);

  console.log(
    stampMessage([STATUS_EXPORT_SUCCESS, name])
  );

  return data;
};

const error = e => console.log(red(e));

module.exports = resourceName => {
  const procedure = [
    () => initializeLog(resourceName),
    () => getSingleResource(resourceName),
    JSON.parse,
    filterData,
    writeData
  ];

  promiseSeries(procedure).catch(error);
};
