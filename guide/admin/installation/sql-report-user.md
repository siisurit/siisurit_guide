# SQL report user

While the [reporting views](../../user/report-views.md) technically can be accessed using the PostgreSQL database user of the backend, this is not advisable because this user has extensive access rights and can also modify data.

Instead, consider creating a database user that has only access to the report view:

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
create user reporting with password 'TODO';
```

Assuming the environment variable `SII_POSTGRES_DATABASE` has been set to `siisurit`, connect to the foo database

```
\c siisurit
```

Grant necessary basic permissions

```sql
grant connect on database siisurit to reporting;  -- Use $SII_POSTGRES_DATABASE
grant usage on schema public to reporting;
```

!!! warning "Access to all tables"

    The instrction below grant read access to all tables and views in the "public" schema. With #915, reports will move into their own schema, which makes it easier to limit the access to only them.

Grant `select` permission on existing report views:

```sql
grant select on all tables in schema public to reporting;
```

Set up default privileges for future report views:

```sql
alter default privileges in schema public grant select on tables to reporting;
```
