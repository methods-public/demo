# bash_history_timestamp


This simple cookbook adds timestamp logging to specified users' bash history.  By default, only the root user's history is configured.  You can specify other users to be managed by Chef with similar histtimeformatting.

This project originated to provide some quick auditing of bash history if you have multiple users sudo'ing to root.


## Usage
You can configure the way the timestamp is formatted in the attributes file.  Default format is `'%F %T '` which will format like 'YYYY-mm-dd hh:mm:ss '.

## Attributes
| Name                                    |  Default       | Description                             |
| --------------------------------------- |:--------------:|:---------------------------------------:|
|`['bash_history_timestamp']['flags']`    |`'%F %T '`|Configure formatting of history output. `man histtimeformat` for more info.|
|`['bash_history_timestamp']['bash_file']`|`'/root/.bashrc'`|Full path to bash file, typically `.bashrc` or `.bash_profile`|
|`['bash_history_timestamp']['managed_users']`|`['root']`||Manage only root user|

## Testing
There are kitchen tests associated with CentOS 5.10, 6.6, 7.1. 

I've manually tested and verified this cookbook with other Linux distros, but only CentOS 5+ is officially supported.

Serverspec tests may fail because when running the spec it does not actually create a login shell.  `man bash` for details. YMMV when running `kitchen test` with other vagrant boxes.


## TODO
Allow overrides of user homes instead of only supporting `/home/<username>`
