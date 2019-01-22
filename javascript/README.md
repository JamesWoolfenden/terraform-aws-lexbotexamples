# Node Implementation

Node implementation of the lex API.

## Commands

command | option | action
--- | --- | ---
export-all-from | [bot/slot] | exports all data
export | [bot/slot/intent] | exports single

## To Run

Please use [nvm] or [nvm-windows].

```sh
# Set Node version
nvm use

# Install dependencies
npm i

# Developing with hot reload
# npm run dev -- command option resource-name
npm run dev export-all-from bot AskWilbur

# Production
npm start export-all-from bot AskWilbur

# For a full list of commands please see above
```

<!-- REFERENCES -->

[nvm]: https://github.com/creationix/nvm
[nvm-windows]: https://github.com/coreybutler/nvm-windows#node-version-manager-nvm-for-windows
