# build phase start
FROM node:alpine as builder

WORKDIR '/usr/app'

COPY package.json .

RUN npm install

COPY . .

RUN ["npm", "run", "build"]

# build phase: end

# start ngix - run phase
FROM nginx

# /usr/share/nginx/html -- this is nginx config; place any static content here and nginx will take care 
COPY --from=builder /usr/app/build /usr/share/nginx/html

# don't need to perform anything else to kick start nginx server, everything will be taken into account

# Note - nginx default port - 80; meaning all the static content is hosted on port 80 inside the container; will have to map the outside world port to this one, something like -p 8080:80 while kickstarting the container