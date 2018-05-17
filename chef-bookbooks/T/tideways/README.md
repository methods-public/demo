Tideways cookbook
=================

A cookbook to install and configure Tideways.

This requires the following data adding to the appropriate environment data file:

```
{
  "default_attributes": {
    "tideways": {
      "api_key": <api_key>,
      "framework": <framework>,
      "php_service_name": <php-fpm|httpd|apache2>,
      "auto_start": <yes|no>,
      "auto_prepend_library": <yes|no>
    }
  }
```

## Attributes

* `api_key` is obtained from the correct application in Tideways

* `framework` is what is appropriate for your project. Currently supported: symfony2, symfony2c, shopware, oxid, magento, zend1, zend2, laravel & wordpress

* `php_service_name` is the service that serves the PHP pages.

* `auto_start` Automatically Start profiling

* `auto_prepend_library` Load PHP Library - Disable to 'Turn Off' Tideways

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

Supermarket share
-----------------

[stove](http://sethvargo.github.io/stove/) is used to create git tags and
publish the cookbook on supermarket.chef.io.

To tag/publish you need to be a contributor to the cookbook on Supermarket and
run:

```
$ stove login --username <your username> --key ~/.chef/<your username>.pem
$ rake publish
```

It will take the version defined in metadata.rb, create a tag, and push the
cookbook to http://supermarket.chef.io/cookbooks/tideways


License and Authors
-------------------
- Author:: Rupert Jones

```text
Copyright:: 2015-2016 The Inviqa Group Ltd

See LICENSE file
```
