const OUTPUT = require('./config/output-directory');
const EXTENSION = require('./config/output-extension');
const writeFile = require('./utils/write-file');
const writeHost = require('./utils/write-host');

const getSingle = require('./get-single');

async function getResource (resourceTypeSingle, resourceName) {
  try {
    const data = await getSingle(resourceTypeSingle, resourceName);

    await writeFile([...OUTPUT, resourceTypeSingle, `${resourceName}.${EXTENSION}`], data);

    writeHost(`${resourceName} exported`);

    return data;
  } catch (e) {
    writeHost(`${resourceName} Failure`);

    console.trace(e);

    process.exit(1);
  }
}

module.exports = getResource;
