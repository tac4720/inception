FROM debian:bullseye-slim

RUN apt-get update && \
    apt-get install -y php7.4-fpm php7.4-mysql mariadb-client curl && \
    rm -rf /var/lib/apt/lists/*

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/

COPY ./tools/setup_wp.sh /tmp/
RUN chmod +x /tmp/setup_wp.sh

ARG DOMAIN_NAME
ARG MYSQL_DATABASE
ARG MYSQL_USER
ARG MYSQL_PASSWORD
ARG WP_ADMIN_USER
ARG WP_ADMIN_PASSWORD
ARG WP_ADMIN_EMAIL
ARG WP_USER
ARG WP_USER_PASSWORD
ARG WP_USER_EMAIL

ENV DOMAIN_NAME=${DOMAIN_NAME}
ENV MYSQL_DATABASE=${MYSQL_DATABASE}
ENV MYSQL_USER=${MYSQL_USER}
ENV MYSQL_PASSWORD=${MYSQL_PASSWORD}
ENV WP_ADMIN_USER=${WP_ADMIN_USER}
ENV WP_ADMIN_PASSWORD=${WP_ADMIN_PASSWORD}
ENV WP_ADMIN_EMAIL=${WP_ADMIN_EMAIL}
ENV WP_USER=${WP_USER}
ENV WP_USER_PASSWORD=${WP_USER_PASSWORD}
ENV WP_USER_EMAIL=${WP_USER_EMAIL}
ENV DB_HOST=mariadb 

WORKDIR /var/www/html

ENTRYPOINT [ "/tmp/setup_wp.sh" ]
CMD [ "php-fpm7.4", "-F" ]
