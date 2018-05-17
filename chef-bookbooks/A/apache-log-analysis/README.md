apache-log-analysis Cookbook
================
[![Build Status](https://travis-ci.org/DennyZhang/apache-log-analysis.svg?branch=master)](https://travis-ci.org/DennyZhang/apache-log-analysis)
Analysis apache logs by logstash, elasticsearch and kibana

![](https://github.com/DennyZhang/apache-log-analysis/raw/master/apache_analysis1.png)
![](https://github.com/DennyZhang/apache-log-analysis/raw/master/apache_analysis2.png)

Requirements
------------
### Platform
- Debian/Ubuntu
- RHEL/CentOS/Scientific
- Fedora

Recipes
-------
* default

Usage
-----

Enable by `recipe[apache-log-analysis]`.

```
| Name                              | Comment                         |
|:----------------------------------|---------------------------------|
|  java                             | /usr/lib/jvm/default-java       |
| /etc/init.d/logstash_server       | Manage logstash service         |
| /etc/init.d/logstash_agent        | Manage logstash service         |
| /opt/logstash/server              | logstash server                 |
| /opt/logstash/server/etc          | logstash server configuration   |
| /opt/logstash/server/log          | logstash server log             |
| /etc/sv/logstash_server           | logstash server                 |
| /etc/init.d/kibana                | Manage kibana service           |
| /usr/local/etc/kibana             | kibana configuration            |
| /usr/local/var/log/kibana         | kibana log                      |
| /etc/init.d/elasticsearch         | Manage elasticsearch service    |
| /usr/local/etc/elasticsearch      | elasticsearch configuration     |
| /usr/local/var/data/elasticsearch | elasticsearch data              |
| /usr/local/var/log/elasticsearch  | elasticsearch log               |
```

Attributes List
---------------

License & Authors
-----------------
- Author:: DennyZhang001 <denny.zhang001@gmail.com>
- Copyright:: 2015, http://DennyZhang.com

```text

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
