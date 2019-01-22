const execa = require('execa');

module.exports = async execString => {
  const splitExecCommand = execString.split(/ +/);

  const command = splitExecCommand[0];
  const flags = splitExecCommand.slice(1);
  // console.log(execString);
  try {
    const { stdout } = await execa(command, flags);
    return stdout;
  } catch (error) {
    throw new Error(error);
  }
};
