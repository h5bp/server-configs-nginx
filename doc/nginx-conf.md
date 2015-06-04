[Nginx Server Configs homepage](https://github.com/h5bp/server-configs-nginx)
 | [Documentation table of contents](TOC.md)

# Nginx.conf

The `nginx.conf` file is the main config file for nginx, which either defines
or includes the whole configuration for the server.

When editing or defining an nginx configuration file - take care to note in
which [context](http://nginx.org/en/docs/beginners_guide.html#conf_structure)
a directive applies.

Below are some notes on a few of the more important/commonly-edited directives.
For detailed information on any particular directive, please see
[the official documentation](http://nginx.org/en/docs/).

## user

The [user directive](http://nginx.org/en/docs/ngx_core_module.html#user)
indicates which user the server will run as. This is typically a user
specifically for web usage such as "www" "www-data".

The webserver user, and file permissions for any application, should be defined/chosen
following [the principle of least privilege](http://en.wikipedia.org/wiki/Principle_of_least_privilege)
i.e., sufficient privileges to function correctly but no more than that.

## worker_processes

The [worker_processes directive](http://nginx.org/en/docs/ngx_core_module.html#worker_processes)
broadly defines the number of connections nginx can process.

As of version 1.2.5+ and 1.3.8+, nginx supports the value "auto" which will
automatically detect an appropriate value. In earlier versions setting to
the number of CPUs is a good default/starting point.

## error_log

The [error_log directive](http://nginx.org/en/docs/ngx_core_module.html#error_log)
can be defined/overriden in any context. The directive in the main context
defines the log file to use unless otherwise overriden (at http, server or location
level). This must point to a location writable to the webserver user.

The location for log files varies depending on the operating system; one technique
to allow the config files to be ignorant of this is to symlink `/etc/nginx/logs`
to where you would like log files to be located. e.g.:

    mkdir /var/log/nginx
    cd /etc/nginx
    ln -s /var/log/nginx logs

## pid

The [pid directive](http://nginx.org/en/docs/ngx_core_module.html#pid) is used
by nginx to store the process id of the main process. This must point to a writable
location.
