# Multi Stage Builds
# Pull the specific node image
FROM node:lts-alpine AS build

# Create the working directory inside the container
WORKDIR /react-app

# Copy everything from current folder to specific workdir

COPY package.json package.json
COPY package-lock.json package-lock.json

RUN npm ci --production

COPY . .

RUN npm run build

# NGINX Web Server
FROM nginx AS prod
COPY --from=build /react-app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]