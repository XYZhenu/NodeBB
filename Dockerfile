# The base image is the latest 8.x node (LTS)
FROM node:8.15.1@sha256:fec2d6c325686988c4e0bf1b17cd32954422333d24ed6a97c28c8570054a6e1d

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ARG NODE_ENV
ENV NODE_ENV $NODE_ENV
COPY install/package.json /usr/src/app/package.json
RUN npm install && npm cache clean --force
COPY . /usr/src/app

ENV NODE_ENV=production \
    daemon=false \
    silent=false

CMD ./nodebb start

# the default port for NodeBB is exposed outside the container
EXPOSE 4567