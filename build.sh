#!/bin/sh

set -e

# config
# export WEB_PORT=9800
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

# build api, install dependencies and
cd api || exit
cp .env.example .env
sed -i.bak "s/^DB_HOST=.*/DB_HOST=$DB_HOST/" .env
sed -i.bak "s/^DB_NAME=.*/DB_NAME=$DB_NAME/" .env
sed -i.bak "s/^DB_PORT=.*/DB_PORT=$DB_PORT/" .env
sed -i.bak "s/^DB_USERNAME=.*/DB_USERNAME=$DB_USERNAME/" .env
sed -i.bak "s/^DB_PASSWORD=.*/DB_PASSWORD=$DB_PASSWORD/" .env
sed -i.bak "s/^USE_CACHE=.*/USE_CACHE=$USE_CACHE/" .env
sed -i.bak "s/^REDIS_STRING=.*/REDIS_STRING=$REDIS_STRING/" .env
sed -i.bak "s/^REDIS_PORT=.*/REDIS_PORT=$REDIS_PORT/" .env
php ../bin/composer.phar install

# build web
cd ../web || exit
npm install
sed -i.bak 's/^API_URL=.*/API_URL=$API_URL/' .env
sed -i.bak 's/".*"/"http:\/\/18.139.108.131:9801"/' src/config.js
npm run build

# copy built items to server, so you can run web from 9801
cd ..
cp -rv ./web/build/* ./api/public

# done
echo "run: 'docker-compose up' to build your containers"


# for errors

# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
# echo an error message before exiting
trap 'echo "\"${last_command}\" command filed with exit code $?."' EXIT