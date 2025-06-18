# update_search

This command updates the information used by [find_similar_tasks](find_similar_tasks.md) to find tasks that are similar to a given description.

!!! note "Performance"

    Building a vector database for a large amount of tasks can take a while. As a rough estimate, using gemma3:4b processing around 1000 tasks takes about 2 minutes on a modern GPU, and about 10-20 times as long using a CPU.

## Example

To prepare all tasks of the organization with the code `demo-inc` and the project with the code `some-project`, run:

```bash
python manage.py update_search demo-inc some-project
```
