FROM node:10-alpine

RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app

ADD --chown=node:node nodejs-project /home/node/app/

WORKDIR /home/node/app

COPY nodejs-project/package*.json ./

USER node

RUN npm install

# COPY --chown=node:node nodejs-project/* .
# COPY --chown=node:node nodejs-project/views ./views
# ADD --chown=node:node nodejs-project/* .
# ADD --chown=node:node nodejs-project /home/node/app/
#ADD --chown=node:node nodejs-project ./
EXPOSE 3000

CMD [ "node", "server.js" ]
