FROM node:14

WORKDIR /usr/src/app

COPY src/app/package.json ./
RUN npm install

COPY src/app ./

EXPOSE 3000

CMD ["node", "index.js"]