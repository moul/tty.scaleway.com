FROM node:0.10-onbuild
RUN make build
RUN npm install -g coffee-script node-dev
