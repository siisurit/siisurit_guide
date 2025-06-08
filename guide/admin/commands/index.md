# Overview

For maintaining a Siisurit instance, various management commands are available:

## Running a management command

Management command are installed on the docker container and can be run using

```sh
docker compose exec backend python manage.py {command} {option} {option} ...
```

For example:

```sh
docker compose exec backend python manage.py make_users --help
```

In this case, the `{command}` is `make_users` and `{option}` is `--help`.

Running this particular command shows the quick help of this particular command.

## Quick help

All management commands support the option `--help`, which shows a concise help text. This includes a short description of the purpose of the command, and which options are available. Each option has its own description, which typically includes valid values or ranges, and the default (if any).

## Available commands

- [clear_caches](clear_caches.md): Clear application caches, especially for API download
- [clear_reports](clear_reports.md): Remove all reports related SQL components, except for the "report" schema
- [explain_work_entry](explain_work_entry.md): Help to understand why certain work entries were matched (or not) to a specific task.
- [make_reports](make_reports.md): Add report related SQL components
- [make_report_user](make_report_user.md): Create a PostgreSQL user with read-only access to reports
- [make_users](make_users.md): Bulk process users using a CSV file
- [match_project](update_project.md): Match data in task and time trackers with each other.
- [remove_organization](remove_organization.md): Remove an organization and all data related to it.
- [update_organization](updape_organization.md): Update all organization and all its projects, trackers, etc. according to an organization configuration.
- [update_project](update_project.md): Download data for task and time trackers, and match them with each other.

## Django commands

The Django framework used by the Siisurit backend includes a couple commands that might be helpful when tracking down errors.

- createsuperuser: In case the signin details for all site administrators have been lost, a new site administrator can be created with this command.
- shell: In combination with the `--command` option, this can be used to run a Python script that has full access to the database using the Django ORM. This can be used to run automated queries and forward the results to a business intelligence solution.
- dbshell: Open [psql](https://www.postgresql.org/docs/current/app-psql.html) database shell using the connection information from the [environment file](../configuration/environment-file.md). This can be helpful to check if database access is possible, or to send automated queries and forward the results into a business intelligence solution.

There are many other Django commands, however, they are mostly useful for development or already automatically run when starting the docker container, so they are not further elaborated here.
