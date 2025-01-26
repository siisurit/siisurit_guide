# User list

The user list is a text file

## Basic format

The user list is a comma separated values ([CSV](https://en.wikipedia.org/wiki/Comma-separated_values)) file, where each line describes exactly one user.

The first line is a heading that describes the column.

- username (text): The username to use for signing in. If empty, the email will be used instead.
- email (text): The email address of the user
- full_name (text): The full name of a person, for example: Alice Adams
- is_active (boolean, default: true): If enabled, the user can sign in.
- is_staff (boolean, default: false): If enabled, the user can sign in at the admin site but can only see parts of the available data. For many of them, access is restricted to only reading them.
- is_superuser (default: false): If enabled, the user can sign in at the admin site and can read and write almost all data. The exception are data that are computed dynamically.
- password (text): The initial password that can be used to sign in.

All these attributes are optional, but at least one of `username` or `email` must be specified.

If no `username` is set, the `email` can be used for sign in instead.

If no `email` is set, Siisurit will not be able to send email to a user. Users can however sign in using their `username`.

If no `password` is set, the user will not be able to sign in.

## Updating

To process a user list, use the management command [make_users](../commands/make_users.md).

## Examples

To create a site administrator and two more users:

```csv
username,password,is_superuser
admin_alice,not-secret,x
alice,not-secret
bob,not-secret
```

Assuming a site admin has already been created, more users can be added with more details. If the username is missing but an email is specified, the email will also be used as username to sign in.

```csv
full_name,email,password
Claire Clark,claire@example.com,not-secret
Daniel Davis,daniel@example.com,not-secret
```

To have a user that exists but cannot sign in,add the `is_active` column but leave it empty. In this example, Emily will be able to sign in, while Felix will not:

```csv
username,is_active,password
emily,x,not-secret
felix,,not-secret
```
