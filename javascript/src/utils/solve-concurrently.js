const pAll = require('p-all');

const CONCURRENCY_LIMIT = 4;

module.exports = promiseArray => pAll(promiseArray, { CONCURRENCY_LIMIT });
