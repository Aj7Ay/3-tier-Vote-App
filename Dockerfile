# Use Node.js 16 image
FROM node:16 as build

WORKDIR /app
COPY package*.json ./
RUN npm install --legacy-peer-deps
COPY . .
RUN npm run build

# Stage 2: Serve the React app using NGINX
FROM nginx:alpine

# Remove the default NGINX welcome page
RUN rm -rf /usr/share/nginx/html/*

# Copy the built React app from the previous stage
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80 (default HTTP port)
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]