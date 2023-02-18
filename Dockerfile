FROM node:12.18.3-alpine as build-stage
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx:1.19.6 as nginx-stage
COPY /nginx.conf /etc/nginx/conf.d/nginx.conf
COPY --from=build-stage /app/build /www/build