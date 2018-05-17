# babushka-cookbook

Chef cookbook to install babushka

## Supported Platforms

- Debian
- Ubuntu
- CentOS

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['babushka']['git']['clone_path']</tt></td>
    <td>String</td>
    <td>Local path to clone the babushka git repo</td>
    <td><tt>/opt/babushka</tt></td>
  </tr>
  <tr>
    <td><tt>['babushka']['git']['repo_path']</tt></td>
    <td>String</td>
    <td>Babushka git repository to clone</td>
    <td><tt>https://github.com/benhoskings/babushka.git</tt></td>
  </tr>
  <tr>
    <td><tt>['babushka']['git']['update_strategy']</tt></td>
    <td>Synbol</td>
    <td>Git repository update strategy</td>
    <td><tt>:sync</tt></td>
  </tr>
</table>

## Usage

### babushka::default

Include `babushka` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[babushka::default]"
  ]
}
```

## License and Authors

Author:: Jose Luis Salas <josacar@gmail.com>
