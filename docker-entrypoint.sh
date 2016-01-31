#!/bin/bash

cd /srv/gitiki
./gitiki --wiki-dir=/srv/wiki bootstrap
./gitiki --wiki-dir=/srv/wiki webpack

./node_modules/.bin/webpack --output-path /var/www/html/assets --optimize-minimize

exec "$@"
