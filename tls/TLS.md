# TLS all you need to know
To explain the importance of TLS, the following links may help with that
1. https://www.digitalocean.com/community/tutorials/how-to-create-an-ecc-certificate-on-nginx-for-debian-8
2. http://wiki.samat.org/CheatSheet/OpenSSL
3. https://www.openssl.org/docs/apps/ec.html#EXAMPLES
4. https://www.openssl.org/docs/apps/ecparam.html#EXAMPLES
5. https://www.digitalocean.com/community/tutorials/openssl-essentials-working-with-ssl-certificates-private-keys-and-csrs

---
# Cert
## Make directories
```bash
mkdir -p /etc/ssl/{newcerts,certs,requests,private,CA}
cd /etc/ssl
```

---
# Certificate Signed by CA
## Create Private Key
Create de private key with and without a password for the www.securejump.com site.
```bash
openssl genrsa -aes256 -out private/www_securejump_com.key.secure 2048
openssl rsa -in private/www_securejump_com.key.secure -out private/www_securejump_com.key
chmod 600 private/www_securejump_com.key*
```
Options
* `-des3` encrypt the generated key with DES in ede cbc mode (168 bit key)
* `-out private/www_securejump_com.key.secure` output the key to

---
* `-keyout private/cakey.pem` file to send the key to

Generate a ECC private cert and encrypt said cert
https://www.digitalocean.com/community/tutorials/how-to-create-an-ecc-certificate-on-nginx-for-debian-8
```bash
openssl ecparam -out private/www_securejump_com.key -name prime256v1 -genkey
openssl ec -in private/www_securejump_com.key -aes256 -out private/www_securejump_com.key.secure
chmod 600 private/www_securejump_com.key*
```
Options
* `-out private/www_securejump_com.key.secure` output file
* `-name prime256v1` use the ec parameters with 'prime256v1' short name
* `-genkey` generate ec key


---
# Create Certificate Sign Request CSR
```bash
openssl req -new -sha256 -key private/www_securejump_com.key -out requests/www_securejump_com.csr
```
Options
* `-new` new request.
* `-sha256` Digest to sign with
* `-key private/www_securejump_com.key` use the private key contained in file
* `-out requests/www_securejump_com.csr` output file

Non-interactively answer the CSR information prompt
`-subj "/C=US/ST=New York/L=Brooklyn/O=Example Brooklyn Company/CN=examplebrooklyn.com"`

---
# Self signed certificate
**Optional**
```bash
openssl x509 -req -days 365 -in requests/www_securejump_com.csr -signkey private/www_securejump_com.key.secure -out certs/www_securejump_com.crt
```
Options
* `-req` input is a certificate request, sign and output.
* `-days 365` How long till expiry of a signed certificate - def 30 days
---
* `-in requests/www_securejump_com.csr` input file - default stdin
* `-signkey private/www_securejump_com.key.secure` self sign cert with arg
* `-out certs/www_securejump_com.crt` output file - default stdout

---
# signed certificate by self CA
## 1 - Create CA Cert
```bash
echo "01" > serial
touch index.txt
openssl req -new -x509 -newkey rsa:2048 -keyout private/cakey.pem -out cacert.pem -days 3650
```
Enter secure passphase. Options:
* `new` new request
* `-x509` output a x509 structure instead of a cert. req.
* `-newkey rsa:2048` generate a new RSA key of '2048' bits in size

---
* `-keyout private/cakey.pem` file to send the key to
* `-out cacert.pem` output file
* `-days 3650` number of days a certificate generated by -x509 is valid for.

---
# 2 - Sign csr file with our CA
```bash
openssl ca -policty policy_anything -in requests/www_securejump_com.csr -out certs/www_securejump_com.crt
```
Options
* `-policty policy_anything` The CA 'policy' to support
* `-in requests/www_securejump_com.csr` The CA 'policy' to support
* `-out certs/www_securejump_com.crt` Where to put the output file(s)

---
## Send csr file to CA for signing
Place the signed certificate in `certs` folder
## CA public certificate files
Concatenate these public cert into one file
```bash
cat COMODORSADomainValidationSecureServerCA.crt COMODORSAAddTrustCA.crt AddTrustExternalCARoot.crt > certs/www_securejump_com.ca-bundle
```

---
### Bundle .pfx
To create .pfx or .p12, do this:
```bash
openssl pkcs12 -export -in certs/www_securejump_com.crt -inkey private/www_securejump_com.key.secure -certfile certs/www_securejump_com.ca-bundle -out www_securejump_com.pfx
```
Options
* `-export` output PKCS12 file
* `-in certs/www_securejump_com.crt` input file name
* `-inkey private/www_securejump_com.key.secure` private key if not infile
* `-certfile certs/www_securejump_com.ca-bundle` add all certs in www_securejump_com.ca-bundle
* `-out www_securejump_com.pfx` output filename

And choose an export password.

---
# Self Signed Certificate without Certificate Sign Request
## Create Priv Cert and Pub Cert
```bash
openssl req -new -x509 -sha256 -days 365 -newkey rsa:2048 -keyout private/www_securejump_com.key -out certs/www_securejump_com.crt
```
Options
* `-new` new request.
* `-x509` output a x509 structure instead of a cert. req.
* `-sha256` Digest to sign with

---
* `-days 365` number of days a certificate generated by -x509 is valid for.
* `-newkey rsa:2048` generate a new RSA key of 2048 bits in size
* `-keyout private/www_securejump_com.key` file to send the key to
* `-out certs/www_securejump_com.crt` output file

---
## Client cert
Same process
```bash
openssl genrsa -des3 -out private/firefox.key.secure 2048
chmod 600 private/firefox.key.secure
openssl req -new -sha256 -key private/firefox.key.secure -out requests/firefox.csr
openssl x509 -req -days 365 -in requests/firefox.csr -signkey private/firefox.key.secure -out certs/firefox.crt
```
---
# Revoke a cert
## Revoke CA cert
```bash
openssl ca -revoke private/cakey.pem
```
## Setup certificate revocation list (CRL)
```bash
mkdir crl
openssl ca -config openssl.cnf -gencrl -out crl/crl.pem
```
Options
* `-config openssl.cnf` A config file
* `-gencrl` Generate a new CRL
* `-out crl/crl.pem` Where to put the output file(s)

---
## Renew a certificate
