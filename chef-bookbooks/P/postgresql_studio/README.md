# postgresql_studio-cookbook

TODO: Enter the cookbook description here.

## Supported Platforms

TODO: List your supported platforms.

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['postgresql_studio']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

## Usage

### postgresql_studio::default

Include `postgresql_studio` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[postgresql_studio::default]"
  ]
}
```

## License and Authors

Author:: computerlyrik, Christian Fischer (<chef-cookbooks@computerlyrik.de>)
