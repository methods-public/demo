SPAC Cookbook
=============
This cookbook will install the spac service and applies the configuration.
For more information about spac, please read:
https://github.com/sbotman/spac/blob/master/README.md


Attributes
----------
Configuration of the spac service can be done by setting attributes.  

#### spac::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['spac']['server']</tt></td>
    <td>String</td>
    <td>IP Address to listen on.</td>
    <td><tt>0.0.0.0</tt></td>
  </tr>
  <tr>
    <td><tt>['spac']['port']</tt></td>
    <td>Integer</td>
    <td>Port to listen on.</td>
    <td><tt>9000</tt></td>
  </tr>
  <tr>
    <td><tt>['spac']['apps']</tt></td>
    <td>Hash</td>
    <td>Applications and ports.</td>
    <td></td>
  </tr>
</table>

Usage
-----
#### spac::default
Add the spac cookbook as dependency to your cookbook.  
Use the spac resource to install and configure the service.  
  
e.g.

```ruby
spac 'exe' do
  url node['spac']['url']
  version node['spac']['version']
  checksum node['spac']['checksum']
end
```

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Sander Botman
