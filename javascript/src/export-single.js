const getSingle = require('./get-single');
const getDate = require('./utils/get-date');
const writeFile = require('./utils/write-file');

const writeHost = require('./utils/write-host');

async function getResource (resourceTypeSingle, resourceName) {
  try {
    const data = await getSingle(resourceTypeSingle, resourceName);

    await writeFile(['output', resourceTypeSingle, `${resourceName}.json`], data);

    writeHost(`${getDate()} ${resourceName} exported`);

    return data;
  } catch (e) {
    console.trace(e);

    writeHost(`${getDate()} ${resourceName} Failure`);

    process.exit(1);
  }
}

module.exports = getResource;
