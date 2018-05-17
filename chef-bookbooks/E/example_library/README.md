# example_library

[![Build Status](https://travis-ci.org/loom-cookbooks/example_library.svg?branch=master)](https://travis-ci.org/loom-cookbooks/example_library) [![Cookbook Version](https://img.shields.io/cookbook/v/example_library.svg)](https://supermarket.chef.io/cookbooks/example_library)

This is a library cookbook that demonstrates how to use InSpec for integration testing. It's a library cookbook because it defines resources as LWRPs in the `/libraries` directory.

These resources are compatible with Chef 12.5 or higher, but are still declared without using the new resource style introduced in Chef 12.5. For an example on using Chef 12.5+ resources, see the cookbook [example_resources][example_resources].

The purpose of this cookbook is to illustrate the relationship between a cookbook that defines a new Chef resource, and another cookbook that consumes it.

## To test

Install [ChefDK][chefdk] 0.12.0 or higher.  (Test Kitchen 1.6.0 or higher is required. Test Kitchen 1.6.0 is bundled with  0.12.0 or higher.)

```bash
$ kitchen verify
```

## Development

* [GitHub][repository]
* [Supermarket][supermarket]
* [Issues, questions, requests][issues]

## Author

Created and maintained by Kevin Dickerson of [Loom](loom). <kevin.dickerson@loom.technology>.

[loom]: https://loom.technology
[repository]: https://github.com/loom-cookbooks/example_library
[supermarket]: https://supermarket.chef.io/cookbooks/example_library
[issues]: https://github.com/loom-cookbooks/example_library/issues
[chefdk]: https://downloads.chef.io/chef-dk/
[example_resources]: https://supermarket.chef.io/cookbooks/example_resources
