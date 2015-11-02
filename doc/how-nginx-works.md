[Nginx Server Configs homepage](https://github.com/h5bp/server-configs-nginx)
 | [Documentation table of contents](TOC.md)

# How Nginx works

If you're familiar with any other webserver, some aspects of
[the way Nginx works](http://nginx.org/en/docs/http/request_processing.html)
 can cause confusion. This document aims to highlight differences or features
which may trip up new users.

## Nginx will only use one location block

A [location block (directive)](http://nginx.org/en/docs/http/ngx_http_core_module.html#location)
defines the behavior for a given request which matches the location url pattern. The block used
is whichever is the most specific for the given request, the rules for
precedence can be found in [Nginx's wiki](http://wiki.nginx.org/HttpCoreModule#location).

It is very important when writing nginx configuration files to understand that
only one location block will be used by Nginx. When in doubt a useful technique
to identify which location block is to add a header:

	# Make sure js files are served with a long expire
	location ~ /something {
		add_header "section" "something location";

		...
	}

	location /something-else {
		add_header "section" "something else location";

		...
	}

In the headers for a response, the header added from the block which matched
will be included:

	$ curl -I "http://nginx.h5bp.dev/something"
	...
	section: something location

There are some significant consequences to this behavior such as it _not_ being
possible to build configuration files from small, overlapping, location blocks.

## try_files in the server context does not always apply

Consider the following server block:

	server {
		listen 80;
		server_name example.com;
		root /var/www/example.com;

		try_files $uri $uri/ /fallback.html;

		location ~ ^/somefolder {
			...
		}

	}

It might be expected that a request for `http://example.com/somefolder/doesnt-exist`
would result in the contents of `/fallback.html` - but this is not the case. the
`try_files` directive in the server context _only applies if no location block
matches_, it is not a default which location blocks inherit.

