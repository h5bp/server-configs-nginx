[Nginx Server Configs homepage](https://github.com/h5bp/server-configs-nginx)
 | [Documentation table of contents](TOC.md)

# Usage

## Requirements

 * nginx version 1.6.0+

There are two ways to make use of the contents of this repository, as a reference
or directly as the source for nginx to run from. A number of config snippets are
provided allowing you to pick and choose which features to allow/expose - some
snippets are dependent on other features in this repository. For example rules that
rely on a specific mime type for a given file extension, expect/rely the use of the
bundled `mime.types` file.

## Using as a reference

To use as reference requires no special installation steps, download/checkout the
repository to a convenient location and adapt your existing nginx configuration
incorporating the desired functionality from this repository.

## Using directly

To use directly, replace the nginx config directory with this repository. for example:

    /etc/init.d/nginx stop
    cd /etc
    mv nginx nginx-previous
    git clone git@github.com:h5bp/server-configs-nginx.git nginx
    # install-specific edits
    /etc/init.d/nginx start

Install specific edits will vary from server to user, see [Getting started](getting-started.md)
for a description of the required steps.

## Basic structure

This repository has the following structure, which is based on the standard install for a
webserver on debian:

```
.
├── doc
├── h5bp
├── sites-available
	└── example.com
├── sites-enabled
├── mime.types
└── nginx.conf
```

Below is a general description of each section

### h5bp

This directory contains config snippets (mixins) to be included as desired.
There is more information available about the individual files in
[About h5bp](h5bp.md).

### sites-available

This directory should contain all of the server definitions that are available
for use. [About sites-available](sites-available.md).

### sites-enabled

This directory should contain only symlinks to enable a specific `sites-available`
server. [About sites-enabled](sites-enabled.md).

### mime.types

The mime.types file is responsible for mapping file extensions to mime types.

### nginx.conf

The main nginx config file. [About nginx.conf](nginx-conf.md).
