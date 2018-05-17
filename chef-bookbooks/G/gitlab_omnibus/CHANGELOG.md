# Changelog

1.2.0
---------
- Add support for Gitlab Container Registry (Frank Muller)
- Remove old CI code (Frank Muller)

1.1.0
---------
- Update poise to 2.x

1.0.2
---------
- Fixed #19: Add a delayed reconfigure on first install if GitLab CI is enabled. Allows OAuth configuration to
  be generated.
- Add documentation on converting YAML configuration to Ruby hashes for use with this cookbook. See README.md

1.0.1
---------
- Fixed #18: Add `git_data_dir` configuration key. 

1.0.0
---------
- Release after using `0.9.x` series in production for a few weeks.

0.9.2
---------
- Fixed #17: Change from packagecloud node attributes to resource attributes

0.9.1
---------
- Fix #10: Restart after configuration change.
- As part of fixing #10, also optimize reconfigures so there aren't unnecessary reconfigurations
  especially on first install.
- Ensure restart occurs when a new version of GitLab is installed.

0.9.0
---------
- Breaking changes: Lots has changed. The changes were to facilitate the new GitLab package server.
  See the README for more information on attributes.
- Use new GitLab package server (APT/YUM)
- Clean up recipe
- Add new service resource to add `reconfigure` action
- Clean up tests
- Change backup cron time to 3:00. (2:00 is when daylight savings time rolls over so it's a bad time to do tasks)
- Add GitLab CI backup cron
- Change service commands to use /opt/gitlab/bin to avoid issue where symlink may have been deleted.

0.3.0
---------
- Feature: Configure backup cron.
- Bump default version to 7.9.2

0.2.1
---------
- Bug: Chef client 12.1.0 broke yum package install from source for
  CentOS. Change to RPM provider. See issue #6

0.2.0
---------
- Bug: Fix handling of various configuration values (nil, hash, array, etc)
- Feature: Install package from yum/apt repo instead of remote file download

0.1.0
---------
- Initial release
