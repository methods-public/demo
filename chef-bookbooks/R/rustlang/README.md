# chef-rustlang

This cookbook installs [Mozilla's cool new programming language: Rust](http://www.rust-lang.org). It installs using the binary distribution from the Rust homepage using their installer script.

It can install either a named version or just the Rust nightly. You can control this with attributes: The defaults defined in the recipe are:

    default['rustlang']['version'] = "1.0.0-alpha"
	default['rustlang']['installation_prefix'] = '/opt'

To install the nightly version just change the `version` attribute to `"nightly"`

