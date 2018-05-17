krb_utils CHANGELOG
===================

v0.2.3 (Mar 22, 2017)
---------------------
- Remove -norandkey ( Issues: #18 [COOK-29](https://issues.cask.co/browse/COOK-29) )

v0.2.2 (Sep 16, 2016)
---------------------
- Set ntp.sync_clock to true for users of ntp cookbook ( Issue: #14 )
- Use grep to parse kadmin get_principal output ( Issue: #15 )

v0.2.1 (Sep 13, 2016)
---------------------
- Create LICENSE.txt via GitHub ( Issue: #8 )
- Copy chefignore from caskdata/hadoop_cookbook ( Issue: #9 )
- Copy Gemfile from caskdata/hadoop_cookbook ( Issue: #10 )
- Use get_principal versus list_principals and grep ( Issue: #11 )
- Split recipe tests into their own files ( Issue: #12 )

v0.2.0 (Apr 12, 2016)
---------------------
- Allow unconfigured run to install client libraries ( Issue: #6 )

v0.1.2 (Sep 25, 2014)
---------------------
- Initial OSS release
