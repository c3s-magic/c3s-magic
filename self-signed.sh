#!/bin/bash

#generate a certificate, and create a truststore based on the esgf truststore, but with the self signed certificate in it as well.

HOSTNAME=192.168.188.36

#generate self-signed certificate
keytool -genkey -noprompt -keypass password -alias tomcat -keyalg RSA -storepass password -keystore keystore.jks -dname CN=$HOSTNAME

curl -L https://raw.githubusercontent.com/ESGF/esgf-dist/master/installer/certs/esg-truststore.ts > esg-truststore.ts

# export certificate from a keystore to a file called some-certificate.pem
keytool -export -alias tomcat -rfc -file some-certificate.pem -keystore keystore.jks -storepass password

# put this certificate from some-certificate.pem into the truststore
keytool -import -v -trustcacerts -alias adagucservicescert -file some-certificate.pem -keystore esg-truststore.ts -storepass changeit -noprompt
