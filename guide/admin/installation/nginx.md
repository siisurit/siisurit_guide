# Nginx setup

[Nginx](https://nginx.org/), among other things, is a web server and reverse proxy. For Siisurit, nginx can be used to securely make the Siisurit services available via HTTPS under your preferred domain.

## Basic configuration

Assuming you already created a DNS entries for

- `backend.siisurit.example.com`
- `app.siisurit.example.com`

put the following configuration into `/etc/nginx/sites-available/siisurit.example.com.conf`:

```nginx
server {
    server_name app.siisurit.example.com;

    location / {
        proxy_pass http://127.0.0.1:8235;

        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Port $server_port;
        proxy_set_header X-Forwarded-Scheme $scheme;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-Real-IP $remote_addr;
    }

    access_log /var/log/nginx/access.log;
    error_log /var/log/nginx/error.log;
}

server {
    server_name backend.siisurit.example.com;

    location / {
        proxy_pass http://127.0.0.1:8234;

        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Port $server_port;
        proxy_set_header X-Forwarded-Scheme $scheme;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-Real-IP $remote_addr;
    }

    access_log /var/log/nginx/access.log;
    error_log /var/log/nginx/error.log;
}
```

Next, enable the configuration

```bash
sudo ln -s /etc/nginx/sites-available/siisurit.example.com.conf /etc/nginx/sites-enabled/
```

and reload it:

```bash
sudo systemctl reload nginx
```

Test that the insecure HTTP sites can be accessed (but do not sign in yet).

## Secure the website

In order to encrypt traffic to the Siisurit services using HTTPS, you can create a certificate using [certbot](https://certbot.eff.org/) and [Let's Encrypt](https://letsencrypt.org/):

````bash
```bash
sudo certbot --nginx --domain app.siisurit.example.com
sudo certbot --nginx --domain backend.siisurit.example.com
````

Not test that the secure HTTPS sites can be accessed. You can also sign in now because traffic between sites is encrypted.
