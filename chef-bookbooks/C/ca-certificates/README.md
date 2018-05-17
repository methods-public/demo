ca-certificates Cookbook
========================

This cookbook installs ca-certificates.

How to generate the base ca-bundle.pem
--------------------------------------
    git clone https://github.com/agl/extract-nss-root-certs.git
    cd extract-nss-root-certs
    curl https://hg.mozilla.org/mozilla-central/raw-file/tip/security/nss/lib/ckfw/builtins/certdata.txt -o certdata.txt
    go run convert_mozilla_certdata.go -to-files=true
    [[ -f ca-bundle.pem ]] && rm -f ca-bundle.pem || touch ca-bundle.pem
    for cert in `ls *.pem`; do openssl x509 -text -in ${cert} >> ca-bundle.pem; done

Requirements
------------

#### OS
Must be running a RHEL distro. I added debian support recently, but it's testing is very limited.

Attributes
----------
### package

This is the name of the package to be installed by the package manager.

### ca-bundle_path

This is the location of the actual ca-bundle.crt that is installed by the package manager.

Usage
-----
#### ca-certificates::default
Just include `ca-certificates` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[ca-certificates]"
  ]
}
```

License and Authors
-------------------
Authors: Jason Barnett (<J@sonBarnett.com>)
