# os_floating_lo

Add system-level visibility into OpenStack floating IPv4 addresses.

This cookbook lights up an OpenStack instance's floating IPv4 address on a loopback alias interface. System resources which cannot leverage Ohai can now gain insight into floating IPs.

## Supported Platforms

- Centos
- Debian
- Fedora
- Debian

## Attributes

| Attribute | Default | Description |
| --- | --- | --- |
|`['device']`|`'lo:0'`|Device on which to apply the floating IP|
|`['mask']`|`'255.255.255.255'`|Netmask for the floating IP. Do not change unless absolutely required.|

## Usage

Include `os_floating_lo` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[os_floating_lo]"
  ]
}
```

## License and Authors

Author:: John Bartko (<jbartko@gmail.com>)

License:: [MIT License](LICENSE)
