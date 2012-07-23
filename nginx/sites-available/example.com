# www to non-www redirect -- duplicate content is BAD:
# https://github.com/h5bp/html5-boilerplate/blob/5370479476dceae7cc3ea105946536d6bc0ee468/.htaccess#L362
# Choose between www and non-www, listen on the *wrong* one and redirect to
# the right one -- http://wiki.nginx.org/Pitfalls#Server_Name
server {
  # don't forget to tell on which port this server listens
  listen 80;
  # listen on the www host
  server_name www.example.com;

  # and redirect to the non-www host (declared below)
  return 301 $scheme://example.com$request_uri;
}

server {
  # listen 80 default_server deferred; # for Linux
  # listen 80 default_server accept_filter=httpready; # for FreeBSD
  listen 80 default_server;

  # listen on the non-www host -- the www-host is declared in www-redirect.conf
  # here
  server_name example.com;

  # Path for static files
  root /sites/example.com/public;

  #Specify a charset
  charset utf-8;

  # Custom 404 page
  error_page 404 /404.html;

  # Built-in filename-based cache busting
  # https://github.com/h5bp/html5-boilerplate/blob/5370479476dceae7cc3ea105946536d6bc0ee468/.htaccess#L403
  # This will route all requests for /css/style.20120716.css to /css/style.css
  # Read also this: github.com/h5bp/html5-boilerplate/wiki/cachebusting
  # This is disabled by default, because it'd be better if you use the build
  # script to manage the file names.
  # location ~* (.+)\.(\d+)\.(js|css|png|jpg|jpeg|gif)$ {
  #    try_files $uri $1.$3;
  # }

  # No default expire rule. This config mirrors that of apache as outlined in the
  # html5-boilerplate .htaccess file. However, nginx applies rules by location, the apache rules
  # are defined by type. A concequence of this difference is that if you use no file extension in
  # the url and serve html, with apache you get an expire time of 0s, with nginx you'd get an
  # expire header of one month in the future (if the default expire rule is 1 month).
  # Therefore, do not use a default expire rule with nginx unless your site is completely static

  # cache.appcache, your document html and data
  location ~* \.(?:manifest|appcache|html|xml|json)$ {
    expires -1;
    access_log logs/static.log;
  }

  # Feed
  location ~* \.(?:rss|atom)$ {
    expires 1h;
    add_header Cache-Control "public";
  }

  # Favicon
  location ~* \.ico$ {
    expires 1w;
    access_log off;
    add_header Cache-Control "public";
  }

  # Media: images, video, audio, HTC, WebFonts
  location ~* \.(?:jpg|jpeg|gif|png|ico|gz|svg|svgz|ttf|otf|woff|eot|mp4|ogg|ogv|webm)$ {
    expires 1M;
    access_log off;
    add_header Cache-Control "public";
  }

  # CSS and Javascript
  location ~* \.(?:css|js)$ {
    expires 1y;
    access_log off;
    add_header Cache-Control "public";
  }

  # opt-in to the future
  add_header "X-UA-Compatible" "IE=Edge,chrome=1";

  # Cross domain AJAX requests
  # add_header "Access-Control-Allow-Origin" "*";

  # Cross domain webfont access
  location ~* \.(ttf|ttc|otf|eot|woff|font.css)$ {
      add_header "Access-Control-Allow-Origin" "*";
  }

  # Prevent mobile network providers from modifying your site
  # add_header "Cache-Control" "no-transform";

  # Prevent clients from accessing hidden files (starting with a dot)
  location ~* (^|/)\. {
      return 403;
  }

  # Prevent clients from accessing to backup/config/source files
  location ~* (\.(bak|config|sql|fla|psd|ini|log|sh|inc|swp|dist)|~)$ {
      return 403;
  }
}
