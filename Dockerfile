# built on node
FROM node:16 as build
# create a temp folder when you make my image (and cd into it)
WORKDIR /places-app
# copy from local and move into above
COPY package*.json ./
# use package.json and do npm i
RUN npm install
# copy everything else into that dir
COPY . ./
# creates build folder and puts build output in it
RUN npm run build
# Spin up backend server to run app on
FROM nginx:1.25.4

COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
# copy build dir output and put it in nginx
COPY --from=build /places-app/build /usr/share/nginx/html