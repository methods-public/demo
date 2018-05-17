# go_chef cookbook

This is my first attempt at a Golang cookbook. I am starting first with Centos 7 and will move on from there.

This is going to be an almost total rework of the existing Golang Coobook here:
`https://github.com/NOX73/chef-golang`.

Criticize as you see fit.

## Currently Supported OS List

```
centos-7
debian-9
ubuntu-16.04
```

## Attributes

See `attributes/default.rb` for default values.

- `default['go']['version']` - Version number of golang you want installed. See `https://golang.org/dl/` for a complete listing of version numbers.

- `default['go']['platform']` - This is not being used yet but I am keeping it for the future.

- `default['go']['filename']` - The name of the golang version that will be downloaded.

- `default['go']['url']` - The url of the golang version that will be downloaded.

- `default['go']['override_url']` - Mark this as true if you will be submitting an alternate link to a golang version to download. Especially useful if your vms do not have access to the golang website and you need to repose it instead.

- `default['go']['alternate_url']` - The full alternate link from which the tar file will be extracted.

- `default['go']['install_dir']` - The install location of golang.

- `default['go']['project_home']` - The home location where your projects will be stored. It is optional to actually store your projects there.

- `default['go']['gopath']` - Your gopath.

- `default['go']['gobin']` - Your gobin.  

- `default['go']['dir_permissions']` - The permissions that will be used to make the directories in your gopath.

## Contributing

If you have any questions, comments, complaints, or contribution requests you can make an issue and/or a pull request. Make a new branch and see the changelog for the format of a change.
