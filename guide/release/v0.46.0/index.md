# v0.46.0

!!! warning "Breaking change: Change to vector database"

    This version switches from plain PostgreSQL to pgvector. Consequently the base database container in `compose.yaml` has to be changed from "postgres:16" to "pgvector/pgvector:pg16".

!!! warning "Breaking change: Data model reset"

    This version resets the data model. Consequently, the [database has to be reset](../../admin/operation/database.md#reset-the-database).

TODO: Describe changes
