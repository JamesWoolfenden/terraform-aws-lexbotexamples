const getDate = require('./get-date');

module.exports = function () {
  console.log(getDate(), ...arguments);
};
