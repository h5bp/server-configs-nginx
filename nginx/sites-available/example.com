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

  # The host name to respond to
  server_name example.com;

  # Path for static files
  root /sites/example.com/public;

  #Specify a charset
  charset utf-8;

  # Custom 404 page
  error_page 404 /404.html;

  # Include the component config parts for h5bp
  include conf/h5bp.conf;
}
