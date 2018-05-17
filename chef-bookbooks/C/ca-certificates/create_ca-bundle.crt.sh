#!/bin/bash
export PATH="/usr/local/opt/openssl/bin:$PATH"

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Clone repo to extract nss root certs
[[ ! -d "${SCRIPT_DIR}/extract-nss-root-certs" ]] && git clone https://github.com/agl/extract-nss-root-certs.git "${SCRIPT_DIR}/extract-nss-root-certs"
cd "${SCRIPT_DIR}/extract-nss-root-certs"

# Remove any certificates from previous runs
git reset --hard origin/master
git clean -fd .

curl https://hg.mozilla.org/mozilla-central/raw-file/tip/security/nss/lib/ckfw/builtins/certdata.txt -o certdata.txt
go run convert_mozilla_certdata.go -to-files=true
[[ -f ca-bundle.pem ]] && \rm -f ca-bundle.pem || touch ca-bundle.pem
for cert in *.pem; do openssl x509 -text -in ${cert} >> ca-bundle.pem; done

\cp -f "${SCRIPT_DIR}/extract-nss-root-certs/ca-bundle.pem" "${SCRIPT_DIR}/files/default/ca-bundle.crt"

