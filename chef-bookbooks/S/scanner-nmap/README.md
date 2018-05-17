scanner-nmap Cookbook
=====================
This cookbook installs and controls nmap scanning, either through
recipe and attribute or an LWRP

Attributes
----------

 * filename - File for scan output
 * options - Commandline options for nmap 
 * target - Target(s) for scanning
 * output - Type of output report

Usage
-----
#### scanner-nmap::default

Just include `scanner-nmap` in your node's `run_list` to install nmap:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[scanner-nmap]"
  ]
}
```

#### scanner-nmap::scan

Will run a scan based on cookbook attributes 

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[scanner-nmap]"
  ],
  "default_attributes": {
    "scanner-nmap":{
      "scan":{
        "filename":"/tmp/my_scan_nmap.xml",
        "target":"127.0.0.1"
      }
    }
  }
}
```

#### LWRP

```ruby
scanner-nmap "/tmp/my_scan_file-%D-%T.xml" do
  target  "127.0.0.1"
  output  :xml
  options "-vv -Pn -A"
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
Authors: Jason Rohwedder <jro@risk.io>
