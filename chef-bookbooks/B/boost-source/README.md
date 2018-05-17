# boost-source

A chef cookbook that builds and installs the C++ Boost library from a
source tarball. 

## Supported Platforms

* All major.

## Attributes
Attribute | Description | Type | Default
----------|-------------|------|--------
major_ver | Major version of boost | String | 1
minor_ver | Minor version of boost | String | 58
patch_ver | Patch version of boost | String | 0
download_url  | Overrides the url where boost is downloaded from. Can be used to set a local file. | String | Dynamically built.
file_ext  | Extension of boost tarball (i.e. .gz, .bz2) | String | .gz
install_prefix  | Prefix location where boost gets installed. | String | /usr/local
build_cmd  | The bootstrap and build command for boost. | String | ./bootstrap.sh --prefix=/usr/local && ./b2 install

## Usage
Include default recipe and the 1.58.0 (current latest) will be
downloaded, built and installed. 

    include_recipe 'boost-source'

To control a specific version, set the attributes accordingly. To
install 1.57.0 of boost you would set the `minor_ver` attribute and then
include the recipe:

    node['boost-source']['minor_ver'] = "57"
    include_recipe 'boost-source'

### boost-source::default

Include `boost-source` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[boost-source::default]"
  ]
}
```

## License and Authors

Author:: Scott Saad (<saadsj@gmail.com>)
