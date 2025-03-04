# Grafana

[Grafana](https://grafana.com) is an application for analytics and interactive visualization. In combination with Siisurit, it can be used to produce charts and graphs by connecting to Siisurit's reporting views in its SQL database.

!!! On-premise only

    Because SQL views allow to access data of all tenants, this feature us only supported on-premise.

## Installation

While Grafana can be [installed in multiple ways](https://grafana.com/docs/grafana/latest/setup-grafana/), the simplest approach is to extend [Siisurit's docker installation](docker.md) with additional service and volumes for Grafana and its internal database.

Here is an example for the additional parts in your `compose.yaml`:

```yaml
services:
  grafana:
    container_name: "grafana"
    image: grafana/grafana
    volumes:
      - ./grafana/provisioning:/etc/grafana/provisioning
      - grafana-data:/var/lib/grafana
    environment:
      GF_DATABASE_TYPE: postgres
      GF_DATABASE_HOST: "grafana-postgres:5432"
      GF_DATABASE_NAME: "${SII_GRAFANA_POSTGRES_DATABASE}"
      GF_DATABASE_USER: "${SII_GRAFANA_POSTGRES_USERNAME}"
      GF_DATABASE_PASSWORD: "${SII_GRAFANA_POSTGRES_PASSWORD}"
      GF_DATABASE_SSL_MODE: disable
    depends_on:
      - grafana_postgres
    ports:
      - "8235:3000"
    env_file:
      - "./.env"

  grafana-postgres:
    container_name: "grafana-postgres"
    image: "postgres:16" # Same as Ubuntu 24 LTS
    volumes:
      - grafana-postgres-data:/var/lib/postgresql/data
    ports:
      - "${SII_GRAFANA_POSTGRES_PORT:-5433}:5432"
    environment:
      POSTGRES_USER: "${SII_GRAFANA_POSTGRES_USERNAME}"
      POSTGRES_PASSWORD: "${SII_GRAFANA_POSTGRES_PASSWORD}"
      POSTGRES_DB: "${SII_GRAFANA_POSTGRES_DATABASE}"
    env_file:
      - "./.env"

  # ...

volumes:
  grafana-data:
  grafana-postgres-data:
  # ...
```

With this, you add various environment variables to your existing [environment file](../configuration/environment-file.md):

- `SII_GRAFANA_POSTGRES_DATABASE`: The name of the database where Grafana stores its dashboards and data sources. Defaults to "grafana"
- `SII_GRAFANA_POSTGRES_USERNAME`: The username Grafana uses to access this database. Defaults to "grafana".
- `SII_GRAFANA_POSTGRES_PASSWORD`: The username Grafana uses to access this database. Defaults to "no-secret" and should be set to something more secure.
- `SII_GRAFANA_POSTGRES_PORT`: The port on your localhost from which the Grafana database can be accessed. This can be useful in order to back up and restore Grafana's internal data.

For example:

```dotenv
SII_GRAFANA_POSTGRES_DATABASE=grafana
SII_GRAFANA_POSTGRES_USERNAME=grafana
SII_GRAFANA_POSTGRES_PASSWORD="TODO"
```

## Grafana database setup and docker launch

!!! warning "Grafana does not wait for its PostgreSQL database"

    Before you start all the containers, initially only start the Grafana database. This will create the Grafana database and everything related to it, which might take a few seconds. Otherwise, Grafana itself would start up to quickly, be unable to find its database and fail.

Create the Grafana database by starting its container:

```bash
docker compose up grafana-postgres
```

Once done, stop the container and start everything:

```bash
docker compose up --detach
```

## Initial Grafana set up

### Connect

After Grafana is up and running, you can connect to it: <http://localhost:8235/>.

### Default user

By default, a user "admin" with the password "admin" has been created.

Upon first login, a password change is encouraged.

### Add siisurit data source

To add a datasource pointing to the Siisurit database:

- Connection
  - Host URL: `siisurit-postgres:5432`
  - Database name: Value from `${SII_POSTGRES_DATABASE}`
- Authentication:
  - Username: Value from `${SII_POSTGRES_USERNAME}` or [SQL report user](sql-report-user.md)
  - Password: Value from `${SII_POSTGRES_PASSWORD}` or [SQL report user](sql-report-user.md)
  - TLS/SSL Mode: disable
- Additional settings
  - Adjust as needed.

## Adding reports to Grafana.

See the chapter on "[Adding a Grafana panel](../../user/grafana/index.md)" in the user guide.

## Security advise

In order to make the installation as secure as possible, consider making the following adjustments:

- When signin in for the first time, change the default password of the "admin" user.
- Remove the `ports`
  ```yaml
  ports:
    - "${SII_GRAFANA_POSTGRES_PORT:-5433}:5432"
  ```
  for the container "grafana-postgres" unless you really want to access this database yourself. Normally, this should not be needed because it is fully managed by Grafana to store its internal data.
- Use a separate [SQL report user](sql-report-user.md) for the Grafana connector to the Siisurit database.
