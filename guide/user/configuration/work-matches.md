# Work matches

Work matches define rules on how to match work entries in a work track with tasks in a task tracker. There are different kinds of matches that can for example map work entries based on their breadcrumb and text, or a reference to an external URL.

## Matching projects

To actually match a project, a project admin can use the "Update project" button in the app. Or, a site admin can run the management command [match_project](../../admin/commands/match_project.md) or [update_project](../../admin/commands/update_project.md).

## General structure

Work matches are attached to task trackers. In the config file, work matches are located at in `organization` → `projects` → `trackers` → `work_matches`.

They can have the following attributes:

- `match_on`: How to perform the match. This can be on of the following values:

  - `always_to_task`: always match to a specific task
  - `external_task_id_to_task_external_id`: interpret the external ID stored in the work entry as external ID of a task in the task tracker
  - `external_task_id_to_task_url`: interpret the external ID stored in the work entry as URL to a task in the task tracker; this would typically be the URL one would use to view the task in a web browser
  - `pattern_to_task`: if the regular expressions for text and breadcrumb trail match, map the work entry to a specific task
  - `pattern_to_task_code`: if the regular expressions for text and breadcrumb trail of the work entry match, map it to the task with its `code` matching the value extracted with the named group `task_code`

  For details, see section "[Work match kinds](#work-match-kinds)".

- `source_work_trackers`: A list of source work tracker names containing the work entries that should be matched with tasks in the current task tracker.

- `priority`: If a tracker has multiple matches, they are attempted by priority. Matches with a higher priority are attempted first. If a match does apply to a work entry, it is skipped and the next match according to its priority is attempted. Once a match has been found, any further matches for the work entry are ignored.
  If multiple matches have the same priority, the order of declaration applies.

## Kinds of work matches

### Always

This always matches to a specific task. Such matches are most useful as last in a list with the lowest priority. The target task typically represents a fallback task like "Various activities" to match only in case nothing else did.

Example:

```yaml
- match_on: always_to_task
  source_work_trackers: demo-kimai
  target_task: "#123"
  priority: 1
```

Without an `always_to_task` match, any work entries that do not match anything else are silently ignored.

Therefore, it is generally recommended to have an always-match at the end of your work match chain that matches to a "Various activities" task. This ensures that everything worked on in your project is accounted for.

### External task ID

Interpret the external ID stored in the work entry as external ID of a task in the target task tracker and match to it.

This is intended for work trackers, which have their own internal task management. There, a task can have an external ID linking to a corresponding task in the target task tracker. Then the work tracker's API adds this information to every work entry related to a work tracker's internal task.

Example:

```yaml
- match_on: external_task_id_to_task_external_id
  source_work_trackers: demo-kimai
  priority: 100
```

### External task URL

Interpret the external ID stored in the work entry as URL to a task in the task tracker. This would typically be the URL one would use to view the task in a web browser.

This is intended for work trackers, which have their own internal task management. There, a task can have an external URL to link to a corresponding task in the target task tracker. Then the work tracker's API adds this information to every work entry related to a work tracker's internal task.

```yaml
- match_on: external_task_id_to_task_url
  source_work_trackers: demo-kimai
  priority: 100
```

### Pattern to task

If the regular expressions for text and breadcrumb trail match, map the work entry to a specific task.

This is intended to match work entries with general texts like "project management" to a specific task dedicated to this.

In combination with manually created tasks, this also allows bringing structure into otherwise completely unstructured work entries. Even if the project or organization does not use a task tracker at all.

```yaml
- match_on: pattern_to_task
  source_work_trackers: demo-kimai
  text_pattern: "(?i).*(daily|project management).*"
  target_task: "#1"
  priority: 2
```

### Pattern to task code

If the regular expressions for text and breadcrumb trail of the work entry match, map it to the task with its `code` matching the value extracted with the named group `task_code`.

The named group takes the form `(?P<task_code>...+)` with the `...` representing the pattern to match a task code. Patterns for common task trackers are:

- GitHub: `#\\d`, meaning a hash (`#`) followed by digits, matching, for example #123.
- GitLab: `[#!]\\d`, meaning a hash (`#`) for issues or an exclamation mark (`!`) followed by digits. This matches, for example, #123 or !321.
- Jira or Youtrack: In general, `[A-Z][A-Z0-9]{2}-\\d`, or for a project with the shortname `ABC`, a more specific `ABC-\\d`. This matches the shortname, followed by a hyphen (`-`) and the task number. For example, ABC-123.

Notice the double backslash (`\\`), which is necessary to YAML-escape the actually single backslash in the regular expression.

This kind of pattern can be used either for the text or the breadcrumb_trail.

Either the breadcrumb trail or text can be empty, which means that it always matches. But then the other part must have a named group for the task code.

The description of a work entry can match the pattern but then refer to a task that does not exist (yet). For example, a member might intend to refer to the task #123, but mistypes it as #213 in a project with such far only 150 tasks. In this case, the work entry does not match at all.

Example:

```yaml
- match_on: pattern_to_task_code
  source_work_trackers: demo-kimai
  priority: 100
  text_pattern: "^(?P<task_code>#\\d+).*"
```

Alternatively, the breadcrumb trail can be used to match:

```yaml
- match_on: pattern_to_task_code
  source_work_trackers: demo-kimai
  priority: 100
  breadcrumb_trail_pattern: "^(?P<task_code>#\\d+).*"
```

Both patterns can be set at the same time, but only one can have the named group for the task code:

```yaml
- match_on: pattern_to_task_code
  source_work_trackers: demo-kimai
  priority: 100
  breadcrumb_trail_pattern: "^BestApp / Marketing.*"
  text_pattern: "^(?P<task_code>#\\d+).*"
```
