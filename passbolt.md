### Passbolt

**Image**

[Official Passbolt Image](https://hub.docker.com/r/passbolt/passbolt)

```
docker pull passbolt/passbolt
```

<br>

**Start Container**

```
docker run -d \
    --name=YOUR_CONTAINER_NAME \
    --ip IP_ADDRESS --network YOUR_DOCKER_NETWORK \
    --hostname=YOUR_PASSBOLT_HOSTNAME \
    --restart=unless-stopped \
    -e DATASOURCES_DEFAULT_HOST=YOUR_DATABASE_SERVER \
    -e DATASOURCES_DEFAULT_PASSWORD=YOUR_DB_PASSWORD \
    -e DATASOURCES_DEFAULT_USERNAME=YOUR_DB_USER \
    -e DATASOURCES_DEFAULT_DATABASE=YOUR_PASSBOLT_DB_NAME \
    -e APP_FULL_BASE_URL=https://YOUR_PASSBOLT_APP_URL \
    passbolt/passbolt
```

<br>

**Post-installation configurations**

```
# Generate self-signed certificate

openssl req -x509 \
    -newkey rsa:4096 \
    -days SPECIFY_YOUR_OWN \
    -subj "/C=YOUR_COUNTRY/ST=YOUR_STATE/L=YOUR_CITY/O=YOUR_ORG/OU=YOUR_OU/CN=YOUR_PASSBOLT_APP_URL/" \
    -nodes \
    -addext "subjectAltName = DNS:YOUR_PASSBOLT_APP_URL" \
    -keyout passbolt_self_signed_key.pem \
    -out passbolt_self_signed_cert.pem


# Create your first admin user

docker exec -it YOUR_CONTAINER_NAME bash

su -m -c "/usr/share/php/passbolt/bin/cake passbolt register_user -u YOUR_ADMIN_USER@YOUR_DOMAIN.COM -f YOUR_FIRSTNAME -l YOUR_LASTNAME -r admin" -s /bin/sh www-data


# Edit  /etc/nginx/snippets/passbolt-ssl.conf  to point to your self-generated certificates.

apt-get install nano -y
nano /etc/nginx/snippets/passbolt-ssl.conf


# Restart nginx

service nginx restart
```

<br>

**Import/install the self-signed certificates (on Windows and Android)**

- Import the *passbolt_self_signed_cert.pem* certificate into Windows' "Trusted Root Certification Authorities".
- On Android devices, go to *Security & privacy* - *Encryption & credentials* - *Install a certificate* - *CA certificate* - *Install anyway* - Browse to the passbolt_self_signed_cert.pem cert file and install it.
- [Official FAQ on generating self-signed cert.](https://help.passbolt.com/faq/hosting/mobile-faq)
- [Official FAQ on installing cert on Android devices.](https://help.passbolt.com/faq/hosting/how-to-import-ssl-certificate-on-mobile)

<br>

**Conclusion**

After the above steps, Passbolt should be working on Windows and Android. Chrome's cache & cookies might need to be cleared before the new cert takes effect.

**Note:** When generating the self-signed certificate, the ***subjectAltName*** must be specified, otherwise you'll likely encounter the following error when scanning the QR code. [See this post.](https://community.passbolt.com/t/error-setting-up-mobile-app/5875)

***There was an error during transfer update(Something went wrong!)***
