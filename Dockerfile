# Use the official Nginx image from Docker Hub
FROM nginx:alpine

# Copy your HTML files into the Nginx web server directory
COPY ./HTML /usr/share/nginx/HTML

# Expose the port Nginx will run on
EXPOSE 80
