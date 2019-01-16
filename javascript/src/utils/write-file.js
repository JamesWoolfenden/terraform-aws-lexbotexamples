const path = require('path');
const write = require('write');

const ENCODING = 'utf8';
const ERROR_INVALID_FILE_PATH = 'File path must be an Array type';

const writer = (filePath, content) => {
  if (!Array.isArray(filePath)) {
    throw new TypeError(ERROR_INVALID_FILE_PATH);
  }

  const safeFilePath = path.join(...filePath);

  return write(safeFilePath, content, { encoding: ENCODING });
};

module.exports = writer;
