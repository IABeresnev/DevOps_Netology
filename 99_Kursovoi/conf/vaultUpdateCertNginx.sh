#!/bin/bash

echo "Update Cert Nginx" > /vaultprod/startuplog
sleep 10s
date >> /vaultprod/startuplog
echo "Importing ENV" >> /vaultprod/startuplog
source /etc/default/vault.env
export VAULT_ADDR='http://127.0.0.1:8200'
export VAULT_TOKEN=`cat /vaultprod/.vault-token`
echo $VAULT_TOKEN >> /vaultprod/startuplog
echo "Unsealing vault" >> /vaultprod/startuplog
sleep 2s
/usr/bin/vault operator unseal $KEY1
sleep 2s
/usr/bin/vault operator unseal $KEY2
sleep 2s
/usr/bin/vault operator unseal $KEY3 >> /vaultprod/startuplog
sleep 10s
export VAULT_ADDR='http://127.0.0.1:8200'
echo "New cert generating" >> /vaultprod/startuplog
json=$(/usr/bin/vault write -format=json pki_int/issue/example-dot-com common_name="test.shadow.com" ttl="720h")
echo $json >> /vaultprod/startuplog
if [ -z "$json" ]
then
        echo "Json is empty, something went wrong\n 1" >> /vaultprod/startuplog
        exit 1
else
        echo "Json is ok" >> /vaultprod/startuplog
fi
sleep 5s
echo "Parsing allcerts" >> /vaultprod/startuplog
echo $json | /usr/bin/jq -r '.data.certificate' | tee /vaultprod/test.shadow.com.crt /etc/ssl/certs/test.shadow.com.crt
echo $json | /usr/bin/jq -r '.data.private_key' | tee /vaultprod/test.shadow.com.key /etc/ssl/private/test.shadow.com.key
sleep 2s
echo "Restarting nginx" >> /vaultprod/startuplog
/usr/bin/systemctl restart nginx
echo "Sealing vault" >> /vaultprod/startuplog
/usr/bin/vault operator seal
