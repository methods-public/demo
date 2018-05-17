# nodeinfo-cookbook

Simple cookbook to manage a JSON file in /etc/ that contains information about the node.
This file is readable by OHAI, so can be a two-way management.

This is not meant to manage any sensitive information that could cause security issues.


## Supported Platforms

linux
## Usage

### nodeinfo::default
Installs Ohai plugin that reads /etc/nodeinfo/info.json
manages this file should node attributes differ from it.

## License and Authors

Author:: Stuart Harland (<essjayhch@gmail.com>)
