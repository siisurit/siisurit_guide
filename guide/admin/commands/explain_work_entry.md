# explain_work_entry

The `explain_work_entry` helps with unterstanding why certain work entries were matched (or not) to a specific task. It prints details about work entries to the console in JSON format about:

- the work entry itself,
- related work mappings that could actually be matched (if any),
- related work matches that could be used to match the work entry to a task tracker.

## Examples

To explain a specific work entry:

```bash
python manage.py explain_work_entry --id 12345678-1234-1234-1234-1234567890ab
```

To explain the 3 most recent work entries of a user:

```bash
python manage.py explain_work_entry --max-count 3 --username someone
```

To explain all work entries within a certain time range:

```bash
python manage.py explain_work_entry --started-from "2025-06-01 08:10:15+02:00" --started-until "2025-06-01T08:12:30Z"
```
