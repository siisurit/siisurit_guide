# v0.46.0

!!! warning "Breaking change: Change to vector database"

    This version switches from plain PostgreSQL to pgvector. Consequently the base database container in `compose.yaml` has to be changed from "postgres:16" to "pgvector/pgvector:pg16".

!!! warning "Breaking change: Data model reset"

    This version resets the data model. Consequently, the [database has to be reset](../../admin/operation/database.md#reset-the-database).

## Migrate existing docker installations

To upgrade an existing docker installation from version 0.45 to 0.46, perform the following steps:

1. Reset the database:
   ```bash
   docker compose exec backend python manage.py reset_db --noinput
   ```
2. [Install ollama](../../admin/installation/ollama.md). If you are using `docker compose`, remember to add a proper `SII_OLLAMA_URL` to it (see the example).
3. Download the relevant language models.
   ```bash
   docker compose exec backend python manage.py update_ollama_models
   ```
4. Update your organization and projects as before.
5. Update the data for similarity search (replace "TODO" with the code of your organization):
   ```bash
   docker compose exec backend python manage.py update_search TODO
   ```

If you have a script to run daily, you can make it look like (replace "TODO" with the code of your organization):

```bash
#!/bin/sh
set -ex
docker compose exec backend python manage.py update_project TODO
docker compose exec backend python manage.py update_ollama_models
docker compose exec backend python manage.py update_search TODO
```

## Improved work entry matching

Matching work entries is much faster now. Most of the work is done in the database using SQL statements, and the Django backend mostly orchestrates the various steps.

The decision process how a work entry got mapped to a specific task can now be made transparent using the management command [explain_work_entry](../../admin/commands/explain_work_entry.md).

## Find similar tasks

This release includes an initial implementation to find tasks similar to existing tasks. This can be used to give a feeling of how long it might take to implement the new task.

Currently, you have to use the command line for that. A graphical user interface will be added as this feature matures.

To make this work, update the information that enables similarity search within tasks of an organization or project using the management command [update_search](../../admin/commands/update_search.md). This should be run any time you transfer data from tarcker using the management command [update_project](../../admin/commands/update_project.md).

After that, you can find similar tasks using the management command [find_similar_tasks](../../admin/commands/find_similar_tasks.md)
