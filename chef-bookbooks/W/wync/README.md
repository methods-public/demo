# wync-cookbook
===============

This installs wync, which is a Linux version of Microsoft Lync.


Attributes
----------
* `wync::default'` - installs the package

## Usage

### wync::default

Include `wync` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[wync::default]"
  ]
}
```

## License and Authors

Author:: Rilindo Foster (rilindo.foster@monzell.com)
