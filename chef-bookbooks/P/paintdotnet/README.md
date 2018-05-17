# paintdotnet-cookbook

This cookbook installs Paint.Net on the windows platform.
Currently it displays a UI with a progress bar, it is not 
a true unattended install.

## Supported Platforms

Windows

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['paintdotnet']['version']</tt></td>
    <td>String</td>
    <td>Version number in the format X.X.X</td>
    <td><tt>4.0.1</tt></td>
  </tr>
  <tr>
    <td><tt>['paintdotnet']['unzipdir']</tt></td>
    <td>String</td>
    <td>The location where the paint.net zip file will be unzipped to.</td>
    <td><tt>C:/Temp</tt></td>
  </tr>
  <tr>
    <td><tt>['paintdotnet']['downloadurl']</tt></td>
    <td>String</td>
    <td>The URL to download the source zipped installer from..</td>
    <td><tt>http://www.dotpdn.com/files/paint.net.&lt;version&gt;.install.zip</tt></td>
  </tr>
 <tr>
    <td><tt>['paintdotnet']['checksum']</tt></td>
    <td>String</td>
    <td>The checksum used to verify the unzipped installer.</td>
    <td><tt>66d32ad200d9e736b162e3272db0c70d7a043020</tt></td>
  </tr>
  <tr>
    <td><tt>['paintdotnet']['package_name']</tt></td>
    <td>String</td>
    <td>The name of the package in add/remove programs</td>
    <td><tt>Paint.Net</tt></td>
  </tr>
</table>

## Usage

### paintdotnet::default

Include `paintdotnet` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[paintdotnet::default]"
  ]
}
```

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

## License and Authors

Author:: Sean Fleming (<seenya@gmail.com>)
