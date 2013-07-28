Sites Enabled
-------------

Symlink to `../sites-available/` for any site you want to enable. Conversely, remove the symlink
in this folder to disable a site without permanently deleting the site's configuration.

E.g. (we suppose your nginx configuration files are stored in `/etc/nginx`)
```sh
    $ pwd
      --> /etc/nginx
    # ln -s /etc/nginx/sites-available/example.com sites-enabled/example.com
```
