[Nginx Server Configs homepage](https://github.com/h5bp/server-configs-nginx)
 | [Documentation table of contents](TOC.md)

# The h5bp folder

This directory contains config snippets (mixins) to be included as desired.

There are two types of config files provided, individual config snippets and
combined config files which provide convenient defaults.

## basic.conf

This file loads a small subset of the rules provided by this repository to add
expires headers, allow cross domain fonts and protect system files from web
access.

## location folder

Files in this folder contain one or more location directives. They are intended
to be loaded in the server context (or, in a nested location block).

### cache-busting.conf

URL-based cache busting. This will route all requests of the form
`/css/style.20120716.css` to `/css/style.css`

Note that this file cannot/should not be used if any other location directives
use the same/overlapping URL patterns.

### cross-domain-fonts.conf

This file contains headers for allowing cross-domain webfont requests.

Note that this file cannot/should not be used if any other location directives
use the same/overlapping URL patterns.

### expires.conf

This file contains some typical expire rules for use with static files.

Note that this file cannot/should not be used if any other location directives
use the same/overlapping URL patterns.

### protect-system-files.conf

This file prevents access to hidden files and common backup/config/source files.

## directive-only folder

Files in this folder only contain directives, the context in which they apply
varies from file to file - be sure to check the official documentation to
include in the appropriate context.

### cache-file-descriptors.conf

This tells Nginx to cache open file handles, "not found" errors, metadata about
files and their permissions, etc.

This allows Nginx to respond immediately when a common file is requested. Note
however that this also means that changes to files are not reflected immediately,
and is most appropriate for use on server where file contents do not change,
or the server is reloaded when they do.

### cross-domain-insecure.conf

This file adds the `Access-Control-Allow-Origin` header permitting global access.
Depending on the use case it maybe be more appropriate to use a more restrictive
header to permit only a finite list of domains to make AJAX requests.

### no-transform.conf

[No transform headers](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.9.5)
 prevent mobile providers from modifying/optimizing served content. This file
contains the directive only and should be included only when it is specifically
desired for the server response to remain unmodified.

Note that adding this header to responses will also prevent `nginx_pagespeed`,
if used, from optimizing HTML responses.

### ssl.conf

This file contains sane-default config for setting up nginx to handle SSL traffic.

### ssl-stapling.conf

[OCSP staping](http://en.wikipedia.org/wiki/OCSP_stapling) relates to handling
the revocation of SSL certificates, this config file turns on stapling using
Google's DNS resolver.

### x-ua-compatible.conf

This adds a header to force internet explorer to use the highest mode available.
As of [Internet explorer version 11 this is no longer necessary](http://msdn.microsoft.com/en-us/library/ie/bg182625.aspx#docmode).
