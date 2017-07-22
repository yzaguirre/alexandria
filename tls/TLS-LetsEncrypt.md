<!-- $theme: gaia -->

# DEPENDENCIAS
Install software
```
apt update && apt install git openssl
git clone "https://github.com/diafygi/letsencrypt-nosudo.git"
cd letsencrypt-nosudo
chmod u+x sign_csr.py
ln -s $PWD/sign_csr.py ~/bin/sign_csr
```
Create private key
```
openssl genrsa -aes128 4096 -out user.key
openssl rsa -in user.key -pubout -out user.pub
```

---
# DOMAIN PRIVATE KEY
```
SITENAME=site1
openssl genrsa -aes128 -out $SITENAME.key.secure 2048
openssl rsa -in $SITENAME.key.secure -out $SITENAME.key
```

---
# DOMAIN PRIVATE KEY - Extras

---
# CSR
```
openssl req -new -sha256 -key $SITENAME.key.secure \
-out $SITENAME.csr
```

---
# CSR - Extras

---
# SIGN CERTIFICATE
```
sign_csr --public-key user.pub $SITENAME.csr \
> $SITENAME.crt
```

---
# SIGN CERTIFICATE - Extras

---
# Obtener certificado intermediario
```
wget "https://letsencrypt.org/certs/lets-encrypt-x3-cross-signed.pem"
```

---
# Custom DH parameters
```
openssl dhparam -out dhparam.pem 2048
```

---
# Certificado en cadena (fullchain)
```
cat certs/$SITENAME.crt \
lets-encrypt-x3-cross-signed.pem \
dhparam.pem \
> certs/${SITENAME}_chained.pem
```

---
# Certificado en cadena (fullchain) - II
```
cat $SITENAME.key $SITENAME.crt lets-encrypt-x1-cross-signed.pem dhparam.pem > znc.pem
```
