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

# TODO#570 Change to limited set of URLs.
# SII_CORS_ALLOW_ALL_ORIGINS=true
SII_CORS_ALLOWED_ORIGINS=https://app.siisurit.example.com
SII_CSRF_TRUSTED_ORIGINS=https://app.siisurit.example.com,https://backend.siisurit.example.com

# PostgreSQL
SII_POSTGRES_DATABASE=siisurit
SII_POSTGRES_HOST=siisurit-postgres
SII_POSTGRES_PASSWORD="no-secret"  # FIXME: Security
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

# Users: users.csv

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

## Organization and project configuration: example-organization.yaml

```yaml
organization:
  name: Example LCC
  code: example
  timezone: Europe/Vienna

  organization_profiles:
    - username: alice
    - username: bob
    - username: claire
    - username: daniel

  user_mappings:
    - name: "kimai.example.com"
      external_usernames_to_username:
        - external_username: "alice"
          username: alice
        - external_username: "bob"
          username: bob
        - external_username: "claire"
          username: claire
        - external_username: "daniel"
          username: daniel
    - name: "github.com"
      external_usernames_to_username:
        - external_username: "alice"
          username: alice
        - external_username: "bob"
          username: bob
        - external_username: "claire"
          username: claire
        - external_username: "daniel"
          username: daniel

  projects:
    - code: example-app
      name: Example project to develop an app

      trackers:
        - name: example-kimai
          api_kind: kimai
          api_location: "https://kimai.siisurit.com/en/admin/customer/4/details"
          api_token: ${SII_EXAMPLE_KIMAI_TOKEN}
          user_mapping: "kimai.siisurit.com"

          tasks:
            - title: "Various"
              code: various
              estimates: 0
            - title: Projectmanagement Siisurit
              code: pm
              estimates: 100
          work_matches:
            - match_on: pattern_to_task_code
              source_work_trackers:
                - example-kimai
              priority: 100
              text_pattern: "^(?P<task_code>#\\d+).*"
            - match_on: always_to_task
              source_work_trackers: demo-kimai
              text_pattern: "(?i).*(daily|project management).*"
              target_task: pm
              priority: 1
            - match_on: always_to_task
              source_work_trackers: demo-kimai
              target_task: various
              priority: 1
```

## Docker configuration: compose.yaml

```yaml
## Siisurit stage app and backend
name: siisurit-stage
services:
  postgres:
    container_name: "siisurit-stage-postgres"
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
    container_name: "siisurit-stage-backend"
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
    container_name: "siisurit-stage-frontend"
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
