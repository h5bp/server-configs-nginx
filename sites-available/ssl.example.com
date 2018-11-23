# Choose between www and non-www, listen on the *wrong* one and redirect to
# the right one -- https://www.nginx.com/resources/wiki/start/topics/tutorials/config_pitfalls/#server-name-if
#
server {
  listen [::]:80;
  listen 80;

  # listen on both hosts
  server_name example.com www.example.com;

  # and redirect to the https host (declared below)
  # avoiding http://www -> https://www -> https:// chain.
  return 301 https://example.com$request_uri;
}

server {
  listen [::]:443 ssl http2;
  listen 443 ssl http2;

  # listen on the wrong host
  server_name www.example.com;

  include h5bp/security/ssl_policy.conf;

  # and redirect to the non-www host (declared below)
  return 301 https://example.com$request_uri;
}

server {

  # listen [::]:443 ssl http2 accept_filter=dataready;  # for FreeBSD
  # listen 443 ssl http2 accept_filter=dataready;  # for FreeBSD
  # listen [::]:443 ssl http2 deferred;  # for Linux
  # listen 443 ssl http2 deferred;  # for Linux
  listen [::]:443 ssl http2;
  listen 443 ssl http2;

  # The host name to respond to
  server_name example.com;

  include h5bp/security/ssl_policy.conf;

  # Path for static files
  root /var/www/example.com/public;

  # Custom 404 page
  error_page 404 /404.html;

  # Include the basic h5bp config set
  include h5bp/basic.conf;
}
