// Mocha is configured here so that npm scripts and IDEs can both use the configuration. For more information, see:
// https://mochajs.org/#configuring-mocha-nodejs

// Type checking is not necessary for tests
process.env.TS_NODE_TRANSPILE_ONLY = true;

module.exports = {
    exit: true,
    require: [
        // Required to execute TypeScript files
        'ts-node/register',
        // Required to register paths that are configured in tsconfig.js (e.g. `@backend`)
        'tsconfig-paths/register',
    ],
};
