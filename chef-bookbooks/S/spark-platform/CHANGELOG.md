Changelog
=========

1.1.0
-----

Main:

- Use Spark 1.6.2 by default (with hadoop2.6)
- Set default for spark local\_dir to /tmp/spark instead of /tmp
- Fix incorrect config related to scratch space
- Set default spark group as system and use append to allow external
  modifications

Test:

- Add seccomp=unconfined to allow systemd
- Strengthen gitlab-ci tests, use image directly with skip\_preparation
- Add retry on java package installation

1.0.0
-----

- Initial version tested on centos 7 with Spark 1.6.1
