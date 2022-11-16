# TS Boilerplate

This project is a boilerplate for a regular TypeScript project.
It has no server/frontend components built-in, that's up to you to include.

It includes the following:

- [TypeScript](https://www.typescriptlang.org/)
- [SWC](https://swc.rs/)
- [Mocha](https://mochajs.org/)
- [Chai](https://www.chaijs.com/)
- Dockerfile for building the project (makefile included)
- ESLint, Prettier
- Nodemon for development
- RelativeDeps for local development
- NodeJS 20
- Githib Actions for CI

## Getting started

If your setup only involves TypeScript, you can just clone this repo and start working after running `npm install`.
If you do want additional components, like Postgres, you can use the docker-compose file to get started, in case you want postgres, uncomment the lines about Postgres.
You can also setup additional services like Redis, RabbitMQ, etc.

## Using the normal dockerfile

You can use the MakeFile to build the docker image and run it. You can also use the MakeFile to run the tests or get console access to the container.
Check the MakeFile for more information.

## Github Actions

A basic setup for deploying a docker image to a registry is included. You can use this to deploy to a registry of your choice, for now it uses dockerhub
