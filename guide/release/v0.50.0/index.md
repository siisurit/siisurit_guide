# v0.50.0

## Simplified deployment

The Flutter frontend has been replaced with a Django frontend using HTML templates and [Bootstrap 5](https://getbootstrap.com/). Additionally, the HTTP server moved from gunicorn to [granian](https://github.com/emmett-framework/granian). The advantages of this are:

- More powerful charts based on [plotly-express](https://plotly.com/python/plotly-express/). In particular, you can now choose the time frame shown in respective charts.
- Improved performance because not more translating data for the REST API.
- Simplified deployment: There is only a single container holding both the Django backend and the frontend.
- Simplified reverse proxy configuration: Because static files are now served directly from inside the container, to locations have to be added to the reverse proxy configuration.

This means both the configuration file for nginx and the `compose.yaml` are smaller.

As a drawback, the current user interface looks less nice than the Flutter one. It should gradually improve over time, though.

See the example `compose.yaml` in the chapter about [docker installation](../../admin/installation/docker.md) for what to change. Essentially:

- In the backend container:
  - Change `gunicorn` to `granian` including the parameters.
  - Add `ports`.
- Remove the `frontend` container.

If you are using nginx as a reverse proxy to serve your domain and add HTTPS as suggested in the chapter about [nginx setup](../../admin/installation/nginx.md), apply the new template. Essentially, it consolidates two domains into one.
