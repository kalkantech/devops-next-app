FROM node:18-alpine

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install

COPY next.config.js ./next.config.js
COPY jsconfig.json ./jsconfig.json

ENV NODE_ENV development

COPY src ./src
COPY public ./public

CMD ["npm", "run", "dev"]