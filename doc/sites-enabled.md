[Nginx Server Configs homepage](https://github.com/h5bp/server-configs-nginx)
 | [Documentation table of contents](TOC.md)

# Sites enabled

Files in this folder **are** loaded automatically. The intended purpose of
this folder is to contain symlinks to the folder `sites-available`.

## Enabling a new site

To enable a new site, link the config file to sites-enabled, and restart nginx.

For example:

	$ cd /etc/nginx/sites-available

	... create newproject.com ...

	$ cd /etc/nginx/sites-enabled
	$ ln -s ../sites-available/newproject.com .

	$ /etc/init.d/nginx reload
	[....] Reloading nginx configuration: nginx.
	$

## Disabling a site

To disable a site, remove the symlink from the sites-enabled folder, and restart
nginx.

For example:

	$ cd /etc/nginx/sites-enabled
	$ rm newproject.com

	$ /etc/init.d/nginx reload
	[....] Reloading nginx configuration: nginx.
	$

