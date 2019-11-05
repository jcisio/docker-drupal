#!/usr/bin/env bash
openssl genrsa -out rootCA.key 2048
openssl req -x509 -new -nodes -key rootCA.key -sha256 -days 3650 -out rootCA.pem \
    -subj "/C=FR/ST=75/L=Paris/O=Localhost Ltd/emailAddress=me@localhost"
