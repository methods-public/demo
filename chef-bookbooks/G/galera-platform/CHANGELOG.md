Changelog
=========

2.0.0
-----

Main:

- Support mariadb 10.2 and do not support older version
- Add auto-restart option: restart if config changes (false by default)

Test:

- Set docker seccomp policy to undefined
- Use template 20160914 of .gitlab-ci.yml

1.0.0
-----

- Initial version for RHEL Family 7 (tested on Centos 7) supporting MariaDB by
  default (should be able to support MySQL too).
