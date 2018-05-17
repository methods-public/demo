# unzip_fx
The unzip_fx cookbook provides a resource to quickly and easily download and extract a zip file.
## Requirements
### Cookbooks
N/A

### Chef
* `>= 12.5`

### Platforms
* windows2008r2
* windows2012r2
* windows2016
* rhel6
* rhel7
* centos6
* centos7
* ubuntu1604
* debian8
* debian9

## Resources
### unzip_fx

#### Properties

| Name | Type | Required | Default | Operating System | Description |
| ---- | ---- | -------- | ------- | --------------- | ----------- |
| `source` | `String` | `true` | - | `All` | URL of the zip to extract |
| `checksum` | `String` | `false` | - | `All` | Checksum of the downloaded file |
| `target_dir` | `String` | `true` | - | `All` | Directory where to extract the zip file |
| `creates` | `String` | `false` | - | `All` | Which file to check for in order to not re-unzip |
| `recursive` | `[true, false]` | `false` | `false` | `linux` | Wheter to create the target dir recursively or not |
| `user` | `String` | `false` | - | `linux` | TBD |
| `group` | `String` | `false` | - | `linux` | TBD |
| `mode` | `String` | `false` | - | `linux` | TBD |

## Versionning
This cookbook will follow semantic versionning 2.0.0 as described [here](https://semver.org/)

## Lisence
MIT

## Contributing
Put link vers contributing here
