# SQL report user

While the [reporting views](../../user/report-views.md) technically can be accessed using the PostgreSQL database user of the backend, this is not advisable because this user has extensive access rights and can also modify data.

Instead, consider creating a database user that has only access to the report view.

## Add environment variables

To make the report user generally available, add the respective environment variables to your [environment file](../configuration/environment-file.md). For example:

```dotenv
SII_POSTGRES_REPORT_USERNAME=reporting
SII_POSTGRES_REPORT_PASSWORD=not-secret
```

## Create with management command

To create the database user specified with `SII_POSTGRES_REPORT_*`, run:

```bash
docker compose exec backend python manage.py make_report_user
```

This creates the user (if it does not exist yet) and grants read-only access to the report views.

## Create manually

In case you prefer to manually create the report use, proceed as follows:

Connect to the PostgreSQL database as a superuser. If Postgres runs inside a docker container:

```bash
docker compose exec siisurit-postgres psql --username $SII_POSTGRES_USERNAME --dbname $SII_POSTGRES_DATABASE
```

In case the database user is also the owner:

```bash
docker compose exec siisurit-backend python manage.py dbshell
```

For a local database:

```bash
psql --username postgres --dbname postgres
```

Create the new user named "reporting" (replace "TODO" with a strong password):

```sql
-- Replace TODO with value from SII_POSTGRES_REPORT_PASSWORD.
create user reporting with password 'TODO';
```

Assuming the environment variable `SII_POSTGRES_DATABASE` has been set to `siisurit`, connect to the foo database:

```
\c siisurit
```

To make sure the report user does not have any unnecessary access, revoke any possibly existing:

```postgresql
revoke all privileges on schema report from reporting;
```

Grant necessary basic permissions:

```sql
grant connect on database siisurit to reporting;
grant usage on schema report to reporting;
```

Grant `select` permission on existing report views:

```sql
grant select on all tables in schema report to reporting;
```

Set up default privileges for future report views:

```sql
alter default privileges in schema report grant select on tables to reporting;
```
