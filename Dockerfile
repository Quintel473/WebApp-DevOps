# Use an official Nginx image to serve the app
FROM nginx:alpine

# Copy files into the correct nginx directory
COPY index.html /usr/share/nginx/html/
COPY styles.css /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

# Run Nginx in foreground
CMD ["nginx", "-g", "daemon off;"]
