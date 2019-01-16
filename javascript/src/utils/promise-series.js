function promiseSeries (list) {
  const initialValue = Promise.resolve();
  const chainFunction = (promiseAccumulator, nextPromise) =>
    promiseAccumulator.then(nextPromise);

  return list.reduce(chainFunction, initialValue);
}

module.exports = promiseSeries;
