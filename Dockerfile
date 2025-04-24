# Use an official Nginx image
FROM nginx:latest

# Copy static files from your local repository to the container
COPY ./index.html /usr/share/nginx/html/
COPY ./styles.css /usr/share/nginx/html/

# Expose port 80 to make the app accessible
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
