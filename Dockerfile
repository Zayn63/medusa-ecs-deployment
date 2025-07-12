# Base image
FROM node:18-alpine

# Create app directory
WORKDIR /app

# Install dependencies
COPY package.json yarn.lock ./
RUN yarn install

# Copy the rest of the application code
COPY . .

# Expose Medusa backend port
EXPOSE 9000

# Start the Medusa server
CMD ["yarn", "start"]
