FROM node
RUN npm install -g coffee-script node-dev
COPY package.json /usr/src/
RUN cd /usr/src && npm install
COPY . /usr/src/app
WORKDIR /usr/src/app
CMD npm start
