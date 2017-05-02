Sites Available
---------------

Define host definitions here.
It'd be a good thing if you keep your hosts indexed by domain name, eg:

```
example.com (handles traffic from both www.example.com and example.com)
foobar.com (as above)
test.foobar.com (handles traffic from both www.test.foobar.com and test.foobar.com)
```
The HTTPS no-default server config requires a valid certificate (self signed will suffice).
One can generate the certificate with: 
```
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt
```

