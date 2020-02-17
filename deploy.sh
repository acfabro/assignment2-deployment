#!/bin/sh

set -x

# config
export WEB_PORT=9800
export API_URL=http:\\/\\/127.0.0.1:9801

# env config
export DB_HOST=db
export DB_PORT=3306
export DB_NAME=database
export DB_USERNAME=homestead
export DB_PASSWORD=secret
export USE_CACHE=true
export REDIS_STRING=redis
export REDIS_PORT=6379

# tools - composer
mkdir bin
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === 'e0012edf3e80b6978849f5eff0d4b4e4c79ff1609dd1e613307e16318854d24ae64f26d17af3ef0bf7cfb710ca74755a') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
mv composer.phar bin/
chmod +x bin/composer.phar

# git pull
git clone git@github.com:acfabro/assignment2.git api
git clone git@github.com:acfabro/assignment2-html.git web

# build api, install dependencies and
cd api || exit
cp .env.example .env
sed -i .bak "s/^DB_HOST=.*/DB_HOST=$DB_HOST/" .env
sed -i .bak "s/^DB_NAME=.*/DB_NAME=$DB_NAME/" .env
sed -i .bak "s/^DB_PORT=.*/DB_PORT=$DB_PORT/" .env
sed -i .bak "s/^DB_USERNAME=.*/DB_USERNAME=$DB_USERNAME/" .env
sed -i .bak "s/^DB_PASSWORD=.*/DB_PASSWORD=$DB_PASSWORD/" .env
sed -i .bak "s/^USE_CACHE=.*/USE_CACHE=$USE_CACHE/" .env
sed -i .bak "s/^REDIS_STRING=.*/REDIS_STRING=$REDIS_STRING/" .env
sed -i .bak "s/^REDIS_PORT=.*/REDIS_PORT=$REDIS_PORT/" .env
php ../bin/composer.phar install

# build web
cd ../web || exit
npm install
sed -i .bak "s/^API_URL=.*/API_URL=$API_URL/" .env
npm run build
