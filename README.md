# cypress-browserstack

## Purpose of Repo

Supporting repo for the post at https://testingnotebook.com/run-cypress-tests-in-parallel-on-browserstack/. Please view there for the prerequisites and instructions.

### Set your Browserstack Username and Key

Install Browserstack Cypress CLI globally `npm install -g browserstack-cypress-cli`

Amend the `browserstack.json` to include your username and access key (or set as an environment variable).

## Install and Run Tests

To install dependencies run `npm install`

Run test on Cypress locally run `npm test`

Run tests on Browserstack run `npm run test:browserstack`
