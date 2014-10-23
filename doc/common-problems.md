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
error message suggests, but adding to nginx.conf the following:

    # add this to the http context
    types_hash_max_size: 1024;

    ## OR add this to the http context, don't need both
    # types_hash_bucket_size: 32
