const { BOT, SLOT_TYPE, INTENT } = require('./resource.types');

module.exports = {
  [BOT]: '--version-or-alias',
  [INTENT]: '--intent-version',
  [SLOT_TYPE]: '--slot-type-version'
};
