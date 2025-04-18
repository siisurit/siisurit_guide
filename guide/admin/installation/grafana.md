# Grafana

[Grafana](https://grafana.com) is an application for analytics and interactive visualization. In combination with Siisurit, it can be used to produce charts and graphs by connecting to Siisurit's reporting views in its SQL database.

!!! On-premise only

    Because SQL views allow to access data of all tenants, this feature us only supported on-premise.

## Installation

While Grafana can be [installed in multiple ways](https://grafana.com/docs/grafana/latest/setup-grafana/), the simplest approach is to extend [Siisurit's docker installation](docker.md) with an additional service and binds for Grafana's internal database and provisionings.

Here is an example for the additional parts in your `compose.yaml`:

```yaml
grafana:
  container_name: "siisurit-grafana"
  image: grafana/grafana:latest
  depends_on:
    - postgres
  restart: unless-stopped
  volumes:
    - ./grafana/data:/var/lib/grafana
    - ./grafana/provisioning:/etc/grafana/provisioning
  # The user running `docker compose`, which must have permission to write
  # to "./grafana/data/". If you are running as root, then set it to 0
  # else find the right id with the `id -u` command.
  user: "1000"
  ports:
    - "8236:3000"
  env_file:
    - "./.env"
```

This way, Grafana automatically starts together with Siisurit.

## Initial Grafana set up

### Connect

After Grafana is up and running, you can connect to it: <http://localhost:8236/>.

### Default Grafana user

By default, a Grafana user "admin" with the password "admin" has been created.

Upon first log in, a password change is encouraged.

### Use provisions for the siisurit data source

To use standard provisions, add a `.../grafana/provisionin/datasources/datasource.yml` with the following content:

```yaml
apiVersion: 1
datasources:
  - name: siisurit_postgres
    default: true
    type: postgres
    url: ${SII_POSTGRES_HOST}:5432
    database: ${SII_POSTGRES_DATABASE}
    user: ${SII_POSTGRES_REPORT_USERNAME}
    secureJsonData:
      password: ${SII_POSTGRES_REPORT_PASSWORD}
    jsonData:
      sslmode: disable
```

### Manually add the siisurit data source

To add a datasource pointing to the Siisurit database:

- Connection
  - Host URL: Value from `${SII_POSTGRES_HOST}` and then `:5432`
  - Database name: Value from `${SII_POSTGRES_DATABASE}`
- Authentication (see also: [SQL report user](sql-report-user.md)):
  - Username: Value from `${SII_POSTGRES_REPORT_USERNAME}`
  - Password: Value from `${SII_POSTGRES_REPORT_PASSWORD}`
  - TLS/SSL Mode: disable
- Additional settings
  - Adjust as needed.

## Adding reports to Grafana.

See the chapter on "[Adding a Grafana panel](../../user/grafana/index.md)" in the user guide.

## Adding Grafana users from the command line

First, make sure the environment variable `$SII_GRAFANA_ADMIN_PASSWORD` is available to the shell, either by settings it:

```bash
export SII_GRAFANA_ADMIN_PASSWORD="not-secret"
```

or by including them into the current shell:

```bash
. ./.env
```

Then use `cURL` and the Grafana API to creat a new user. For example:

```bash
curl -X POST -H "Content-Type: application/json" -d '{
  "name":"Alice Adams",
  "email":"alice@example.com",
  "login":"alice",
  "password":"not-secret"
}' https://admin:$SII_GRAFANA_ADMIN_PASSWORD@grafana.example.com/api/admin/users
```

Replace the `grafana.example.com` in the URL with the domain of your Grafana server, and modify the user details as needed.

## Security advice

In order to make the installation as secure as possible, consider making the following adjustments:

- When signin in for the first time, change the default password of the "admin" user.
- Use a separate [SQL report user](sql-report-user.md) for the Grafana connector to the Siisurit database.

## Admin password reset

In case you lost the Grafana admin password, you can reset it using the `grafana cli` command (replace `TODO` with the new password):

```bash
docker compose exec grafana grafana cli admin reset-admin-password TODO
```
