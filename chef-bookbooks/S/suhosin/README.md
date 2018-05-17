# suhosin-cookbook [![Build Status](https://secure.travis-ci.org/FFIN/suhosin.png)](http://travis-ci.org/FFIN/suhosin)


TODO: Enter the cookbook description here.

## Supported Platforms

TODO: List your supported platforms.

## Attributes

Default attributes value is below.
Please note that [Suhosin site](https://suhosin.org/stories/download.html) is not providing sha256 checksum,
if you want change to different version. You need to get sha256 value with command like `sha256sum` by yourself.

* default['suhosin']['source'] = 'https://download.suhosin.org/suhosin-0.9.37.1.tar.gz'
* default['suhosin']['version'] = '0.9.37.1'
* default['suhosin']['checksum'] = '322ba104a17196bae63d39404da103fd011b09fde0f02484dc44366511c586ba'

## Usage

### suhosin::default

Include `suhosin` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[suhosin::default]"
  ]
}
```