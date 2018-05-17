# nagios_v_shell

This cookbook downloads Nagios V-Shell and installs it to /usr/local, using the `ark` cookbook.

## Usage

Include `nagios_v_shell::default` in your run list or wrapper cookbook.

Nagios V-Shell will be downloaded and installed at `/usr/local/nagios-v-shell-<version>` and symlinked at `/usr/local/nagios-v-shell`.

## Attributes

<dl>
    <dt>['nagios_v_shell']['download_url']</dt>
    <dd>URL from which to download Nagios V-Shell. This may be set to an internal location if you don't have Internet access.</dd>
    <dt>['nagios_v_shell']['checksum']</dt>
    <dd>SHA-256 hash of the file to be downloaded.</dd>
    <dt>['nagios_v_shell']['version']</dt>
    <dd>Version of Nagios V-Shell hosted at the download URL.</dd>
</dl>

## Dependencies

The `ark` resource that this cookbook uses depends upon `unzip` and `rsync` being available on the system.

This cookbook also assumes you have Nagios installed. It does not do that for you.

## Future Direction

Future plans for this cookbook involve it configuring Apache for you and anything else the `install.php` script does.
