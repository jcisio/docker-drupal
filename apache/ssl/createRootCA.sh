#!/usr/bin/env bash
if [ -f certs/rootCA.crt ] && [ -f certs/rootCA.key ]
then
    echo "\033[1;31mrootCA.{key,crt} exists. Please remove it first to create a new root CA.\033[0m"
    exit 1
fi
openssl genrsa -out certs/rootCA.key 2048
openssl req -x509 -new -nodes -key certs/rootCA.key -sha256 -days 3650 -out certs/rootCA.crt \
    -subj "/C=FR/ST=75/L=Paris/O=Localhost Ltd/emailAddress=me@localhost"
rm rootCA.srl
