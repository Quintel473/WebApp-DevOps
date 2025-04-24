FROM nginx:alpine

# Clear default nginx HTML content
RUN rm -rf /usr/share/nginx/html/*

# Copy all files from your project directory into nginx's web directory
COPY . /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
