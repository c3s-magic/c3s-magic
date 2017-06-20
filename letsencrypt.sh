#!/bin/bash
set -e

echo "putting certificate in keystore"
sudo openssl pkcs12 -export -in /etc/letsencrypt/live/compute-test.c3s-magic.eu/fullchain.pem -inkey /etc/letsencrypt/live/compute-test.c3s-magic.eu/privkey.pem -out fullchain_and_key.p12 -name tomcat -passout pass:password
sudo keytool -delete -alias tomcat -keystore config/portal/c4i_keystore.jks -storepass password -noprompt
sudo keytool -importkeystore -deststorepass password -destkeystore config/portal/c4i_keystore.jks -srckeystore fullchain_and_key.p12 -srcstoretype PKCS12 -srcstorepass password -alias tomcat

keytool -export -alias tomcat -rfc -file ~/adagucservicescert.pem -keystore config/portal/c4i_keystore.jks -storepass password

echo "removing certificate from truststore"
sudo keytool -delete -alias adagucservicescert -keystore config/portal/esg-truststore.ts -storepass changeit -noprompt

echo "import certificate to truststore"
keytool -import -v -trustcacerts -alias adagucservicescert -file ~/adagucservicescert.pem -keystore config/portal/esg-truststore.ts -storepass changeit -noprompt

