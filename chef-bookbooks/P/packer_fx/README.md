# packer_fx
## Requirements
### Chef
`>= 12.24`

### Cookbooks
* `unzip_fx`

## Resources
### packer_fx
Resource that installs packer from hashicorp.
#### properties
| Name | Type | Required | Default | Platform | Description |
| ---- | ---- | -------- | ------- | -------- | ----------- |
| `version` | `String` | `true` | - | `all` | Version of packer |
| `install_directory` | `String` | `false` | `/opt/packer` | `all` | Instalation directory for packer |
| `source` | `String` | `false` | - | `all` | If not set, it will fetch it from hashicorp's website |
| `checksum` | `String` | `false` | - | `all` | Checksum of the packer download ( needed for full idempotency ) |

## Versionning
This cookbook will follow semantic versionning 2.0.0 as described [here](https://semver.org/)

## Lisence
MIT

## Contributing
Put link vers contributing here
