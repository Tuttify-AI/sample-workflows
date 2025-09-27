# use Node 14 base
FROM node:14

# create app directory
WORKDIR /usr/src/app

# copy package files first to leverage Docker layer cache
COPY src/app/package*.json ./

# install deps
RUN npm install --production

# copy application source
COPY src/app/ ./

# expose port and default start
EXPOSE 3000
CMD ["node", "index.js"]