syslogger Cookbook
==================

This cookbook sends log messages to syslog via the logger utility

Requirements
------------

Should only be dependant on logger utility being present.

LWRP Usage
-----

```ruby
syslogger "Log something neat"
```

```ruby
syslogger "log_begin_deploy" do
  message "Begin #{deploy_action} of #{app_name} on #{deploy_revision}"
  tag     "deploy"
  action  :write
  not_if { node['something'] }
end
```

```ruby
syslogger "log_finish_deploy" do
  message "Finish #{deploy_action}"
  tag     "deploy"
  action :nothing
end

deploy "my_deploy" do
  notifies :write, "syslogger[log_finish_deploy]", :immediately
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
