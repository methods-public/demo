# frontaccounting-cookbook

Installes FrontAccounting (http://www.frontaccounting.com)

## Supported Platforms

Tested on CentOS 6.6. Other platforms may work, possibly with some modifications.

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['frontaccounting']['baseurl']</tt></td>
    <td>String</td>
    <td>The URL file path under which the accounting package should be available</td>
    <td><tt>/accounting</tt></td>
  </tr>
  <tr>
    <td><tt>['frontaccounting']['documentroot']</tt></td>
    <td>String</td>
    <td>The directory in the file system where the root of the Web server is located. The baseurl will be added later</td>
    <td><tt>/var/www/html</tt></td>
  </tr>
  <tr>
    <td><tt>['frontaccounting']['servername']</tt></td>
    <td>String</td>
    <td>The server name (for virtual hosting)</td>
    <td><tt>The machine's FQDN</tt></td>
  </tr>
  <tr>
    <td><tt>['frontaccounting']['fileuser']</tt></td>
    <td>String</td>
    <td>The user name who should own the files in the application</td>
    <td><tt>root</tt></td>
  </tr>
  <tr>
    <td><tt>['frontaccounting']['filegroup']</tt></td>
    <td>String</td>
    <td>The group name who should own the files in the application</td>
    <td><tt>apache</tt></td>
  </tr>
  <tr>
    <td><tt>['frontaccounting']['company']</tt></td>
    <td>Array</td>
    <td>Information about each company in the Frontaccounting database. Note that
the password is not included here; you must pass the passwords using node.run_state
instead.</td>
    <td><tt>['companyname'] = "Sample Company Inc."<br/>
            ['dbhost'] = "localhost"<br/>
            ['dbname'] = "frontacc"<br/>
            ['dbuser'] = "frontacc"<br/></tt></td>
  </tr>
</table>

## Usage

### frontaccounting::default

Set up a Web server, for instance using the httpd cookbook. If you are using nginx or
other servers, you may need additional work to make php work.

Set any attributes you need as non-default.

Specify the database password using the node.run_state[:frontaccounting_dbpw] mechanism:

<code>node.run_state[:frontaccounting_dbpw] = 'password'</code>

Include `frontaccounting` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[frontaccounting::default]"
  ]
}
```

After this cookbook is installed, FrontAccounting will have a single company. The COA,
user names and passwords come from the database en_US-demo.sql that are shipped with
FrontAccounting. As of this writing, the initial user names and passwords are:

<table>
 <tr>
  <td>admin</td><td>password</td>
 </tr>
 <tr>
  <td>demouser</td><td>password</td>
 </tr>
</table>

You should immediately change the user names and passwords for these users.

## License and Authors

Author:: North County Tech Center, LLC (<kkeane@4nettech.com>)
License:: GPLv3

