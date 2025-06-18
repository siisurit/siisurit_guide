# find_similar_tasks

This command finds existing finished tasks similar to a specified description. For this to work, [update_search](update_search.md) must have been called recently.

## Example

To find similar tasks within all organizations and projects of the current server:

```bash
python manage.py find_similar_tasks "Add a login dialog with password reset"
```

To find similar tasks within the organizations and projects a member with the username "alice" has access to:

```bash
python manage.py find_similar_tasks --username alice "Add a login dialog with password reset"
```

To show more than the default 4 results:

```bash
python manage.py find_similar_tasks --max-results 10 --username alice "Add a login dialog with password reset"
```
