# Compose file

The compose file describes all the services needed to run in a way that Docker can run them using the `compose` command.

The services are:

- `backend`, the [Django](https://www.djangoproject.com/) backend of Siisurit
- `frontend`, an [nginx](https://nginx.org/) web server with the static files for the [Flutter](https://flutter.dev/) frontend of Siisurit
- `grafana` (optional), the [Grafana](https://grafana.com/) web application for analytics and interactive visualization
- `postgres`, the [PostgreSQL](https://www.postgresql.org/) open source SQL database

## Example

For an example, see the chapter on [Installation](../installation/docker.md).
