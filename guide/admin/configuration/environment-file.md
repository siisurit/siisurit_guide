# Environment file

The environment file `.env` is a plain text file where each line sets an environment variable to a value. A hash (`#`) indicates a comment. Values can be put within double quotes. Values can refer to previously set environment variables using the syntax `${name}`.

Example:

```dotenv
# Example for plain values
FULL_NAME="Alice Adams"
FAVORITE_NUMBER=23

# Example for referring to other variables
GREETING="Hello ${FULL_NAME}, your favorite number is ${FAVORITE_NUMBER}"
```

For more information about this format refer to the [README](https://github.com/theskumar/python-dotenv/blob/main/README.md) of the dotenv project.

# Environment variables

## General

### SII_ENVIRONMENT (required)

The environment the application runs in to automatically configure basic settings. Possible values are:

- local - for local development
- ci - for continuous integration
- stage - for testing
- production - for production

### SII_ENV_FILE

The environment file from which to load the settings.

Default: `.env` in the current folder.

### SII_SECRET_KEY (required in production)

Key to use for computing random hashes.

To generate such a key, run:

```bash
python manage.py shell -c 'from django.core.management import utils; print(utils.get_random_secret_key())'
```

which will output something along the line of:

```
z^#8_gw6%m=3-%h=u6c5xm_^!xm!q-(9$b4t2vwn#s!cwu(w=4
```

### SII_ALLOWED_HOSTS

IP addressed and hostnames of allowed hosts as a single string. Multiple entries can be separated using a space or comma.

Default: Depends on the environment.

### SII_CORS_ALLOW_ALL_ORIGINS

For the moment, this must be `true` in case you want to access the backend using the Flutter frontend from any other host than localhost.

Default: True.

### SII_CSRF_TRUSTED_ORIGINS

IP addresses and hostnames of trusted origins for safe requests as described in [CSRF_TRUSTED_ORIGINS](https://docs.djangoproject.com/en/4.2/ref/settings/#csrf-trusted-origins). Multiple entries can be separated using a space or comma.

### SII_POSTGRES\*\*

Settings for PostgreSQL database:

- SII_POSTGRES_DATABASE: Defaults to "sii\_\<environment\>", e.g. "siisurit_local".
- SII_POSTGRES_HOST: Defaults to localhost.
- SII_POSTGRES_PASSWORD: Required for test and production, defaults to demo password in local and ci.
- SII_POSTGRES_PORT: Defaults to 5433 in local and 5432 in all other environments.
- SII_POSTGRES_USERNAME: Defaults to "postgres".

Optionally, a read-only report user to be used by external business intelligence or chart tools such as [Grafana](../../admin/installation/grafana.md) can be utilized. These environment variables just specify the report database. Before being able to access the database with this user, it [has to be created](../../admin/installation/sql-report-user.md).

- SII_POSTGRES_REPORT_PASSWORD
- SII_POSTGRES_REPORT_USERNAME

### SII_EMAIL\_\*

Settings for SMTP server to send emails as described in [Sending email](https://docs.djangoproject.com/en/4.2/topics/email/):

- SII_EMAIL_HOST: Defaults to "localhost"
- SII_EMAIL_PORT: Defaults to 1033 on local, 587 on production and 25 on all other environments.
- SII_EMAIL_USERNAME: Defaults to empty.
- SII_EMAIL_PASSWORD: Defaults to empty.

### SII_UUID_HOST

Internally, Siisurit uses [UUIDv7](https://www.rfc-editor.org/rfc/rfc9562.html#name-uuid-version-7) for unique identifiers of database entries. This essentially consists of a timestamp and a random number. This allows better cache prediction than other UUID versions, and reduces the probability of clashes compared to the fully random UUIDv4. However, different hosts can still generate the same UUID, although with a very low probability.

To guarantee uniqueness even across hosts, a host ID can be included (akin to UUIDv1, which includes the entire media access code (MAC) of the host).

Unlike UUIDv1, which contains the entire 64 bits for the MAC ID and consequently leaks information, the host ID is a number you can assign yourself. If you have multiple hosts with a separate Siisurit database on them, the recommendation is to give them a host ID of 1, 2, 3, and so on. The entire UUID will still be hard to guess, and in case the host database should be merged later on, you can be confident that they do not contain any clashing IDs.

For example:

```bash
SII_UUID_HOST=1
```

Default: 0.

The valid range is between 0 and 32,767.

## Job queue

!!! warning "Impeding job queue upgrade"

    Eventually Siisurit will switch to a more scalable and persistent job queue than the current one, which is based on thread pools. Consequently, these environment variables will change to match the improved capabilities.

### SII_USE_ASYNC_QUEUE

Specified whether scheduled tasks should be run asynchronously.

Defaults to true.

### SII_ASYNC_QUEUE_TIMEOUT_IN_SECONDS

If `SII_USE_ASYNC_QUEUE` is true, this specifies the timeout in seconds after which a background job should be considered to be failed.

Defaults to 900, which represents 15 minutes.

### SII_SENTRY_DSN

The DSN for a [Sentry](https://sentry.io) server various information should be sent to. If omitted or empty, no information is sent.

Example:

```dotenv
SII_SENTRY_DSN="https://0123456789abcdf@sentry.example.com/123"
```
