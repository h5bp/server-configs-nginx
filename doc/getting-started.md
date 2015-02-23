[Nginx Server Configs homepage](https://github.com/h5bp/server-configs-nginx)
 | [Documentation table of contents](TOC.md)

# Getting started

Using the Nginx server configs repo directly has a few required steps to be able to work.

## Check `nginx.conf` settings

The first thing to check is that the `nginx.conf` file contains appropriate values for
your specific install. The web user varies with distribution, in most cases compare to
the config file originally present, and use the same user:

    // /etc/nginx-original/nginx.conf
    user www-data www-data;

Apply to the runtime config file:

    // /etc/nginx/nginx.conf
	#user www www;
	user www-data www-data;

## Configure logs and pid file

The location of logs also varies from system to system. To account for this the `nginx.conf`
file uses a relative path for logs:

    // /etc/nginx/nginx.conf
    error_log logs/error.log warn;

There are two options to configure this appropriately, change the path to point at the folder
where logs should be stored:

    // /etc/nginx/nginx.conf
    error_log /var/log/nginx/error.log warn;

And:

    // /etc/nginx/h5bp/expires.conf
    access_log logs/static.log;

To:

    // /etc/nginx/h5bp/expires.conf
    access_log /var/log/nginx/static.log;

Or, setup a symlink to point at the right place:

    cd /etc/nginx
    ln -s /var/log/nginx logs

The location of the pid file should also be checked and corrected if necessary.

## Creating a site definition

An example server definition is provided in `sites-available/example.com`. Copy the file to
`sites-available/yourdomainname.com` and edit appropriately. Verify specifically that
the hostname (`example.com`) and the root are specified correctly.

## Enabling a site

Activate the new site by linking `yourdomainname.com` into the `sites-enabled` directory:

    cd /etc/nginx/sites-enabled
    ln -s ../sites-available/yourdomainname.com .

This will make the server active the next time nginx (re)starts.

## Verify config and restart nginx
Verify the config and restart nginx to apply the changes.

To verify nginx config (Tests default nginx config file)

	nginx -t 

**OR**

To verify a particular nginx config file
	
	nginx -t -c nginx.conf	
	
This will test the nginx config file and throws error if any. Otherwise test is successful and you can restart nginx.

Finally reload nginx to apply the changes.
	
	/etc/init.d/nginx reload
