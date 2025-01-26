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

❓TODO: #6 Add environment variables
