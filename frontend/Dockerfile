FROM node:20.8.1 AS build

WORKDIR /app/frontend

COPY frontend/yarn.lock frontend/package.json ./
RUN yarn install

COPY frontend ./

EXPOSE 3000

CMD ["yarn", "start"]