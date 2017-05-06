2.0.0 (2017-05-06)
------------------

- V2.0.0. [AD7six]

- Add defaults to all directives in nginx.conf. [Andy Dawson]

  The reason most of these are changed is already covered by the existing
  doc block

  closes #127


- Updated gzip_types and charset_types. [Tobias Reich]

  … both are now using the same coding convention. Each type in its own row and `text/html` comment at the top (where all comments are placed).

- Added mime types for JPEG-XR, markdown, and CSV. [JoeArizona]

  JPEG-XR: http://www.iana.org/assignments/provisional-standard-media-types/provisional-standard-media-types.xhtml
  Markdown: https://tools.ietf.org/html/rfc7763
  CSV: https://tools.ietf.org/html/rfc7111

- Removed SPDY support as we're using HTTP/2 now.  Ref: df102c6.
  [Pentago]

- Don't need that expires. [Andy Dawson]

- Remove cache-control public and better handle svgz files. [Matthew
  Miller]

  Fixes: #86

  Fixes: #134


- Don't use expire headers in doc examples. [Andy Dawson]

- Use Cache-Control max-age instead of Expires headers. [Alan Orth]

  Cache-Control max-age was introduced in HTTP/1.1 over ten years ago
  and is preferred to Expires. This replaces all expiry dates with an
  equivalent max-age in seconds.

  See: https://developers.google.com/web/fundamentals/performance/optimizing-content-efficiency/http-caching
  See: https://www.mnot.net/blog/2007/05/15/expires_max-age


- Remove references to Cache-Control public. [Alan Orth]

  A previous commit removed some, but missed these. Where a location
  directive was using Expires to set a future expiry in conjunction
  with Cache-Control public, I have replaced the time with an equal
  max-age.

  Furthermore, Google's web performance guide says that "public" is
  implicit if there is a max-age specified.

  See: https://developers.google.com/web/fundamentals/performance/optimizing-content-efficiency/http-caching


- Enable IPv6 for no-default. [Johannes Müller]

