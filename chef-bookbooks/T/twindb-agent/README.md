# twindb-agent

## Description

  This cookbook provides provides the ability to configure, install and
  register TwinDB agent.

## Required Cookbooks

  * twindb-repo

## Attributes

## Usage

  Set node specific overrides, and add recipe["twindb-agent::default"] to the run_list

### twindb-agent::register recipe

A recipe to register the TwinDB agent.

Example twindb-agent node configuration is shown below.

```json
"normal": {
  "twindb_agent": {
      "registration_code": "0f6714f735a06a488ec92asasssx0a3f2"
  }
}
```

### twindb-agent::unregister recipe

A recipe to unregister the TwinDB agent.

## License and Author

Copyright 2015, Ovais Tariq <ovaistariq@twindb.com>  

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
