[Nginx Server Configs homepage](https://github.com/h5bp/server-configs-nginx)
 | [Documentation table of contents](TOC.md)

# Common Problems

## types_hash errors

Depending on the server architecture, it's possible to get the following error:

> could not build the types_hash, you should increase either
> types_hash_max_size: 1024 or types_hash_bucket_size: 32

Nginx uses [hash tables](http://nginx.org/en/docs/hash.html) to speed up certain
tasks, usually the default value is sufficient but depending on the actual server
config this error might be encountered. The solution is to do exactly what the
error message suggests, by adding to nginx.conf the following:

    # add this to the http context
    types_hash_max_size: 1024;

    ## OR add this to the http context, don't need both
    # types_hash_bucket_size: 32

## Only some rules are being applied

Nginx only uses one location block when processing a request.

A direct concequence of this is that if, either directly or via include
statemtents, directives are defined like so:

	# Make sure js files are served with a long expire
	location ~* \.js$ {
		add_header "section" "long expire"; # for illustration only
		expires 1y;
	}

	# Oh, and kill etags for js files
	location ~* \.js$ {
		add_header "section" "no etags"; # for illustration only
		etag off;
	}

_the section headers are only to demonstrate which location blocks applied to a
particular request_.

Only ONE of these location blocks will be used:

	$ curl -I "http://nginx.h5bp.dev/js/main.js"
	HTTP/1.1 200 OK
	Server: nginx
	Date: Thu, 23 Oct 2014 09:58:47 GMT
	Content-Type: application/javascript; charset=utf-8
	Content-Length: 1
	Last-Modified: Tue, 29 Oct 2013 15:17:17 GMT
	Connection: keep-alive
	ETag: "526fd17d-1"
	Expires: Fri, 23 Oct 2015 09:58:47 GMT
	Cache-Control: max-age=31536000
	section: long expire
	Accept-Ranges: bytes

The way to achieve the desired effect is to consolidate all rules into one
location block:

	location ~* \.js$ {
		# Make sure js files are served with a long expire
		add_header "section" "long expire"; # for illustration only
		expires 1y;
		add_header "section" "no etags"; # for illustration only
		etag off;
	}

Which would then yield:

	$ curl -I "http://nginx.h5bp.dev/js/main.js"
	HTTP/1.1 200 OK
	Server: nginx
	Date: Thu, 23 Oct 2014 10:00:22 GMT
	Content-Type: application/javascript; charset=utf-8
	Content-Length: 1
	Last-Modified: Tue, 29 Oct 2013 15:17:17 GMT
	Connection: keep-alive
	Expires: Fri, 23 Oct 2015 10:00:22 GMT
	Cache-Control: max-age=31536000
	section: long expire
	section: no etags
	Accept-Ranges: bytes

## Cannot dynamically serve <file extension> requests

It might be expected that a request for a file that does not exist
will always reach the backend application - but this is not necessarily
the case.

Using php as an example, here is a simple example config:

	server {
		listen 80;
		server_name example.com;
		root /var/www/example.com;

		location / {
			try_files $uri $uri/ /index.php;
		}

        location ~ \.php$ {
			fastcgi_pass 127.0.0.1:9000;
			fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
			include fastcgi_params;
        }
	}

With the above config, a request for `/css/main.css`, assuming the file exists,
would be served directly by nginx whereas a request for `/application/user.css`
would be processed by php.

It is tempting to add h5bp's basic ruleset by simply appending it in
the server context:

	server {
		listen 80;
		server_name example.com;
		root /var/www/example.com;

		location / {
			try_files $uri $uri/ /index.php;
		}

        location ~ [^/]\.php(/|$) {
			fastcgi_split_path_info ^(.+?\.php)(/.*)$;
			if (!-f $document_root$fastcgi_script_name) {
					return 404;
			}

			fastcgi_pass 127.0.0.1:9000;
			fastcgi_index index.php;
			include fastcgi_params;
        }

		# ADDED
		include h5bp/basic.conf;
	}

The result in this case would be `/css/main.css`, assuming the file exists,
is served with headers defined by h5bp's basic ruleset whereas `/application/user.css`
will be a 404. The reason for this is that H5bp's basic ruleset includes, for example:

	location ~* \.(?:jpg|jpeg|gif|png|ico|cur|gz|svg|svgz|mp4|ogg|ogv|webm|htc)$ {
		expires 1M;
		access_log off;
		add_header Cache-Control "public";
	}

Which will _also_ capture any dynamic requests matching that url pattern and not
hand the request to the php application in the event of an error.

There are 3 basic strategies to resolve this:

## Define error_page in each location block

Modifying (all) location blocks as follows:

	location ~* \.(?:jpg|jpeg|gif|png|ico|cur|gz|svg|svgz|mp4|ogg|ogv|webm|htc)$ {

		error_page 404 = /index.php;

		expires 1M;
		access_log off;
		add_header Cache-Control "public";
	}

Will make Nginx pass requests for files that don't exist to the application.

## Use prefix routing

Prefix routing is always preferred - if there is a common path for static files
this can be used to reduce the scope of any included rules:

	server {
		listen 80;
		server_name example.com;
		root /var/www/example.com;

		location / {
			try_files $uri $uri/ /index.php;
		}

        location ~ \.php$ {
			fastcgi_pass 127.0.0.1:9000;
			fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
			include fastcgi_params;
        }

		# ADDED. Apply only to the css, js and images folder
		location ~ ^/(css|images|js)/ {
			include h5bp/basic.conf;
		}
	}

## Change to use a 404 front-controller

Instead of using try_files alone, change the server config such that the
application is the 404 page:

	server {
		listen 80;
		server_name example.com;
		root /var/www/example.com;

		try_files $uri $uri/ @app;
		error_page 404 = @app;

        location @app {
			include fastcgi_params;
			fastcgi_pass 127.0.0.1:9000;
			fastcgi_param   SCRIPT_FILENAME     $document_root/index.php;
			fastcgi_param   SCRIPT_NAME         $document_root/index.php;
			fastcgi_param   DOCUMENT_URI        /index.php;
			fastcgi_index index.php;
        }

		# ADDED.
		include h5bp/basic.conf;
	}

_with this kind of setup it's necessary to explicitly define the php filename_.

In this way after nginx has tried to serve a (none existant) static file, it
will pass the request to the php application successfully.
