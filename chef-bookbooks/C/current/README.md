# current

Installs the [current](http://current.sh/) package and provides a LWRP for sending log files to current.

## Recipes

* `default` - Nothing
* `install` - Installs the package

## Attributes

* `node['current']['token']` - Default token to use for services. Optional.

## LWRPs

### `current_send`

Setup a runit service to send a log file to current.

Example:

```
current_send 'some-app' do
  filename '/var/log/some-app/asdf.log'
  token 'asdfasdfasdfasdfasdf'
end
```

If you have the token set in an attribute, you can leave it off the resource:

```
current_send 'some-other-app' do
  filename '/var/log/some-other-app/asdf.log'
end
```

You can also set an array of tags to send to current.

## License and Author

License: [MIT](https://github.com/dwradcliffe/chef-curret/blob/master/LICENSE)

Author: [David Radcliffe](https://github.com/dwradcliffe)
