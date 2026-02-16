# v0.49.0

⚠️This version was never released in favor of moving the entire frontend to Django with version 0.50.0.

## Add project documents

Project members can now add documents using the Markdown format (`*.md`) to the project by tapping the "Add documents" button.

Documents can then be browsed and used for interactions with AI agents.

## Add more data for MCP

The following data can now be accessed via MCP:

- Organizations
- Projects
- Trackers
- Users

## Fix flushed database on container restart

Every time the backend container restarted, it did prune the database using Django's [`flush`](https://docs.djangoproject.com/en/5.2/ref/django-admin/#flush). This seems to have been a leftover from the early experiments to get the docker release working. It's gone now, and restarting the backend container preserves the database.
