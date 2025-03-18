# Adding a Grafana panel

This section outlines how to add a panel for a Grafana dashboard based on one of Siisurit's [report database views](../report-views.md).

This assumes a properly configured [Grafana setup with a Siisurit datasource](../../admin/installation/grafana.md).

The finished panel should look something like this:

![Example Grafana panel showing a bar chart with monthly work per member in hours over multiple years](grafana-example-panel.png)

## Add a panel

For the general steps to add a new panel, see the chapter on [panels and visualization](https://grafana.com/docs/grafana/latest/panels-visualizations/) in the Grafana documentation.

## Time range

Chose "Last 1 year" or any number of months that make sense for your projects.

## Queries

- Data source: Siisurit report
- In Query A: Select "Code" and use the following SQL select:
  ```sql
  select
    date_trunc('month', started_at) as "Month",
    username,
    sum(duration_in_hours) as "Duration"
  from
    report.work
  group by
    1, 2
  order by
    1, 2
  ```

At this point, click "Run query" to check if it returns any data already. If not, import a project first before continuing. Otherwise, Grafana will be unable to provide meta information like result fields and types of queries.

## Transformations

Choose "Partition by values"

- Field: username
- Naming: As label
- Keep fields: Yes

## Visualization

Choose "Bar chart"

## Bar chart

- X Axis: Month (base field name)
- X-axis labels minimum spacing: Small
- Show values: Auto
- Stacking: Normal

## Panel options

Title: Monthly work per member \[h]

## Standard options

- Unit: leave empty

!!! note "Unit hack"

    Ideally, the unit would be "Time / hours(h)". Unfortunatelly, Grafana automatically converts larger numbers of hours to 24 hour days, which usually is not what you are interested in.

## Everything else

Keep the defaults or adjust as needed.
