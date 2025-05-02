FROM nginx:stable-alpine

# Copy snapshot of nginx configuration into image
WORKDIR /etc/nginx/conf.d/
COPY nginx/nginx.conf .
RUN mv nginx.conf default.conf

# Copy snapshot of local project source code into image
WORKDIR /var/www/html
COPY src .