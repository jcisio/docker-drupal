#!/bin/sh
sh createRootCA.sh
sh createselfsignedcert.sh docker.localhost
cat rootCA.pem >> docker.localhost.crt
rm docker.localhost.csr
rm rootCA.*
