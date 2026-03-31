# make_users

Add or update users from CSV-file.

## Examples

Create a [user list](../configuration/user-list.md) with an admin, a project manager and developer, and store it in `users.csv`:

```csv
username,password,is_staff,is_superuser,name,email
admin_aadams,${SII_DEV_DEMO_PASSWORD},x,x,Alice Adams (Admin),alice@example.com
bbuilder,${SII_DEV_DEMO_PASSWORD},,,Ben Builder,ben@example.com
mmanager,${SII_DEV_DEMO_PASSWORD},x,,Mary Manager,mary@example.com
```

Then import them by running:

```bash
pyhton manage.py make_users users.csv
```

## Positional arguments

- `CSV-FILE`: CSV file containing user information

## Options

- `--delimiter DELIMITER`, `-d DELIMITER`: delimiter between columns in CSV file; default: ,
- `--encoding ENCODING`, `-e ENCODING`: character encoding of the CSV file; default: utf-8
- `--update-existing`, `-U`: Ff the user already exists, overwrite existing data including password. The identifying criteria is the username.
