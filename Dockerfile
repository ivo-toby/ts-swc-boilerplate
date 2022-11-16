# BASE

FROM node:20-alpine3.17 AS base

RUN addgroup -g 1001 -S node-user && \
  adduser -u 1001 -S node-user -G node-user

# DEV-BASE

FROM base AS dev-base

RUN apk add --update --no-cache openssh build-base python3 bash git

#TEST-BASE

FROM dev-base as test-base

USER node-user

ARG NPM_TOKEN
RUN echo '//registry.npmjs.org/:_authToken=${NPM_TOKEN}' >> ~/.npmrc

ENV NODE_ENV development

COPY --chown=node-user:node-user package.json package-lock.json tsconfig.json .swcrc /app/

WORKDIR /app

ARG SSH_KEY
RUN mkdir -p ~/.ssh && chmod 0700 ~/.ssh && \
  ssh-keyscan github.com > ~/.ssh/known_hosts && \
  echo "$SSH_KEY" >~/.ssh/id_rsa && \
  chmod 0600 ~/.ssh/id_rsa && \
  npm ci && \
  rm -f ~/.ssh/id_rsa

COPY --chown=node-user:node-user src /app/src
COPY --chown=node-user:node-user test /app/test


#DEV-BUILT

FROM test-base as dev-built

ARG NPM_TOKEN

WORKDIR /app

ENV NODE_ENV development
RUN npm run build


# pre-built

FROM test-base as ts-swc-pre-built

ARG NPM_TOKEN

WORKDIR /app

ENV NODE_ENV production
RUN npm run build
RUN npm prune --production

#BUILD

FROM base as ts-swc-built

USER node-user

ENV NODE_ENV production

COPY --chown=node-user:node-user --from=ts-swc-pre-built /app/package.json /app/
COPY --chown=node-user:node-user --from=ts-swc-pre-built /app/build /app/build/
COPY --chown=node-user:node-user --from=ts-swc-pre-built /app/node_modules /app/node_modules/

WORKDIR /app

