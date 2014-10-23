[Nginx Server Configs homepage](https://github.com/h5bp/server-configs-nginx)
 | [Documentation table of contents](TOC.md)

# Hotlink Protection

Depending on how sensitive assets are, nginx offers a few options for protecting
assets.

## valid_referers

the simplest way to protect assets from hotlinking is to use
[valid_referers](http://nginx.org/en/docs/http/ngx_http_referer_module.html).
It's easy to use, this would be included in a relevant location block:

	valid_referers none blocked example.com *.example.com;
	if ($invalid_referer) {
		return 403;
	}

## secure_link

The [secure_link module](http://nginx.org/en/docs/http/ngx_http_secure_link_module.html)
provides a flexible, more robust means of protecting assets from being hotlinked or
downloaded outside from outside the web itself.

It is more involved to setup and use but, for example, permits time limited and
IP-restricted (or restricted on any other parameter desired) links to assets.

Example nginx config:

	secure_link $arg_md5,$arg_expires;
	secure_link_md5 "$secure_link_expires$uri$remote_addr secret";

	if ($secure_link = "") {
		# No get args, or invalid hash
		return 403;
	}

	if ($secure_link = "0") {
		# valid hash, but the link is now expired
		return 410;
	}

	if ($secure_link = "1") {
		# valid hash, and link is still fresh
		...
	}

This requires implementing server-side logic to generate links of the form:

    http://example.com/protected/url.ext?md5=hash&expires=timestamp

where:

	hash = md5({timestamp}/protected/url.ext{clientip} secret)

"secret" should be application-specific and needs to match in the nginx config,
and the function used to generate these secure urls
