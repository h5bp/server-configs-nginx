# Choose between www and non-www, listen on the *wrong* one and redirect to
# the right one -- http://wiki.nginx.org/Pitfalls#Server_Name
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
  listen [::]:443 ssl spdy;
  listen 443 ssl spdy;

  # listen on the wrong host
  server_name www.example.com;

  include h5bp/directive-only/ssl.conf;

  # and redirect to the non-www host (declared below)
  return 301 https://example.com$request_uri;
}

server {
  listen [::]:443 ssl spdy;
  listen 443 ssl spdy;

  # The host name to respond to
  server_name example.com;

  include h5bp/directive-only/ssl.conf;

  # Path for static files
  root /var/www/example.com/public;

  #Specify a charset
  charset utf-8;

  # Custom 404 page
  error_page 404 /404.html;

  # Include the basic h5bp config set
  include h5bp/basic.conf;
}
