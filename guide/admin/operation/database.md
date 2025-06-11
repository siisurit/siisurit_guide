# Database

## Reset the database

Normally, the database does not need to be reset. PostgreSQL typically runs very stably and can recover from many error scenarios. Data model changes are handled automatically when restarting the backend.

However, certain situations might enforce a database reset, for example:

- The database is severely broken.
- The data model has been reset and cannot be easily migrated automatically. This might still happen once in a while during the beta period.

To reset the database for a local installation, run:

```bash
python manage.py reset_db --noinput
```

For docker installations, run:

```bash
docker compose exec backend python manage.py reset_db --noinput
```
