# mount_cifs-cookbook

Install the packages required for mount to use the cifs filesystem.

## Tested Platforms

Integration tests are regularly run on the following platforms.

##### Ubuntu
* 10.04
* 12.04
* 13.04
* 14.04

##### Debian
* 6.0.8
* 7.4

##### CentOS
* 5.10
* 6.4

##### Oracle Linux
* 6.5
* 7.0

##### Fedora
* 18
* 19
* 20

## Usage

### mount_cifs::default

Include `mount_cifs` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[mount_cifs::default]"
  ]
}
```

## License and Authors

Author:: Ryan Larson (<ryan.mango.larson@gmail.com>)
