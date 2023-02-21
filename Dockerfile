FROM node:16.19.0-alpine as build-stage
WORKDIR /app
COPY package.json .
COPY yarn.lock .
RUN yarn
COPY . .
RUN yarn build

FROM nginx:1.19.6 as nginx-stage
COPY /nginx.conf /etc/nginx/conf.d/nginx.conf
COPY --from=build-stage /app/dist /usr/share/nginx/html