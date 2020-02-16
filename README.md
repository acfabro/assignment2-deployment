# Deployment Instructions

0. Clone this repo with e.g. `git clone git@github.com:acfabro/assignment2-deployment.git assignment` and open the new directory. 

1. Import `database/database.sql` to your MySQL database.

2. Open `deploy.sh` and edit your database settings. I.e. your database's IP address, database name, and credentials.

```
export DB_HOST=127.0.0.1
export DB_PORT=3306
export DB_NAME=database
export DB_USERNAME=homestead
export DB_PASSWORD=secret
``` 

Note: DB_HOST=127.0.0.1 may not work. Set this to an IP other than localhost.

3. Run `sh deploy.sh` to download all code. You may have to check the output and watch for errors.

4. If there were no errors run `docker-compose up`.

5. Open [http://localhost:9800](http://localhost:9800) on your browser.

## Install on your own web server

If you want to install on your own web server and configure the application yourself:

1. Open api/.env and edit your database, redis settings.

2. Open web/config.js and edit API_URL
