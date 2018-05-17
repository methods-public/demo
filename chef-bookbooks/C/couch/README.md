Couch Cookbook
==============
This cookbook installs and configures the CouchDB Service.

Currently it only supports installing CouchDB from source however
there are plans to use existing OS packages.

Requirements
------------
#### Cookbooks
- yum-epel
- ark
- build-essentials

#### Operating Systems
- CentOS, RHEL, Scientific Linux
- Ubuntu

#### Packages
This cookbook was tested using the erlang community cookbook
esl recipe.

- Erlang
- Erlang Headers when compiling Couchdb from Source

Resource/Provider
-----------------

### couch_service

#### actions

- **create** - creates the couchdb service
- **delete** - removes the couchdb service
- **start** - starts and enables the couchdb service
- **stop** - stops the couchdb service
- **restart** - restarts the couchdb service

#### attributes

- **port** - the port to bind the couchdb service to, defaults to 5984
- **bind_address** - the bind address for the couchdb service, defaults to 127.0.0.1
- **from_package** - whether to install couchdb from package, defaults to false (Unsupported on RHEL)
- **source_version** - the version of couchdb to install from source
- **source_url** - the url to download the source from
- **source_checksum** - the sha256 checksum of the source package
- **source_package** - the source package name
- **path_prefix** - the prefix path to install couchdb to from source

### couch_config

#### actions

- **create** - Creates a couchdb config from template
- **remove** - Removes a couchdb config

#### attributes

- **variables** - the variables to pass to the template
- **source** - the template source

### couch_database
Creates a couchdb database

#### actions

- **create** - Creates the couchdb database
- **delete** - Deletes a couchdb database

#### attributes

- **database** - Name of the database (defaults to the name attribute)
- **host** - the host to make the call to
- **port** - the port to use when making the rest call
- **admin** - the admin user to use
- **password** - the admin password
- **secure** - whether to use SSL when communicating
- **verify_ssl** - whether to verify the ssl certificate

### couch_replication

#### actions

- **create** - Sets up replication

#### attributes

- **source** - the source of the replication
- **target** -  the target for the replication
- **replicator_db** - the replicator db
- **continuous** - whether to make the replication continuous
- **create_target** - see docs
- **doc_ids** - see docs
- **proxy** - see docs
- **since_seq** - see docs
- **filter** - see docs
- **query_params** - see docs
- **use_checkpoints** - see docs
- **checkpoint_interval** - see docs
- **host** - the host to make the call to
- **port** - the port to use when making the rest call
- **admin** - the admin user to use
- **password** - the admin password
- **secure** - whether to use SSL when communicating
- **verify_ssl** - whether to verify the ssl certificate

### couch_query

#### actions

- **get** - Executes a Get query
- **put** - Executes a put query
- **post** - Executes a post query
- **delete** - Executes a delete query

#### attributes

- **urn** - the urn to use for the query (defaults to the name attribute)
- **body** - the body to send to couchdb
- **response_code** - expected http response code from the query
- **host** - the host to make the call to
- **port** - the port to use when making the rest call
- **admin** - the admin user to use
- **password** - the admin password
- **secure** - whether to use SSL when communicating
- **verify_ssl** - whether to verify the ssl certificate

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
- Author:: Jim Rosser(jarosser06@gmail.com)

```text
copyright (C) 2015 Jim Rosser

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without restriction,
including without limitation the rights to use, copy, modify, merge,
publish, distribute, sublicense, and/or sell copies of the Software,
and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
```
