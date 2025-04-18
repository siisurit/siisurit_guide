# Organization setup

Now that the Siisurit is up and running, it's time to set up an organization and a project.

## Organization and project configuration:

First, we need an [organization configuration](../../user/configuration/organization-configuration.md).

Here is an `example-organization.yaml` you can use as basis for your own organization:

```yaml
organization:
  name: Example LCC
  code: example
  timezone: Europe/Vienna

  organization_profiles:
    - username: alice
    - username: bob
    - username: claire
    - username: daniel

  user_mappings:
    - name: "kimai.example.com"
      external_usernames_to_username:
        - external_username: "alice"
          username: alice
        - external_username: "bob"
          username: bob
        - external_username: "claire"
          username: claire
        - external_username: "daniel"
          username: daniel
    - name: "github.com"
      external_usernames_to_username:
        - external_username: "alice"
          username: alice
        - external_username: "bob"
          username: bob
        - external_username: "claire"
          username: claire
        - external_username: "daniel"
          username: daniel

  projects:
    - code: example-app
      name: Example project to develop an app

      trackers:
        - name: example-kimai
          api_kind: kimai
          api_location: "https://kimai.siisurit.com/en/admin/customer/4/details"
          api_token: ${SII_EXAMPLE_KIMAI_TOKEN}
          user_mapping: "kimai.siisurit.com"

          tasks:
            - title: "Various"
              code: various
              estimates: 0
            - title: Projectmanagement
              code: pm
              estimates: 100
          work_matches:
            - match_on: pattern_to_task_code
              source_work_trackers:
                - example-kimai
              priority: 100
              text_pattern: "^(?P<task_code>#\\d+).*"
            - match_on: pattern_to_task
              source_work_trackers: demo-kimai
              text_pattern: "(?i).*(daily|project management).*"
              target_task: pm
              priority: 1
            - match_on: always_to_task
              source_work_trackers: example-kimai
              target_task: various
              priority: 1
```

Notice that in our case, the organization has the code "example":

```yaml
organization:
  name: Example LCC
  code: example # <-- The code to remember
```

For your own organization, this will be different. Remember this code because we need it to update projects:

But first, lets import this organization by running the [update_organization](../commands/updape_organization.md) management command:

```bash
docker compose exec backend python manage.py update_organization /mnt/config/demo-organization.yaml
```

After changing the organization configuration file, this command has to be run again to import the changes.

To completely remove and organization and all data associated with it, use the [remove_organization](../commands/remove_organization.md) management command.

## Updating projects

To finally obtain data about projects from your task and time trackers, run the [update_project](../commands/update_project.md) management command. This takes the code of an organization as parameter, which is the organization all projects will be updated for. You can limit this to a single project by using the project's code.

With our example organization configuration from above, the organization has the code "example". The project has the code "example-app". To update all trackers of this project, run:

```bash
docker compose exec backend python manage.py update_project example example-app
```

Because `update_project` remembers the last downloaded data in a cache, running it again might not make it download newer data. If you want to make sure that the most current data are obtained from the task and time trackers, clear this cache first using the [clear_caches](../commands/clear_caches.md) management command:

```bash
docker compose exec backend python manage.py clear_caches
```