- Remove Unnecessary Trailing Semicolon. [0ri0n]

  No need to add a semicolon for the last directive. In addition, having that unnecessary semicolon causes the HSTS tool (https://hstspreload.org/) for getting on the preload list to fail with an error about the semicolon.

- Update ssl_ciphers To Latest Mozilla Intermediate. [0ri0n]

  Updates to latest ciphers list for Mozilla Intermediate, which also adds support for ChaCha20 and Poly1305.

- Always add security-relevant headers to the response, regardless of
  the response code (implements #147) [Leon Klingele]

  From nginx' add_header documentation:
  ```
  add_header Adds the specified field to a response header provided that
  the response code equals 200, 201, 204, 206, 301, 302, 303, 304, or 307.
  ```
  At least for all security-relevant headers this should not be the case
  and the header should always be added.


- Gitignore already tracked. [Edgar Ribeiro]

- Ignore files in sites-enabled. [Edgar Ribeiro]

- Fix missing ; [Edgar Ribeiro]

- Fixed #143 issue: Fix typo. [Bo-Yi Wu]

- Whitespace. [Andy Dawson]

- Add a failing example. [Andy Dawson]

- Show a successful example. [Andy Dawson]

- Now irrelevant. [Andy Dawson]

- Remove access log for probably-not-static files. [Andy Dawson]

  closes #131


- Remove cache-control public. [Andy Dawson]

  Closes #134


- Preload added to ssl.conf. [root]

- Add an ssl no-default example. [Andy Dawson]

  I.e. an example of this:

      -> curl -kI -H "Host: valid.com" https://localhost
      HTTP/1.1 200 OK
      ...
      -> curl -kI -H "Host: invalid.com" https://localhost
      curl: (52) Empty reply from server

  Whether this works or not depends on SNI.


- Updated ssl.exemple.com to use http2 instead of spdy. [Buzut]

  http2 is available in nginx since nginx 1.9.5. Therefor it's better to use the standard.

- Documentation inconsistent with file structure. [Edward Granger]

- Fix capitalization of includeSubDomains. [Chris Chapman]

- Correct syntax for keepalive_timeout. [Alan Orth]

  It doesn't seem to be a fatal error, but the keepalive_timeout
  value actually requires "s" (for seconds). Another occurence of
  this was fixed in 35434b3361b04beb028f602c78a9331ef4967a0d but
  these slipped through.

  See: http://nginx.org/en/docs/http/ngx_http_core_module.html#keepalive_timeout

  Signed-off-by: Alan Orth <alan.orth@gmail.com>


- Fix typo. [Craig Davison]

- Improve comments in nginx.conf. [Craig Davison]

- Single capitalization fix. [Corban Mailloux]

- Change default value in comment. [Craig Davison]

- Specify that keepalive_timeout is in seconds. [Craig Davison]

- Fix format. [Bo-Yi Wu]

  Signed-off-by: Bo-Yi Wu <appleboy.tw@gmail.com>


- Update nginx.conf. [beilharz]

  Typo: sites-available should be sites-enabled

- Add white space for comment. [Bo-Yi Wu]

- Miiiiiiiiiiiiiinor typo fix. [Francisc Romano]

- Updated locations to match h5bp's Apache config. [Kimmo Salmela]

  See https://github.com/h5bp/server-configs-apache/issues/31 for `well-known` change.

- Update media types in `nginx.conf` [Philipp Becker]

- Minor extension of the alphabetical sorting of media types. [Philipp
  Becker]

- Added FreeBSD w/ ZFS performance instructions. [Goran]

  On FreeBSD systems with ZFS, sendfile() is useless as ZFS's caching subsystem (adaptive replacement cache a.k.a ARC) already caches most frequently used files in RAM. Disabling sendfile() avoids redundant data caching.

  References:
  https://calomel.org/nginx.html
  http://blog.vx.sk/uploads/conferences/EuroBSDcon2012/zfs-tuning-handout.pdf

- Update to mozilla's wiki's current intermediate set. [AD7six]

- Fix #113. [St. Isidore de Seville]

- Add an inline documentation link to the sites-enabled documentation
  page. [Eric Andrew Lewis]

- Explain why everything in the sites-enabled folder is included. [Eric
  Lewis]

- Fix mispelling. [Jeff Widman]

- Fix mispelling. [Jeff Widman]

- Fix typo. [Jeff Widman]

- Don't use invalid examples. [Andy Dawson]

  A wildcard subdomain isn't valid syntax for a ACAO header

- Added 'dataready' accept_filter for SSL servers on FreeBSD hosts as
  per 'accept_filter=filter' section of
  http://nginx.org/en/docs/http/ngx_http_core_module.html#listen.
  [Pentago]

  More on FreeBSD's accept filters:
  http://www.freebsd.org/cgi/man.cgi?accf_http
  http://www.freebsd.org/cgi/man.cgi?accf_data

  Also added 'defered' (TCP_DEFER_ACCEPT) socket option to SSL server on Linux hosts and organized/commented both platform directives above the default value.

  Related to https://github.com/h5bp/server-configs-nginx/blob/master/sites-available/example.com#L19


- Fix typo in `inline.sh` [Luke Brookhart]

  `h5bp/basics.conf` => `h5bp/basic.conf`

  Close #97


- Update `CHANGELOG.md` [Cătălin Mariș]

- Map `.manifest` → `text/cache-manifest` media type. [Cătălin Mariș]

  The specification for the manifest file for web applications was
  recently updated¹ and it changed one of the recommended file extensions
  from `.manifest` to the unique `.webmanifest`².

  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  ¹ https://github.com/w3c/manifest/commit/0eecadd09074746a657d806131a39e2f7bdc962f
  ² https://github.com/w3c/manifest/issues/346


- Remove vcf → text/x-vcard mapping from mime.types. [Cătălin Mariș]

  Ref: http://www.iana.org/assignments/media-types/text/vcard
  Fix h5bp/server-configs-nginx#92


- README.md: Make minor improvements. [Cătălin Mariș]

- Update `CHANGELOG.md` [Cătălin Mariș]

- Update the list of resources to be compressed. [Cătălin Mariș]

  Ref: https://github.com/h5bp/server-configs-apache/blob/a0c4e1719075bf1d97d92a3b0ad225c7bff5dfab/src/web_performance/compression.conf


- Update `mime.types` [Cătălin Mariș]

  * Reorganized media types and order them alphabetically
  * Include some new media types in order to align with what is provided
    by the Apache configurations.
    https://github.com/h5bp/server-configs-apache/blob/c805353c4142c792267945687309259fc15b2106/src/media_types/media_types.conf


- Update `CHANGELOG.md` [Cătălin Mariș]

- Remove the .manifest → text/cache-manifest mapping. [Cătălin Mariș]

  Four years ago the recommended file extension for AppCache manifest
  files was changed¹ from `.manifest` to `.appcache`. So, even adding
  into consideration the transitional period, it no longer makes sense
  to keep the configurations that ensure that `.manifest` files are
  served with the AppCache required `text/cache-manifest` media type.

  Also, recently, `.manifest` became one of the recommended file
  extensions for web application manifest² files.

  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  ¹ https://html5.org/r/5812
  ² http://w3c.github.io/manifest/


- Rename `LICENSE.md` to `LICENSE.txt` [Cătălin Mariș]

  Change made so that the process of opening the `LICENSE` file is
  easier for non-technical people.


- Change media types for `.atom` and `.rss` files. [Sylvain Emery]

  Modify the configurations so that:

   * `.atom` files are served with the `application/atom+xml`¹ media type
   * `.rss` files are served with the `application/rss+xml`² media type

  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  ¹ https://www.iana.org/assignments/media-types/application/atom+xml
  ² http://tools.ietf.org/id/draft-nottingham-rss-media-type-00.txt

  Ref: https://github.com/h5bp/server-configs-apache/pull/50#issuecomment-76552855
       https://github.com/h5bp/server-configs-apache/commit/653c461c35a982e757fa94ddd73088f2581a88f9

  Close h5bp/server-configs-nginx#90


- Dropping the eggs. [Pedro de Carvalho]

  removed the blah blah and link to documentation.

- Calling reload nginx by the system scripts. [Pedro de Carvalho]

- Update getting-started.md. [Pedro de Carvalho]

- Added the -s flag to the reload command. [Pedro de Carvalho]

  The nginx documentation advises on using the -s signal to reload configuration.

- Spacing words. [Pedro de Carvalho]

- Add MIME-Types for .xsl files. [Steffen Weber]

  The correct MIME-Type for XSL files is "application/xslt+xml" according to http://www.w3.org/TR/2007/REC-xslt20-20070123/#media-type-registration.

- Add the Mozilla SSL config generator to related projects. [Roland
  Warmerdam]

- Fix minor typos and the capitalization of acronyms. [Drew Hammond]

  Close h5bp/server-configs-nginx#83


- Fix typo in `expires.conf` [Joey Geiger]

  Close h5bp/server-configs-nginx#82.


- Remove include directive in ssl.example.com. [Philipp Becker]

  To include the SSL related directives in the port 80 server block seems to be redundant.
  Because we are redirecting explicit all incoming traffic via port 80 to the HTTPS host on
  port 443 where only the *secure-connection-magic* is happen.

  Maybe I am missing something, but I tested the configuration
  under the following system and encountered no negative side effects:

  **Server**
  * Ubuntu 14.04 LTS
  * Nginx 1.7.7 mainline

  **Client**
  * OS X 10.9.5
  * Browser: FF 33, Chrome 38, Safari 7

- Update extra-security.conf. [Chris McKee]

- Extra security headers without a home. [Chris McKee]

- Change note / add missing header. [Chris McKee]

- Avoid long lines. [Andy Dawson]

- Add secondary google dns ip and 2 failover DYN DNS public dns ips, and
  timeouts. [Chris McKee]

- Update Cipher list to latest add version of STS. [Chris McKee]

  Updated latest "intermediate" ciphers from mozilla
  Add another version of the STS header including subdomains and comments
  Add note at base to consider ssl-stapling

- Move SVG media type into the "Images" group. [Steffen Weber]

  SVG is primarily an image format. Its usage as a font format is a
  legacy issue for supporting iOS 3 and iOS 4. In Chrome 38, support
  for SVG fonts has been removed (http://caniuse.com/#feat=svg-fonts).
  They have never been supported in Firefox or IE.

  Close h5bp/server-configs-nginx#74


- MIME-Types: support for .opus files. [Steffen Weber]

  http://en.wikipedia.org/wiki/Opus_(audio_format)

- Bump the minimum version requirement to 1.6.0. [AD7six]

  using the version shipped with debian stable (which is where 1.2.1 came
  from) holds back this repository too much.


- Correct bad link. [Andy Dawson]

1.0.0 (2014-10-24)
------------------

- V1.0.0. [AD7six]

- Add a header doc block. [AD7six]

- Add some structure to this bash script. [AD7six]

  Add help usage and examples. Some structural hints taken from
  http://linuxcommand.org/html_text/new_script.README.html


- Add very simple debugging script. [AD7six]

  this script converts include statements to dump the included file's
  contents inline.


- Add a brief description of h5bp's contents. [AD7six]

- Add doc files for sites-enabled|available. [AD7six]

- Add info on ngx_pagespeed & content transformation. [Cătălin Mariș]

  Provide information about `ngx_pagespeed` not rewriting any / some
  of the resources if the `Cache-Control: no-transform` response header
  is set.

  Ref: https://developers.google.com/speed/pagespeed/module/configuration#notransform

  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  Thanks to @Nikita-S-Doroshenko for pointing this out!

  Ref: h5bp/server-configs-apache#46


- Whitespace matters. [AD7six]

- Add hotlink protection example. [AD7six]

  closes #7


- Better wording. [AD7six]

- Correct typo. [AD7six]

- Mention try_files in server context gotcha. [AD7six]

- Dynamicly handling request which match a location block. [AD7six]

- Add a document explaining request handling. [AD7six]

  it's not exactly the same as one might expect


- Add a document (stub) for common problems. [AD7six]

  fixes #29


- Add nginx-conf-md to the toc. [AD7six]

- Add a description of nginx.conf. [AD7six]

  it's not intented to be complete, merely guide users unfamiliar with
  nginx.

  fixes #39


- Remove quotes from SSL cipher list. [Mike Almond]

- Add note about POODLE attack against SSLv3. [Mike Almond]

- Update SSL ciphers to the updated defaults by Mozilla. [Mike Almond]

- HSTS off by default. [Daniel Marquard]

  Consensus to disable HSTS by default.

- Removed "includeSubDomains" [Daniel Marquard]

  As a best practice, Nginx should only direct clients to use the certificate on specified domains. This is because not all servers using other subdomains necessarily listen on 443 and because, unless it is a wildcard certificate, it likely won't be valid on subdomains other than WWW.

- IPv6 only is the default. [Jack Wearden]

- IPv6 only is the default. [Jack Wearden]

- IPv6 support. [Jack Wearden]

- IPv6 support. [Jack Wearden]

- Use a more conventional location for sites. [AD7six]

  it's more common (at meast IME) to use /var/www/example.com rather than
  creating a new root folder `sites` to put apps in.


- Fix typo in `getting-started.md` [Philipp Becker]

  User and group name should be separated by a space character.
  Otherwise, only one value `www-data-www-data` is passed:

  "If group is omitted, a group whose name equals that of user is used."

- Add configs for WOFF 2.0 font files (`.woff2`) [Przemek Matylla]

  Ref: http://www.w3.org/TR/WOFF2/
       h5bp/server-configs-apache#32

  Close: h5bp/server-configs-nginx#54


- Remove Chrome Frame related comment. [Matthew Haughton]

  Fix h5bp/server-configs-nginx#30
  Close h5bp/server-configs-nginx#62


- Use relative path for mime.types. [Vladimir Sazhin]

- Remove gzip_http_version parameter. [Drew Hammond]

  The gzip_http_version override is no longer needed because CloudFront
  now forwards requests using HTTP/1.1. We can remove this line entirely
  and let nginx use its default value of 1.1.


- Fix 'directive' typo. [Joshua Gigg]

  Spotted by @honi in #51

- Add missing semicolons in `ssl.example.com` [Cătălin Mariș]

  Close h5bp/server-configs-nginx#52.


- Use a much longer ssl_session_timeout. [AD7six]

  To match the settiongs from istlsfastyet.com

  Add a mention of ssl_buffer_size even though it can 't be enabled yet


- Add ssl example site. [AD7six]

  ensure to avoid any use of if as that's "extremely inefficient" and
  eliminate redirects where possible


- Don't include ssl config by default. [AD7six]

  If the server has no ssl config - there's no need to load a config file
  full of ssl config


- Disable ssl_session_tickets. [AD7six]

  it's only recently added so is a config error otherwise


- Add stubs for ssl-stapling and spdy. [AD7six]

- Default to use HTTP strict transport security. [AD7six]

- Add increased ssl timeout. [AD7six]

- Turn off ssl session tickets. [AD7six]

  Stolen from istlsfastyet.com's config

  It is probably a more logical default to turn off session tickets
  given the diff linked in the comment block.


- Remove SSLv3 from the ssl protocol list. [AD7six]

  As suggested in #44, and since h5bp doesn't support IE6 it seems to be
  appropriate to remove a protocol which is in the list only to permit use
  with IE6.


- Move ssl config to a seperate file. [AD7six]

- Remove tcp_nodelay. [AD7six]

  The Nagle buffering algorithm is apparently that the best thing
  to enable by default.

  closes #28


- Fix typo, Update/Add Nginx Command to test a particular config file,
  Update Restart Command & Comments. [Syed I.R]

- Format README, Add Verify Config & Restart Nginx Command. [Syed I.R]

- Fix typo. [Marvin Roger]

  Close h5bp/server-configs-nginx#48.


- Make minor format related improvement in README.md. [Syed I.R]

- Apply cross-domain changes proposed in #23. [AD7six]

  closes #23


- Added missing semicolon, removed text/html charset. [Odontopera
  Mediochrea]

  I believe the error was because text/html is implied by default.

- Fix charset_types as mime.types is updated. [Tsz Ming WONG]

- Correct link to documentation. [Andy Dawson]

- Update README.md. [Markus Amalthea Magnuson]

- Fix broken documentation link. [Markus Amalthea Magnuson]

  The documentation link in the README is broken. It can be fixed either by changing "blob" to "tree", or by linking to the table of contents. This fix opts for the latter.

- Ssl_ciphers update. [Chris McKee]

  Updated ciphers to provide forwarding secrecy, a wider range of support and to match those provided by Mozilla security https://wiki.mozilla.org/Security/Server_Side_TLS#Nginx

- Fix spelling errors in nginx config docs. [Peter Kowalczyk]

- Remove Chrome Frame meta tag. Reference h5bp/server-configs-nginx#2.
  [Bo-Yi Wu]

- Renamed h5bp.conf to basic.conf README. [Syed I.R]

  Updated with correct filename.

- Update doc. [Domenico Leone Luciani]

  Because nginx doesn't start without fix access_log path.

- Move config snippets around. [AD7six]

  Make it more obvious which snippets are location based, and which
  are just directives. Need to provide more files like basic.conf to
  cover more of the common use cases.


- Create getting started doc. [AD7six]

- Adds no value, remove. [AD7six]

- Wrong dash. [AD7six]

- Get started on the documentation. [AD7six]

- Remove readme from doc folder. [AD7six]

  a readme prevents navigating existing files via github


- Add a doc block to no-default. [AD7six]

  and remove the default_server direcdtive from example.com. Since this file
  is likely to be the copy-and-paste file for multiple server configs,
  don't mark example.com as the default.


- Add a config file for no default site. [AD7six]

  fixes #10


- Rename conf folder to h5bp. [AD7six]

  The name "conf" is potentially confusing as something which should be inclued
  en masse rather than a folder of config snippets.

  Closes #13


- Ensure compatibility with earlier/current versions of nginx. [AD7six]

  auto was not introdued until 1.3.8 and 1.2.5.

  Debian wheezy for example only comes with 1.2.1, only the next version
  (in testing) will have a version of nginx which supports auto.


- Remove the sites-enabled readme. [AD7six]

  this file is considered a site config  file, preventing the use of the repo as is


- Typo foorbar -> foobar. [James Freeman]

- Grammar, doesn't modify code. [Corprew Reed]

- Remove `font.css` reference. [Matt Robenolt]

  Close #6.


- Add configs for cursor images (`.cur`) [Oskar S. Jakieła]

  Apply all the configs used for `.ico` files to `.cur` files as the two
  image formats are almost identical.

  The MIME type for the `.cur` file doesn't matter as browsers seem to
  sniff the content. However, `image/x-icon` is specified because it's
  the one usually used for `.ico` file and because it's shorther then the
  other frequentlly used one (`image/vnd.microsoft.icon`), making the
  header size smaller.

  See also:
  * http://en.wikipedia.org/wiki/ICO_%28file_format%29
  * http://msdn.microsoft.com/en-us/library/windows/desktop/ms648007%28v=vs.85%29.aspx

  Close: #5.


- Update CONTRIBUTING.md and LICENSE.md. [Cătălin Mariș]

  Replace the Apache references with Nginx ones.


- Add MIME type for `.torrent` files. [Andrej Čremožnik]

  Serve `.torrent` files with the `application/x-bittorrent` MIME type
  instead of the default `application/octet-stream`. This helps improve
  the user experience in some browsers (e.g.: in Firefox, the user is
  offered the option to open the file with a torrent application, if
  it has one installed).

  Close h5bp/server-configs-nginx#4


- Don't map the .jsonp extension to the JS MIME type. [Cătălin Mariș]

  Remove `.jsonp` as there isn't any convention around the JSONP MIME-type
  or the `.jsonp` extension. Also, it seems that, `application/javascript`
  is arguably the wrong type to use for JSONP.

  Ref: broofa/node-mime#64


- Add `CHANGELOG.md` [Cătălin Mariș]

  Use a `CHANGELOG.md` file to keep the project history available within
  the repository, therefore, making it easier to track what has changed
  since the last tagged release.


- Add `README.md` [Cătălin Mariș]

- Add MIT license. [Cătălin Mariș]

  In order to remove any ambiguity, provide a proper, highly permissive
  license, recognized by the Open Source Initiative (OSI).


- Add `CONTRIBUTING.md` [Cătălin Mariș]

  Providing the `CONTRIBUTING.md` file alows us to take advantage
  of GitHub's UI and prompt contributors to read the repository's
  guidelines before creating an issue or opening a pull request:
  https://github.com/blog/1184-contributing-guidelines.

  The content in the `CONTRIBUTING.md` file is based on @necolas's
  Issue Guidelines: https://github.com/necolas/issue-guidelines.


- Move nginx server configs to their own repository. [Cătălin Mariș]

- Move documentations into `doc` directories. [Cătălin Mariș]

- [nginx] Remove `text/html` from `gzip_types` [alrra]

  Fix: h5bp/server-configs#144.


- Nginx.conf: repair broken log format (someone had swapped two
  variables around, breaking the intended apache log format
  compatibility) [Aitte]

  Conflicts:
  	nginx/nginx.conf


- Update server configs. [alrra]

  Update some of the server configurations to match
  the ones used in the Apache hypertext access file.


- Expires.conf: add missing .htc file type. [Aitte]

- Protect-system-files.conf: clarify why people should be using it.
  [Aitte]

- Cache-file-descriptors.conf: new feature which greatly speeds up
  performance on very busy production sites. [Aitte]

- Nginx.conf: Add support for default SSL certificate served to clients
  with old browsers. [Aitte]

- Nginx.conf: Massively speed up SSL connections by caching the sessions
  for 10 minutes rather than constantly re-negotiating. [Aitte]

- Nginx.conf: protect server against the BEAST SSL attack (ref:
  http://nginx.org/en/docs/http/configuring_https_servers.html) [Aitte]

- Replacing everything with more descriptive comments. [Aitte]

  for people that don't know what the options do


- Nginx.conf: Make use of the "auto" directive to let nginx spawn as
  many workers as there are CPU cores. [Aitte]

- Nginx.conf: Remove the gzip_buffers directive and let nginx figure it
  out instead, that way it will align them to CPU cache lines for
  greater performance. [Aitte]

- Protect-system-files.conf: use "deny all" for clearer intent when
  blocking access. [Aitte]

- Nginx: change regex patterns to non-capturing for speedup. [Aitte]

- Don't cache .html or .htm files. [Andy Dawson]

  Thanks @aitte, ref h5bp/server-configs#133


- Expires.conf: remove duplicate .ico cache headers. [Aitte]

- Change WOFF MIME type to `application/font-woff` [alrra]

  The WOFF MIME Type was formally registered as `application/font-woff`:
  - http://www.iana.org/assignments/media-types/application/font-woff


- One more space. [Nicolae Vartolomei]

- Code style consistency across nginx configs. [Nicolae Vartolomei]

- Port wiki docs to README's. [Nicolas Gallagher]

  Move the wiki documentation into a README for each server config dir.

  Make formatting improvements to the IIS documentation.


- Move .htaccess to the `server-configs` repository. [alrra]

- Update Microsoft Office Mime-Types (h5bp/server-configs#94) [Christian
  Boenning]

  Add mimetypes for all major MS office file types > 2003

  Reference:
  http://technet.microsoft.com/en-us/library/ee309278(v=office.12).aspx


- Whitespace correction. [Andy Dawson]

  Make the markdown render correctly


- Update nginx/nginx.conf. [nvartolomei]

- Update gzip_disable option to match best practice. [James Aitken]

  Nginx recommend to use the string ``msie6`` instead of the previously recommended regex.

  The string matches the same stuff as the regex, but is faster according to their docs.

  See: http://nginx.org/en/docs/http/ngx_http_gzip_module.html#gzip_disable


- Correct cache headers for webfonts. [AD7six]

  Only one location match is ever executed - therefore the relevant
  location match must contain all relevant rules.

  cross-domain-fonts is included by default, therefore for right now add
  the cache rules for these requests directly to the
  cross-domain-fonts.conf file

  fixes h5bp/server-configs#85
  fixes h5bp/server-configs#86

  Thanks to @MisterJack


- Split the default server config. [AD7six]

  Make it possible to pick and mix server rules.


- Improve READMEs. [Alessandro Vendruscolo]

- Rename default.conf to example.com. [Alessandro Vendruscolo]

  This should encourage users to keep the config files indexed by domain
  name


- Per-site configuration, using two server blocks. [Alessandro
  Vendruscolo]

- Correct syntax error. [Andy Dawson]

- Cleanup mess made doing pointless merge. [Chris McKee]

- Revert "Merge remote-tracking branch 'upstream/master' (HLBP Master
  Server Configs)" [Chris McKee]

  This reverts commit 19aa2e8a56ee3366feb99207aa6a43d498d92a0f, reversing
  changes made to 1007c16e697790da227fab1b7ade6343be02ddb6.


- Only include conf files. [AD7six]

- Don't need this "hint" symlink. [AD7six]

  there's a readme instead.


- Adding readm files to sites-available/enabled. [AD7six]

- Remove embedded config lost in merge. [AD7six]

- Use sites-available vhost style. [AD7six]

  If there is only one host - this doesn't add any problems, and makes
  it easier to isolate changes related to the host from that of the host
  in general.

  When more than one host is used, it makes things much, much simpler.


- Add `cache-control: no-transform` header. [Alessandro Vendruscolo]

- Cross-domain stuff. [Alessandro Vendruscolo]

- Security tweaks, returning 403 if needed. [Alessandro Vendruscolo]

- Add filename based cache busting. [Alessandro Vendruscolo]

- Handle www to non-www redirect. [Alessandro Vendruscolo]

  A secundary `server` block has been added. It'll listen on the `www`
  host and redirect to the `non-www` host.


- Encourage users to use multiple virtual hosts. [Alessandro
  Vendruscolo]

- Add the MIME type for AAC audio files. [Roland Warmerdam]

- Update the nginx gzip MIME types. [Roland Warmerdam]

- Use valid font mime types in the nginx config. [Roland Warmerdam]

- Normalize whitespace. [AD7six]

  make it easier to keep this file and the .htaccess file it is based upon
  in sync, by using the same indent


- Syncing with latest H5BP `.htaccess` [Chris Jones]

- Add the x-web-app-manifest-json mimetype for webapp files. [James
  Long]

- Fix configuration syntax. http://wiki.nginx.org/ConfigurationSyntax.
  [Indrek Ardel]

- Serve .mp4 and .m4v files as `video/mp4` as per RFC 4337. [Mathias
  Bynens]

  Closes h5bp/html5-boilerplate#1024. See http://tools.ietf.org/html/rfc4337#section-2.


- Whoops - 1Y is not valid. [AD7six]

  one year is 1y


- Apparently this is the same header as apache serves. [AD7six]

- Move all server configs into folders. [AD7six]

  easier to organise. We could also possibly then simply add a README
  file toeach folder rather than use wiki pages - maybe.


- Make xml application/xml. [AD7six]

- Add json. [AD7six]

- Add expire rules mimicking that of the apache config. [AD7six]

  These rules are closer to the expire logic defined for apache, and also
  use a none-capturing regex which will be (unnoticably) faster.

  Added a comment as to why there is no default expire header defined.


- Do not set a default expire. [AD7six]

  Unless your entire site is static it's inappropriate to do so - dynamic
  requests will be cached by the browser unless your application code
  overrides the expires which nginx is setting by default.


- Added m4a/m4v mime types. [John-Scott Atlakson]

  This was recently added upstream => http://trac.nginx.org/nginx/changeset/4252/nginx


- Specify a charset. [ram]

- Use the correct MIME type for XHTML files. [Mathias Bynens]

- Add mime types from default mime.types. [James McKinney]

- Updating configs to match H5BP .htaccess defaults. [Mike Almond]

- Add mime type for .wav files. [Tinnet Coronam]

  'x-wav' seems to be the standard, but could also be 'wav' or 'wave' or 'vnd.wav' according to wikipedia


- We also need application/x-javascript for google chrome. [Iurii
  Ogiienko]

- Merge. i thinkkk. [Paul Irish]

- Nginx.conf Improvements/Corrections. [sean]

  Don't think it makes sense to turn this off for a single worker and it's on by default.

  The docs indicate that Nginx will use the best method based on the available methods

  Keepalive of 5 seems very low - i've seen recommendations of 10-20

  gzip_proxied was set twice

  gzip_static should be off unless actually used

  default is deprecated

  server_name _; shouldn't be used

  Shoudn't use expires in the server {} block - should be inside location {}

  Extra root lines not needed

  gzip_comp_level seems too low

  gzip_min_length seems too high


- Added some comments to the nginx config relating to expires. [Mark
  Wolfe]

- Added some comments to the nginx config relating to expires. [Mark
  Wolfe]

- Specify 404 page. [Ben Hanzl]

- Image/x-icon to match our htaccess. thx badboy. [Paul Irish]

- Remove access logging for static files to save disk writes. [Graham
  Weldon]

- Add to and fix typo in MIME types to be gzipped: [Paul Sarena]

  Add text/x-component.  It's listed in html5-boilerplate/.htaccess and is in our nginx-mime.types
  Fix application/xml+rss, should be application/rss+xml
  Comment indicating text/html is always compressed, so there's no need to include it


- Remove access logging for static files to save disk writes. [Graham
  Weldon]

- Add to and fix typo in MIME types to be gzipped: [Paul Sarena]

  Add text/x-component.  It's listed in html5-boilerplate/.htaccess and is in our nginx-mime.types
  Fix application/xml+rss, should be application/rss+xml
  Comment indicating text/html is always compressed, so there's no need to include it


- Associate mime.types file with nginx. [Paul Irish]

- Nginx: js wasnt being gzipped. thanks poswald! fixes h5bp/server-
  configs#5. [Paul Irish]

- Use the .appcache extension instead of .manifest, as per
  http://html5.org/r/5812 - thx mathias. [Paul Irish]

- X-UA-Compatible for nginx. thanks mucho joshgillies. [Paul Irish]

- Adding minor note about who owns the mime.types file. [Paul Irish]

- Whats up, sweetass configurations? boom boom. [Paul Irish]
