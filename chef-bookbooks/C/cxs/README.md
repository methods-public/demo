# cxs Cookbook

This cookbook will install and configure your CXS plugin.
It will check if you have a valid license and install it.


## Requirements

This cookbook requires no extra libraries. Though requires valid license.

### Platforms

- CentOS
- CloudLinux

### Chef

- Chef 12.0 or later

### Cookbooks

- `default` - installs and manages cxs
- `_config` - manages cxs configs
- `_semicolon_config` - manages the configs like ignore and xtra, using semicolon arrangement

## Attributes

| Attribute                                         | Default                    | Description                    |
|:--------------------------------------------------|:---------------------------|:-------------------------------|
| `node['cxs']['config']['mail']`                 | `'root'`                | The e-mail
| `node['cxs']['config']['options']`              | `'mLScehnwROfGZxdMDuW'` | Exploit scan options
| `node['cxs']['config']['filemax']`              | `'0'`                   | Skip dir if > than [num] resources
| `node['cxs']['config']['voptions']`             | `'mfuhexT'`             | Virus scan specified file types only
| `node['cxs']['config']['qoptions']`             | `'MvB'`                 | Delete specified file types only
| `node['cxs']['config']['quarantine']`           | `'/home/quarantine'`    | Quarantine Folder
| `node['cxs']['config']['ignore']`               | `'/etc/cxs/cxs.ignore'` | CXS ignore matching file
| `node['cxs']['config']['xtra']`                 | `'/etc/cxs/cxs.xtra'`   | CXS xtra fingerprints file
- More parameter can be found at CXS's url

- For cxs.ignore and cxs.xtra please check the attributes as set under `attributes/`


## Usage

### cxs::default

TODO: Write usage instructions for each cookbook.

e.g.
Just include `cxs` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[cxs]"
  ]
}
```

and on your cookbook installation:

```ruby
cxs 'install cxs'
```

Uninstall:
```ruby
cxs 'uninstall' do
    action :uninstall
end
```


## Contributing

TODO:

- Add all the remaining configs (except ignore,xtra)
- Make cxswatch management better
- Cronjobs support
- Other tweaks like: FTP fo cpanel etc

## License and Authors

License and Author
==================

|                      |                                          |
|:---------------------|:-----------------------------------------|
| **Author:**          | [Vassilis Aretakis](https://gitlab.com/billias) (<vassilis@aretakis.eu)




      Licensed under the Apache License, Version 2.0 (the "License");
      you may not use this file except in compliance with the License.
      You may obtain a copy of the License at

          http://www.apache.org/licenses/LICENSE-2.0

      Unless required by applicable law or agreed to in writing, software
      distributed under the License is distributed on an "AS IS" BASIS,
      WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
      See the License for the specific language governing permissions and
limitations under the License.
