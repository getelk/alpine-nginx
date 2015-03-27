FROM gliderlabs/alpine:latest

RUN apk-install --update nginx && \
    mkdir /tmp/nginx

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log
RUN mkdir -p /usr/share/nginx && ln -s /usr/html /usr/share/nginx/html

ADD ./files/nginx.conf /etc/nginx/nginx.conf
ADD ./files/conf.d /etc/nginx/conf.d

VOLUME ["/var/cache/nginx"]

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]