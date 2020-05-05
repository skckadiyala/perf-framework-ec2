FROM nginx

MAINTAINER support@axway.com
ENV TZ=Europe/Dublin

COPY default.conf /etc/nginx/conf.d/default.conf
COPY example_ssl.conf /etc/nginx/conf.d/example_ssl.conf
COPY nginx.conf /etc/nginx/nginx.conf

COPY weather_country.response /usr/share/nginx/html/weather_country.response
COPY weather_country.response /usr/share/nginx/html/backend_ssl

COPY cert.pem /etc/nginx/cert.pem
COPY cert.key /etc/nginx/cert.key
