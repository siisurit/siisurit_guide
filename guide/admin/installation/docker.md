# Docker installation

[Docker](https://www.docker.com/) is a technology that uses virtualization on the operating system level to deliver software in packages called containers.

This chapter explains how to install and configure Siisurit using its docker container.

## File structure

The following will assume a Ubuntu 24 LTS server and a file structure like:

- /opt/siisurit/
  - .env
  - compose.yaml
  - config/
    - demo-organization.yaml
    - users.csv

In the following, all these files are be explained using common example you can you as basis for your own configuration.

## Example organization

The examples in the chapter assume an organization Example LCC with multiple employees named Alice, Bob, Claire, and Daniel. Alice also takes the role of a system administrator.

Siisurit should be available under the following domains:

- https://app.siisurit.example.com
- https://backend.siisurit.example.com

## Environment file: .env

The environment file `.env` contains the settings for the Siisurit service. This includes (but is not limited to):

- Database settings
- Security settings
- Access restrictions

As starting point:

```dotenv
SII_ENVIRONMENT=test

# Create a secret key by running:
# python manage.py shell -c 'from django.core.management import utils; print(utils.get_random_secret_key())'
SII_SECRET_KEY="not-secret"  # FIXME: Security
SII_FERNET_KEYS="not-secret"  # FIXME: Security

SII_ALLOWED_HOSTS=127.0.0.1,localhost,backend.siisurit.example.com

# SII_CORS_ALLOW_ALL_ORIGINS=true  # Security: Disable CORS if you feel the need to.
SII_CORS_ALLOWED_ORIGINS=https://app.siisurit.example.com

SII_CSRF_TRUSTED_ORIGINS=https://app.siisurit.example.com,https://backend.siisurit.example.com

# PostgreSQL
SII_POSTGRES_DATABASE=siisurit
SII_POSTGRES_HOST=siisurit-postgres
SII_POSTGRES_PASSWORD="not-secret"  # FIXME: Security
SII_POSTGRES_PORT=5432
SII_POSTGRES_USERNAME=siisurit
```

In addition, you will want to add any tokens for your task and time trackers here, so that they can be referred to in the organization configuration without the person maintaining it have to knew them.

For example, this could be the settings for a project that uses GitHub as task tracker and Kimai as time tracker:

```dotenv
EXAMPLE_GITHUB_USERNAME="alice"
EXAMPLE_GITHUB_TOKEN="ghp_zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz"

EXAMPLE_KIMAI_TOKEN="1234567890123456789012345"
```

# User list: users.csv

The users file `users.csv` contains the users to be created each time siisurit restarts. Users that already exist are not re-created again.

Example:

```csv
username,password,is_staff,is_superuser,first_name,last_name,email
admin_alice,no-secret,x,x,Alice,Adams,support@example.com
alice,no-secret,x,x,,Alice,Adams,alice@example.com
alice,no-secret,,,Alice,Adams
bob,no-secret,,,Bob,Brown
claire,no-secret,,,Claire,Clark
daniel,no-secret,,,Daniel,Davis
```

The `is_staff` column indicates the user can log in at the admin interface of the backend, and can read most data available there.

The `is_staff` marks as user as site administrator, which add permission to edit data in the admin interface, and upload new organizations from scratch.

## Compose file: compose.yaml

The [compose file](../configuration/compose-file.md) describes the services required to run Siisurit in a way that they can be started using Docker's `docker compose` command. This includes the frontend, backend, and the database.

Here's an example that utilized the `.env` and `config/users.csv` from above:

```yaml
## Siisurit app and backend
name: siisurit
services:
  postgres:
    container_name: "siisurit-postgres"
    image: "postgres:16" # Same as Ubuntu 24 LTS
    volumes:
      - postgres-data:/var/lib/postgresql/data
    env_file:
      - ".env"
    environment:
      POSTGRES_DB: "${SII_POSTGRES_DATABASE}"
      POSTGRES_USER: "${SII_POSTGRES_USERNAME}"
      POSTGRES_PASSWORD: "${SII_POSTGRES_PASSWORD}"

  backend:
    container_name: "siisurit-backend"
    image: "docker-registry-ui.siisurit.com/siisurit-backend:latest"
    command: >-
      gunicorn
        --access-logfile -
        --bind 0.0.0.0:8000
        --capture-output
        --name siisurit_stage
        --workers 3
        siisurit.wsgi:application
    volumes:
      - ./config/:/mnt/config/
      - static-data:/home/app/web/static
    env_file:
      - ".env"

  frontend:
    container_name: "siisurit-frontend"
    image: "docker-registry-ui.siisurit.com/siisurit-frontend:latest"
    volumes:
      - static-data:/home/app/web/static
    ports:
      - "8235:80"
      - "8234:81"

volumes:
  postgres-data:
  static-data:
```

## Run the services

With all files in place, you can now sign in to Siisurit's private docker registry using the sign in information you obtained together with your license:

```bash
docker login docker-registry-ui.siisurit.com
```

After that, download all the docker images using:

```bash
docker compose pull
```

Depending on the speed of your internet connection, this might take a while.

Once everything is downloaded, run the containers:

```bash
docker compose up
```

In the log you can see how the service startup is progressing. Eventually the following should show, indicating that the backend is now ready to accept requests:

```
siisurit-backend   | ... [INFO] Starting gunicorn 23.x.x
siisurit-backend   | ... [INFO] Listening at: http://0.0.0.0:8000 (1)
```

You can now check the availability of the services. For example, with [curl](https://curl.se/):

```bash
$ curl -Is http://localhost:8234 | head -1
HTTP/1.1 200 OK
$ curl -Is http://localhost:8235 | head -1
HTTP/1.1 200 OK
```

## Start as background service

To run Siisurit as background service that even automatically restarts after a reboot, run;

```bash
docker compose up --detach
```
