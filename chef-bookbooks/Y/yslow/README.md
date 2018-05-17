[![Build Status](https://travis-ci.org/bendodd/yslow-cookbook.png)](https://travis-ci.org/bendodd/yslow-cookbook)

YSlow cookbook
==========
Install Yslow for PhantomJS

Requirements
------------
PhantomJS Cookbook

Attributes
----------

#### yslow::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['yslow']['version']</tt></td>
    <td>String</td>
    <td>Version to install</td>
    <td><tt>3.1.8</tt></td>
  </tr>
  <tr>
    <td><tt>['yslow']['checksum']</tt></td>
    <td>String</td>
    <td>Files checksum</td>
    <td><tt>648d7ac9daf16836a9d17c7cbb4b7e73</tt></td>
  </tr>
  <tr>
    <td><tt>['yslow']['install_dir']</tt></td>
    <td>String</td>
    <td>Install directory</td>
    <td><tt>/opt/yslow</tt></td>
  </tr>
  <tr>
    <td><tt>['yslow']['base_url']</tt></td>
    <td>String</td>
    <td>URL form which to get the library</td>
    <td><tt>http://yslow.org</tt></td>
  </tr>
</table>

Usage
-----
#### yslow::default

    {
      "name":"my_node",
      "run_list": [
        "recipe[yslow]"
      ]
    }

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Author:: Benedict Dodd (benedict.dodd@gmail.com)
