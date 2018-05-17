# Description

Installs one or more ruby versions with rbenv

# Requirements

Depends on 'rbenv' cookbook

## Platform:

* ubuntu (= 14.04)
* centos (= 6.6)

# Attributes

* `node["rubyenv"]["rubies"] ['1.9.3-p551' => false,'2.1.5' => false,'2.2.3' => true]`

# Recipes

* rubyenv::default

# Example (attributes.json)

```
{
  "run_list": [
    "recipe[rubyenv::default]"
  ],
  "rubyenv": {
    "rubies": {
      "1.9.3-p511": false,
      "2.1.5": false,
      "2.2.3": true
    }
  }
}

```

The true/false flag signifies whether or not this should be the global ruby version.

# License and Maintainer

Maintainer:: Dennis Vink (dennis.vink@sentia.com)

License:: MIT (see LICENSE)
