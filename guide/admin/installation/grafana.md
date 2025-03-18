# Grafana

[Grafana](https://grafana.com) is an application for analytics and interactive visualization. In combination with Siisurit, it can be used to produce charts and graphs by connecting to Siisurit's reporting views in its SQL database.

!!! On-premise only

    Because SQL views allow to access data of all tenants, this feature us only supported on-premise.

## Installation

While Grafana can be [installed in multiple ways](https://grafana.com/docs/grafana/latest/setup-grafana/), the simplest approach is to extend [Siisurit's docker installation](docker.md) with an additional service and binds for Grafana's internal database and provisionings.

Here is an example for the additional parts in your `compose.yaml`:

```yaml
grafana:
  container_name: "grafana"
  image: grafana/grafana:latest
  depends_on:
    - postgres
  restart: unless-stopped
  volumes:
    - ./grafana/provisioning:/etc/grafana/provisioning
    - ./grafana/data:/var/lib/grafana
  ports:
    - "8236:3000"
  env_file:
    - "./.env"
```

This way, Grafana automatically starts

## Initial Grafana set up

### Connect

After Grafana is up and running, you can connect to it: <http://localhost:8235/>.

### Default Grafana user

By default, a Grafana user "admin" with the password "admin" has been created.

Upon first login, a password change is encouraged.

### Use provisions for the siisurit data source

If you are using the standard provisions

TODO: Explain how the standard provisions can be obtained.

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

## Security advise

In order to make the installation as secure as possible, consider making the following adjustments:

- When signin in for the first time, change the default password of the "admin" user.
- Use a separate [SQL report user](sql-report-user.md) for the Grafana connector to the Siisurit database.
