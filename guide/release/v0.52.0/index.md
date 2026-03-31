# v0.52.0

## ⚠️ Breaking changes

The database schema has some major changes and requires to [reset the database](../../admin/operation/database.md#reset-the-database).

Instead of a first and last name, members now have a combined name. This means the CSV files for the [make_users](../../admin/commands/make_users.md) need to be updated: Combine the `first_name` and `last_name` columns into a single `name` column, and then remove the obsolete `first_name` and `last_name` columns.

## Features

The UI should be more consistent now and several visual quirks have been addressed. This is an ongoing process, though.

The screens for work entry details and to understand how it got matched to a task should be at least somewhat easier to read now.

Progress bars for tasks that have not been finished yet are slightly stripped now.

The icon in the top right corner of finished tasks cards is more prominent now.

Instead of having a dashboard showing various statistics and charts about a member, the navigation bar has now a "Members" item where one can choose which member to see this information for. The current dashboard is empty, but will get content again in a future release.

Members can now choose to use the System theme instead of having to commit to "dark" or "light". This is now the default for new member and also used for the sign-in screen.

The management commands [make_demo_organization](../../admin/commands/make_demo_organization.md) and [make_demo_project](../../admin/commands/make_demo_project.md) can be used to create demo data to quickly showcase or test the application.

With the environment variable [SII_SIGN_IN_NOTE](../../admin/configuration/environment-file.md#sii_sign_in_note), site administrators can now add a note to the sign-in page.

When adding a new tracker to a project, only trackers with a stable implementation can be picked. Site admins can change this by setting the environment variable [SII_EXPERIMENTAL](../../admin/configuration/environment-file.md#sii_experimental) to `true`, which will show all trackers again (even if they might not work yet).

The environment variables [SII_DOCKER_RESET_DATABASE](../../admin/configuration/environment-file.md#sii_docker_reset_database) and [SII_DOCKER_RESET_STATIC](../../admin/configuration/environment-file.md#sii_docker_reset_static) can be set to `true` (case-sensitive) in the environment of the Siisurit docker container to reset the database or static files during the next startup.
