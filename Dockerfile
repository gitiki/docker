FROM php:5.6-apache
MAINTAINER Francis Besset <francis.besset+docker@gmail.com>

ENV GITIKI_VERSION 1.0.x-dev


# intl
RUN apt-get update && apt-get install -y libicu-dev g++ --no-install-recommends && rm -rf /var/lib/apt/lists/* \
 && docker-php-ext-install intl \
 && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false -o APT::AutoRemove::SuggestsImportant=false g++

# gd
RUN apt-get update && apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng12-dev --no-install-recommends && rm -rf /var/lib/apt/lists/* \
 && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
 && docker-php-ext-install gd


RUN echo "date.timezone = UTC\nexpose_php = Off\nshort_open_tag = Off" > /usr/local/etc/php/conf.d/gitiki.ini


# install composer
RUN apt-get update && apt-get install -y git zlib1g-dev openssh-client --no-install-recommends && rm -rf /var/lib/apt/lists/* \
 && docker-php-ext-install zip \
 && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

ENV COMPOSER_NO_INTERACTION 1


RUN requires=" \
        gitiki/code-highlight:$GITIKI_VERSION \
        gitiki/redirector:$GITIKI_VERSION \
    " \
 && composer create-project --prefer-dist gitiki/gitiki /srv/gitiki $GITIKI_VERSION \
 && cd /srv/gitiki && chmod +x gitiki \
 && composer require $requires && composer clear-cache


ENV NODE_VERSION 5.5.0

RUN curl https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.gz -o node.tar.gz \
 && mkdir -p /opt/node \
 && tar -xz --strip-components=1 -C /opt/node -f node.tar.gz \
 && rm node.tar.gz

ENV PATH /opt/node/bin:$PATH

RUN cd /srv/gitiki && npm install


RUN a2enmod rewrite
COPY .htaccess /var/www/html/.htaccess
COPY index.php /var/www/html/index.php

VOLUME ["/srv/wiki"]

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["apache2-foreground"]
