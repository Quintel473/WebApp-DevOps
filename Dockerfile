# Use the official Nginx image from Docker Hub
FROM nginx:alpine

# Copy your HTML files into the Nginx web server directory
COPY ./html /usr/share/nginx/html

# Expose the port Nginx will run on
EXPOSE 80
