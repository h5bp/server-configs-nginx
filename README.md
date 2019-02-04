# [Nginx Server Configs](https://github.com/h5bp/server-configs-nginx)

**Nginx Server Configs** is a collection of configuration snippets that can help
your server improve the web site's performance and security, while also
ensuring that resources are served with the correct content-type and are
accessible, if needed, even cross-domain.


## Getting Started

* [Nginx Beginners Guide](https://nginx.org/en/docs/beginners_guide.html)
* [Nginx Request Processing](https://nginx.org/en/docs/http/request_processing.html)
* [How Nginx works](docs/getting-started.md) — Understanding nginx, and how it differs from other webservers.

### Basic structure

This repository has the following structure:

```
./
├── conf.d/
│   ├── default.conf
│	  └── templates/
├── h5bp/
│   ├── basic.conf
│   ├── location/
│   └── .../
├── mime.types
└── nginx.conf
```

* **`conf.d/`**

  This directory should contain all of the server definitions.
  
  Except if they are dot prefixed or non .conf extension, all files in this
  folder **are** loaded automatically.

  * **`templates` folder**

    Files in this folder contain a `server{}` template for secure and non-secure hosts.
    They are intended to be copied in the `conf.d` folder with all `example.com` 
    occurrences changed to the target host.

* **`h5bp/`**

  This directory contains config snippets (mixins) to be included as desired.
  
  There are two types of config files provided, individual config snippets and
  combined config files which provide convenient defaults.

  * **`basic.conf`**
  
    This file loads a small subset of the rules provided by this repository to add
    expires headers, allow cross domain fonts and protect system files from web
    access.

  * **`location/`**
  
    Files in this folder contain one or more location directives. They are intended
    to be loaded in the server context (or, in a nested location block).


* **`mime.types`**

  The mime.types file is responsible for mapping file extensions to mime types.

* **`nginx.conf`**

  The main nginx config file.

### Other resources

* [Troubleshooting](docs/troubleshooting.md) — Dealing with commonly-encountered errors.
* [Hotlink protection](docs/hotlink-protection.md)


## Usage

### As a reference

To use as reference requires no special installation steps, download/checkout the
repository to a convenient location and adapt your existing nginx configuration
incorporating the desired functionality from this repository.

### Directly

To use directly, replace the nginx config directory with this repository. for example:

```shell
nginx stop
cd /etc
mv nginx nginx-previous
git clone https://github.com/h5bp/server-configs-nginx.git nginx
# install-specific edits
nginx start
```

### Manage sites

```bash
$ cd /etc/nginx/conf.d
```

* Creating a new site
  ```bash
  $ cp templates/example.com.conf .actual-hostname.conf
  $ sed -i 's/example.com/actual-hostname/g' .actual-hostname.conf
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
$ nginx reload
```


## Support

 * Nginx v**1.6.0**+


## Contributing

Anyone is welcome to [contribute](.github/CONTRIBUTING.md),
however, if you decide to get involved, please take a moment to review
the [guidelines](.github/CONTRIBUTING.md):

* [Bug reports](.github/CONTRIBUTING.md#bugs)
* [Feature requests](.github/CONTRIBUTING.md#features)
* [Pull requests](.github/CONTRIBUTING.md#pull-requests)


## Acknowledgements

[Nginx Server Configs](https://github.com/h5bp/server-configs-nginx) is only possible thanks to all the awesome
[contributors](https://github.com/h5bp/server-configs-nginx/graphs/contributors)!


## License

The code is available under the [MIT license](LICENSE.txt).
