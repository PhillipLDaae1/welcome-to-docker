# Start your image with a node base image
FROM node:18-alpine

# The /app directory should act as the main application directory
WORKDIR /app

# Copy the app package and package-lock.json file
COPY package*.json ./

# Install node packages
RUN npm install

# Copy local directories to the current local directory of our docker image (/app)
COPY ./src ./src
COPY ./public ./public

# Build the app
RUN npm run build

# Remove development dependencies
RUN npm prune --production

ENV NODE_ENV production

USER node

EXPOSE 3000

# Start the app using serve command
CMD [ "serve", "-s", "build" ]
