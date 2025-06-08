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

- `source_work_trackers`: A list of names of source work tracker containing the work entries that should be matched with tasks in the current task tracker.

- `priority`: If a tracker has multiple matches, they are attempted by priority. Matches with a higher priority are attempted first. If a match does apply to a work entry, it is skipped and the next match according to its priority is attempted. Once a match has been found, any further matches for the work entry are ignored.
  If multiple matches have the same priority, the order of declaration applies.

## Work match kinds

### `always_to_task`

always match to a specific task

Example:

```yaml
- match_on: always_to_task
  source_work_trackers: demo-kimai
  target_task: "#123"
  priority: 1
```

### `external_task_id_to_task_external_id`

interpret the external ID stored in the work entry as external ID of a task in the task tracker

### `external_task_id_to_task_url`

interpret the external ID stored in the work entry as URL to a task in the task tracker; this would typically be the URL one would use to view the task in a web browser

### `pattern_to_task`

if the regular expressions for text and breadcrumb trail match, map the work entry to a specific task

### `pattern_to_task_code`

if the regular expressions for text and breadcrumb trail of the work entry match, map it to the task with its `code` matching the value extracted with the named group `task_code`
