FROM nginx

RUN apt-get update -y && \
    apt-get install nano -y && \
    rm -f /etc/nginx/conf.d/default.conf

COPY ./default.conf /etc/nginx/conf.d/default.conf