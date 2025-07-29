# v0.48.0

## Simplified user mapping

By default, users are mapped automatically provided the external's user email or username matches with a Siisurit user with an existing organization profile at the same organization as the tracker. This case should be common inside companies, where people use the same email and username withing different systems.

To keep using the previous behavior, where users with a specific `external_username_to_username` mapping where mapped to the organization default user, set `fallback: "default"`, for example:

```yaml
user_mapping:
  - name: "example.com"
  - fallback: "default" # Map unknown users from external trackers to the organization's default user.
```

## Change the task screen to endless scroller

The task screen uses an endless scroller. In the case of many tasks, the view is faster to display the initial batch of tasks now.

## Improved tool tips for stacked bar charts

The tooltips for stacked bar charts now show the values for each stack separately instead of just the sum. Also, floating points numbers are formatted nicely now instead of just dumping all the digits.

## Automatic removal of the oldest token

If a user activates too many authentication tokens at the same time, the oldest token is automatically removed. This prevents later signin errors that could only be fixed by signing in to the admin site and manually removing a token.

## Add experimental model context protocol (MCP) server

In local, Siisurit now acts as MCP server via the url `http://localhost:8033/mcp`. Currently, the number of available tools is limited, but can already be used to process requests like

> Print the heading and work in hours of the task with the most work in hours.

using an MCP client.

## Improved documentation

The user guide now includes chapters to [configure connectors](https://guide.siisurit.com/user/connectors/).
