# Deployment Instructions

## Requirements

1. PHP 7 - tested on PHP 7.3. Required packages
```
php
php-json
php-xml
php-common
php-mbstring
php-cli
```

2. npm

3. docker

4. docker-compose
```shell script
sudo curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

## Steps

0. Clone this repo with e.g. `git clone git@github.com:acfabro/assignment2-deployment.git assignment` and open the new directory. 

1. Import `database/database.sql` to your MySQL database.

2. If using your own database, open `deploy.sh` and edit your database settings. I.e. your database's IP address, database name, and credentials.

```
export DB_HOST=db
export DB_PORT=3306
export DB_NAME=database
export DB_USERNAME=homestead
export DB_PASSWORD=secret
``` 

Note: DB_HOST=127.0.0.1 may not work. Set this to an IP other than localhost.

3. Run `sh deploy.sh` to download all code. You may have to check the output and watch for errors.

4. If not installing on local machine, change the API address by editing `web/.env` and `web/config.env`.

5. Run `sh build.sh` to build  your environment.

6. If there were no errors run `docker-compose up`.

7. Services should be ready to use. 

* Open [http://localhost:9800](http://localhost:9800) on your browser for the web.
* API is at [http://localhost:9801](http://localhost:9801). Test using postman with the collection at `api/api.postman_collection.json`.
* Open DB adminer at [http://localhost:9802](http://localhost:9802) on your browser for the web.

## Install on your own web server

If you want to install on your own web server and configure the application yourself:

1. Open api/.env and edit your database, redis settings.

2. Open web/config.js and edit API_URL
