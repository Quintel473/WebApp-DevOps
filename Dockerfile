# Use an official Nginx image to serve the app
FROM nginx:alpine

# Copy the HTML and CSS files to the correct directory
COPY Index.html /usr/share/nginx/html/
COPY styles.css /usr/share/nginx/html/

# Expose port 80 to the host
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
