ARG NODE_VERSION=20.14.0

FROM node:${NODE_VERSION}-slim as base
WORKDIR /app

ENV NODE_ENV=development

COPY . .
RUN npm install

CMD [ "npm", "run", "dev" ]
