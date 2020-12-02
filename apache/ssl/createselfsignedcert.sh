#!/usr/bin/env bash
if [ -z "$1" ]
then
  echo "Please supply a subdomain to create a certificate for";
  echo "e.g. www.mysite.com"
  exit;
fi

# Create a new private key if one doesnot exist, or use the existing one if it does
if [ -f certs/device.key ]; then
  KEY_OPT="-key"
else
  KEY_OPT="-keyout"
fi

DOMAIN=$1
COMMON_NAME=${2:-*.$1}
SUBJECT="/C=CA/ST=None/L=NB/O=None/CN=$COMMON_NAME"
NUM_OF_DAYS=3650
openssl req -new -newkey rsa:2048 -sha256 -nodes $KEY_OPT certs/device.key -subj "$SUBJECT" -out certs/$DOMAIN.csr
cat v3.ext | sed s/%%DOMAIN%%/$COMMON_NAME/g > /tmp/__v3.ext
openssl x509 -req -in certs/$DOMAIN.csr -CA certs/rootCA.crt -CAkey certs/rootCA.key -CAcreateserial -out certs/$DOMAIN.crt -days $NUM_OF_DAYS -sha256 -extfile /tmp/__v3.ext
rm certs/$DOMAIN.csr

echo
echo "\033[1;33mDone!\033[0m"
echo
echo "To use these files on your server, simply both $DOMAIN.crt and"
echo "device.key to your webserver, and use like so (if Apache, for example)"
echo
echo "    SSLCertificateFile    /path/to/$DOMAIN.crt"
echo "    SSLCertificateKeyFile /path/to/device.key"
echo
echo "Then in your browser, import the root CA. Go to 'Manage certificates', choose"
echo "'Authorities' table and import rootCA.crt."
echo
echo "Finally, in order to your PHP container accepts the certificate if your PHP script"
echo "sends requests to the server, copy rootCA.crt to /usr/local/share/ca-certificates"
echo "then run:"
echo
echo "    sudo update-ca-certificates"
echo