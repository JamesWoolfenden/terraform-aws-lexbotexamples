module.exports = {
  REGION: 'eu-west-1',
  OUTPUT_DIR: 'output',
  OUTPUT_EXTENSION: 'json',
  VERSION: '$LATEST',
  OMIT_DATA: [
    'version',
    'status',
    'lastUpdatedDate',
    'createdDate',
    'checksum'
  ]
};
