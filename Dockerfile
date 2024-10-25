# Use an official Node.js runtime as a base image
FROM node:14
# Set the working directory
WORKDIR /usr/src/app
# Copy package.json and package-lock.json
COPY package*.json ./
# Install dependencies
RUN npm install
# Copy the entire project
COPY . .
# Expose the port that the app runs on
EXPOSE 3000
# Start the application
CMD ["npm", "start"]
