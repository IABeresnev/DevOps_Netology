#!/bin/bash

export VAULT_ADDR='http://127.0.0.1:8200'

screen -d -m vault server -config=/etc/config.hcl
sleep 6s
vault operator init > /vaultprod/vaultprodINIT
sleep 6s
head -n 7 /vaultprod/vaultprodINIT | sed 's/Unseal Key /KEY/g' | sed 's/: /=/g' | sed 's/Initial Root Token/VAULT_ROOT_TOKEN/' > /etc/default/vault.env
head -n 7 /vaultprod/vaultprodINIT | grep Root | sed 's/Initial Root Token: //' > /vaultprod/.vault-token
export VAULT_TOKEN=`cat /vaultprod/.vault-token`
echo $VAULT_TOKEN >> /vaultprod/startuplog
echo "Unsealing vault" >> /vaultprod/startuplog
source /etc/default/vault.env
sleep 2s
/usr/bin/vault operator unseal $KEY1
sleep 2s
/usr/bin/vault operator unseal $KEY2
sleep 2s
/usr/bin/vault operator unseal $KEY3
export VAULT_ADDR='http://127.0.0.1:8200'
sleep 10s
/usr/bin/vault secrets enable pki
/usr/bin/vault secrets tune -max-lease-ttl=87600h pki
vault write -field=certificate pki/root/generate/internal common_name="shadow.com" ttl=87600h > CA_cert.crt
vault write pki/config/urls issuing_certificates="$VAULT_ADDR/v1/pki/ca" crl_distribution_points="$VAULT_ADDR/v1/pki/crl"
vault secrets enable -path=pki_int pki
vault secrets tune -max-lease-ttl=43800h pki_int
vault write -format=json pki_int/intermediate/generate/internal common_name="shadow.com Intermediate Authority" | jq -r '.data.csr' > pki_intermediate.csr
vault write -format=json pki/root/sign-intermediate csr=@pki_intermediate.csr format=pem_bundle ttl="43800h" | jq -r '.data.certificate' > intermediate.cert.pem
vault write pki_int/intermediate/set-signed certificate=@intermediate.cert.pem
vault write pki_int/roles/example-dot-com allowed_domains="shadow.com" allow_subdomains=true max_ttl="720h"
vault operator seal
sleep 2s
cp intermediate.cert.pem /vagrant/conf/intermediate.crt
cp CA_cert.crt /vagrant/conf/
ip addr show | grep dynamic > /vagrant/conf/ip.txt
crontab -l > cron_bkp
echo "*/10 * * * * /bin/bash /vaultprod/vaultUpdateCertNginx.sh" >> cron_bkp
crontab cron_bkp
rm cron_bkp
