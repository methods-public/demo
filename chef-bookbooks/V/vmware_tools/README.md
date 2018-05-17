# vmware_tools

Installs vmware tools if the machine is virtual.


## Usage

### vmware_tools::default

Just include `vmware_tools` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[vmware_tools]"
  ]
}
```