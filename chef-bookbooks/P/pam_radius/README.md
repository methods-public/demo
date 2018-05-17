# pam_radius
The pam_radius cookbook provides a resource to install and configure pam_radius.
## Requirements
### Cookbooks
N/A

### Chef
* `>= 12.1`

### Platforms
* rhel7
* rhel6
* centos6
* centos7
* ubuntu1404
* ubuntu1604
* debian8
* debian9

## Resources
### pam_radius
`pam_radius` installs the pam radius package and allows you to specify cookbook.
#### properties
| Name | Type | Required | Default | Description |
| ---- | ---- | -------- | ------- | ----------- |
| `configuration` | `Array` | `false` | `[]` | Configuration for the radius servers. Should be an Array of Hashes like defined below |

The `configuration` array should follow the following structure:

```
[
  {
    "host":          "Hostname or ip"       # Mandatory
    "port":          "Port number"          # Optional
    "shared_secret": "RADIUS shared secret" # Mandatory
    "timeout":       "Timeout in sec"       # Mandatory
    "source_ip":     "Source IP"            # Optional
    "vrf":           "vrf, no idea"         # Optional
  }
]
```

## Versionning
This cookbook will follow semantic versionning 2.0.0 as described [here](https://semver.org/)

## Lisence
MIT

## Contributing
Put link vers contributing here
