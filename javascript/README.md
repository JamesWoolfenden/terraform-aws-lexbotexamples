# Node Implementation

[![JavaScript Style Guide](https://cdn.rawgit.com/standard/standard/master/badge.svg)](https://github.com/standard/standard)

---

Node implementation of the lex API.

## To Run

Please use [nvm] or [nvm-windows] when developing or running locally.

## Actions and Resource Types

- [list of Actions]
- [list of Resource Types]

```sh
# Set Node version
nvm use

# Install dependencies
npm i

# Developing with hot reload
#   npm run dev <action> <resource-type> <resource-name> [<bot-alias>]
npm run dev export-all-from bot MyBotProd

# Production
#   npm start <action> <resource-type> <resource-name> [<bot-alias>]
npm start export-all-from bot MyBotProd

# For a full list of actions please see above
```

<!-- REFERENCES -->

[list of Actions]: ./src/config/action.types.js
[list of Resource Types]: ./src/config/resource.types.js
[nvm]: https://github.com/creationix/nvm
[nvm-windows]: https://github.com/coreybutler/nvm-windows#node-version-manager-nvm-for-windows
