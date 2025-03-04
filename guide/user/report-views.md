# Report views

For advanced reporting, Siisurit provides SQL database views that can be accessed to generate charts and graphs using applications designed for reporting and business intelligence.

This chapter describes the available views and gives and example of accessing them using [Grafana](https://grafana.com/), which can easily be [integrated with an on-premis installation of Siisurit](../admin/installation/grafana.md).

## Available views

- `report_task`: Every task and details that can be represented in a single field.
- `report_work`: Every work entry that got assigned to a task, and the related details. This excludes work entries that could not be matched to any task.
- `report_assignee`: All tasks and their assignees. This excludes tasks that have no assignee.
- `report_contribution`: How much work a specific member contributed to a certain task. This only includes tasks and members that actually contributed time.
- `report_unmatched_work`: Work entries that could not be matched to any task in any project. This might indicate that your transfers include data you don't need, or that your work matches are incomplete.
