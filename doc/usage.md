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
    git clone https://github.com/h5bp/server-configs-nginx.git nginx
    # install-specific edits
    /etc/init.d/nginx start

Install specific edits will vary from server to user, see [Getting started](getting-started.md)
for a description of the required steps.

## Basic structure

This repository has the following structure:

```
./
├── doc/
├── conf.d/
│   ├── default.conf
│	  └── templates/
├── h5bp/
│   ├── basic.conf
│   ├── location/
│   └── ...
├── mime.types
└── nginx.conf
```

Below is a general description of each section

### h5bp

This directory contains config snippets (mixins) to be included as desired.

There are two types of config files provided, individual config snippets and
combined config files which provide convenient defaults.

* `basic.conf`

This file loads a small subset of the rules provided by this repository to add
expires headers, allow cross domain fonts and protect system files from web
access.

* `location` folder

Files in this folder contain one or more location directives. They are intended
to be loaded in the server context (or, in a nested location block).

### conf.d

This directory should contain all of the server definitions.

Except if they are dot prefixed or non .conf extension, all files in this
folder **are** loaded automatically.

* `templates` folder

Files in this folder contain a server{} template for secure and non-secure hosts.
They are intended to be copied in the `conf.d` folder with all `example.com` 
occurrences changed to the target host.

#### Usage

```bash
$ cd /etc/nginx/conf.d
```

* Creating a new site
  ```bash
  $ cp templates/example.com.conf actual-hostname.conf
  $ sed -i 's/example.com/actual-hostname/g' actual-hostname.conf
  ```

* Enabling a site
  ```bash
  $ mv .actual-hostname.conf actual-hostname.conf
  ```
	
* Disabling a site
  ```bash
  $ mv actual-hostname.conf .actual-hostname.conf
  ```

```bash
$ /etc/init.d/nginx reload
```

### mime.types

The mime.types file is responsible for mapping file extensions to mime types.

### nginx.conf

The main nginx config file. [About nginx.conf](nginx-conf.md).
