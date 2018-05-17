# chef-graphite-influxdb-cookbook

Installs the graphite-influxdb package for graphite-api

## Supported Platforms

CentOS

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['graphite_influxdb']['install_method']</tt></td>
    <td>`git` or `pip`</td>
    <td>`git` is required for InfluxDB 0.9/0.10</td>
    <td><tt>`git`</tt></td>
  </tr>
</table>

## Usage

### chef-graphite-influxdb::default

Include `chef-graphite-influxdb` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[chef-graphite-influxdb::default]"
  ]
}
```

## License and Authors

Author:: Jarrett Hawrylak (jarrett.hawrylak)
