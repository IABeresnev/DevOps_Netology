###Домашнее задание к занятию "3.9. Элементы безопасности информационных систем"

1. Установите Bitwarden плагин для браузера. Зарегистрируйтесь и сохраните несколько паролей.  
Готово.<br>
![BW!](/14_Lesson_sec_1/images/bw.png)<br>
2. Знаю как настроить, но сейчас эта функция доступна только в BitWarden платной версии. 2ух факторной авторизацией пользуюсь и от Google в том числе.
3. Установите apache2, сгенерируйте самоподписанный сертификат, настройте тестовый сайт для работы по HTTPS.
```commandline
vagrant@vagrant:~$ sudo su
root@vagrant:/home/vagrant# apt install apache2
root@vagrant:/home/vagrant# openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/apache-selfsigned.key -out /etc/ssl/certs/apache-selfsigned.crt
Generating a RSA private key
........................................+++++
.............................................................................................................................+++++
writing new private key to '/etc/ssl/private/apache-selfsigned.key'
-----
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:RU
State or Province Name (full name) [Some-State]:Astrakhanskaya Oblast
Locality Name (eg, city) []:Astrakhan
Organization Name (eg, company) [Internet Widgits Pty Ltd]:HomeLab
Organizational Unit Name (eg, section) []:Room1
Common Name (e.g. server FQDN or YOUR name) []:vagrant.homelab.com
Email Address []:admin@homelab.com
```
Установили Apache2 и сгенерировали сертификат
```commandline
nano /etc/apache2/conf-available/ssl-params.conf
```
Настраиваем параметры работы Apache по SSL
```commandline
SSLCipherSuite EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH
SSLProtocol All -SSLv2 -SSLv3 -TLSv1 -TLSv1.1
SSLHonorCipherOrder On
Header always set X-Frame-Options DENY
Header always set X-Content-Type-Options nosniff
SSLCompression off
SSLUseStapling on
SSLStaplingCache "shmcb:logs/stapling-cache(150000)"
SSLSessionTickets Off
```
Вносим изменения в файл ssl-сайта по-умолчанию.
```commandline
root@vagrant:/home/vagrant# cp /etc/apache2/sites-available/default-ssl.conf /etc/apache2/sites-available/default-ssl.conf.bak
root@vagrant:/home/vagrant# nano /etc/apache2/sites-available/default-ssl.conf
```
```commandline
root@vagrant:/home/vagrant# cat < /etc/apache2/sites-available/default-ssl.conf
<IfModule mod_ssl.c>
        <VirtualHost _default_:443>
                ServerAdmin admin@homelab.com
                ServerName vagrant.homelab.com

                DocumentRoot /var/www/html

                ErrorLog ${APACHE_LOG_DIR}/error.log
                CustomLog ${APACHE_LOG_DIR}/access.log combined

                SSLEngine on

                SSLCertificateFile      /etc/ssl/certs/apache-selfsigned.crt
                SSLCertificateKeyFile /etc/ssl/private/apache-selfsigned.key

                <FilesMatch "\.(cgi|shtml|phtml|php)$">
                                SSLOptions +StdEnvVars
                </FilesMatch>
                <Directory /usr/lib/cgi-bin>
                                SSLOptions +StdEnvVars
                </Directory>

        </VirtualHost>
</IfModule>
```
Настраиваем переадресацию при обращение на 80-порт к WEB-серверу.  
Добавляем строчку ```Redirect "/" "https://vagrant.homelab.com/"``` в файл в тег <VirtualHost *:80>
```commandline
root@vagrant:/home/vagrant# nano /etc/apache2/sites-available/000-default.conf
```
```commandline
root@vagrant:/home/vagrant# a2enmod ssl
root@vagrant:/home/vagrant# a2enmod headers
root@vagrant:/home/vagrant# a2ensite default-ssl
root@vagrant:/home/vagrant# a2enconf ssl-params
root@vagrant:/home/vagrant# apache2ctl configtest
AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 127.0.1.1. Set the 'ServerName' directive globally to suppress this message
Syntax OK
root@vagrant:/home/vagrant# systemctl restart apache2
```
На хостовой машине прописываем IP-адрес сервера Vagrant в файл /etc/hosts. Необходимо для корректного доступа по имени на apache2.
Заходим через WEB-браузер и проверяем результат.<br>
![HTTPS!](/14_Lesson_sec_1/images/httpscert.png)<br>
4. Проверил сайт созданный пункте 3 на уязвимости.
```commandline
./testssl.sh -U --sneaky https://vagrant.homelab.com/                                                                                             bash   100  16:15:43 

###########################################################
    testssl.sh       3.1dev from https://testssl.sh/dev/
    (35ddd91 2021-12-21 10:54:58 -- )

      This program is free software. Distribution and
             modification under GPLv2 permitted.
      USAGE w/o ANY WARRANTY. USE IT AT YOUR OWN RISK!

       Please file bugs @ https://testssl.sh/bugs/

###########################################################

 Using "OpenSSL 1.0.2-chacha (1.0.2k-dev)" [~183 ciphers]
 on 01nbk0518:./bin/openssl.Linux.x86_64
 (built: "Jan 18 17:12:17 2019", platform: "linux-x86_64")


 Start 2021-12-24 16:16:12        -->> 10.1.5.28:443 (vagrant.homelab.com) <<--

 A record via:           /etc/hosts 
 rDNS (10.1.5.28):       vagrant.homelab.com.
 Service detected:       HTTP


 Testing vulnerabilities 

 Heartbleed (CVE-2014-0160)                not vulnerable (OK), no heartbeat extension
 CCS (CVE-2014-0224)                       not vulnerable (OK)
 Ticketbleed (CVE-2016-9244), experiment.  not vulnerable (OK), no session ticket extension
 ROBOT                                     Server does not support any cipher suites that use RSA key transport
 Secure Renegotiation (RFC 5746)           supported (OK)
 Secure Client-Initiated Renegotiation     not vulnerable (OK)
 CRIME, TLS (CVE-2012-4929)                not vulnerable (OK)
 BREACH (CVE-2013-3587)                    potentially NOT ok, "gzip" HTTP compression detected. - only supplied "/" tested
                                           Can be ignored for static pages or if no secrets in the page
 POODLE, SSL (CVE-2014-3566)               not vulnerable (OK)
 TLS_FALLBACK_SCSV (RFC 7507)              No fallback possible (OK), no protocol below TLS 1.2 offered
 SWEET32 (CVE-2016-2183, CVE-2016-6329)    not vulnerable (OK)
 FREAK (CVE-2015-0204)                     not vulnerable (OK)
 DROWN (CVE-2016-0800, CVE-2016-0703)      not vulnerable on this host and port (OK)
                                           make sure you don't use this certificate elsewhere with SSLv2 enabled services
                                           https://censys.io/ipv4?q=C8B285C30A86510FE9F8B919E35AADE86450A47343D8268632667AFD315AADDD could help you to find out
 LOGJAM (CVE-2015-4000), experimental      common prime with 2048 bits detected: RFC3526/Oakley Group 14 (2048 bits),
                                           but no DH EXPORT ciphers
 BEAST (CVE-2011-3389)                     not vulnerable (OK), no SSL3 or TLS1
 LUCKY13 (CVE-2013-0169), experimental     potentially VULNERABLE, uses cipher block chaining (CBC) ciphers with TLS. Check patches
 Winshock (CVE-2014-6321), experimental    not vulnerable (OK)
 RC4 (CVE-2013-2566, CVE-2015-2808)        no RC4 ciphers detected (OK)


 Done 2021-12-24 16:16:26 [  17s] -->> 10.1.5.28:443 (vagrant.homelab.com) <<--
```
5. Установите на Ubuntu ssh сервер, сгенерируйте новый приватный ключ. Скопируйте свой публичный ключ на другой сервер. Подключитесь к серверу по SSH-ключу.
Установка ssh-сервиса.
```commandline
apt install openssh-server - установка
systemctl start sshd.service - запуск
systemctl enable sshd.service - автозапуск службы
```
Генерируем ключ
```commandline
ssh-keygen -t rsa -b 4096
```
Проверяем что ключ есть
```commandline
root@01nbk0518:/home/yolo# cat .ssh/id_rsa.pub 
ssh-rsa *wXsOK+ktlntWWf/7+o5tL7V+MS8biFQECkF9ClDbTFltcd4TpsoexnWtT391oV7VzrPi2nKFAhg2wtgEVTIOzdw8E+kbUgrcVXUCtKgHvXY3vtydMTez7/NnRIdGKs2KHzezbNOJn8v/7BfEpO3CnVWbSYGZp+iVYwT2*lgTszfTdH4BQsX57PzdVq2AVY26uNMz5vi10T2yrtjJtcfQX/EcsE2T+2zxzhEtgpnuFO3c6Oqpxf9U4/pCI6raHc9CWsaNuNR3oH9DTi69vgF4Vw5P9svbBGEaB9kMrK4h6pTTa84MIJsEIXQkB6wjORxF2bn9YJfEa/VfFerSfOUkCj8swMaLC5sRmWjVnE9BySv+UQeMPusQcXqb2mWAvJo59rnDLjJqbE9WZQ6C0nFqq5Q4Yj3GGISlYQYs/Jeh3IkkdlhULN3CsJP3iec= yolo@DESKTOP-T6N5N7U
```
Часть ключа заменил *звездочками*...
Копируем ключ на сервер, к которому планируем подключаться.
```commandline
ssh-copy-id -i .ssh/id_rsa vagrant@vagrant.homelab.com                                                                                                                          bash   100  16:48:00 
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: ".ssh/id_rsa.pub"
The authenticity of host 'vagrant.homelab.com (10.1.5.28)' can't be established.
ECDSA key fingerprint is SHA256:RztZ38lZsUpiN3mQrXHa6qtsUgsttBXWJibL2nAiwdQ.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
vagrant@vagrant.homelab.com's password: 

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'vagrant@vagrant.homelab.com'"
and check to make sure that only the key(s) you wanted were added.```
```
Проверяем
```commandline
ssh vagrant@vagrant.homelab.com                                                                                                                                                      bash   100  16:
Welcome to Ubuntu 20.04.3 LTS (GNU/Linux 5.4.0-91-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Fri 24 Dec 2021 12:48:54 PM UTC

  System load:  0.0                Processes:             120
  Usage of /:   11.9% of 30.88GB   Users logged in:       1
  Memory usage: 19%                IPv4 address for eth0: 10.1.5.28
  Swap usage:   0%


This system is built by the Bento project by Chef Software
More information can be found at https://github.com/chef/bento
Last login: Fri Dec 24 12:07:17 2021 from 10.1.5.14
```
6. Переименуйте файлы ключей из задания 5. Настройте файл конфигурации SSH клиента, так чтобы вход на удаленный сервер осуществлялся по имени сервера.
Создаем файл конфигурацию клиента ssh. И тестируем подключение.
```commandline
cat < ~/.ssh/config
Host vagrant.homelab.com
    HostName vagrant.homelab.com
    User vagrant
    Port 22
ssh vagrant.homelab.com                                                                                                                                                         bash   100  16:57:57 
Welcome to Ubuntu 20.04.3 LTS (GNU/Linux 5.4.0-91-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Fri 24 Dec 2021 12:58:01 PM UTC

  System load:  0.0                Processes:             120
  Usage of /:   11.9% of 30.88GB   Users logged in:       1
  Memory usage: 19%                IPv4 address for eth0: 10.1.5.28
  Swap usage:   0%


This system is built by the Bento project by Chef Software
More information can be found at https://github.com/chef/bento
Last login: Fri Dec 24 12:57:39 2021 from 10.1.5.14
```
Переименовал ключи из задания 5. SSH начал запрашивать пароль.
```commandline
ssh vagrant.homelab.com                                                                                                                                                     bash   100  17:00:12 
vagrant@vagrant.homelab.com's password: 
Welcome to Ubuntu 20.04.3 LTS (GNU/Linux 5.4.0-91-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Fri 24 Dec 2021 01:00:24 PM UTC

  System load:  0.0                Processes:             121
  Usage of /:   11.9% of 30.88GB   Users logged in:       1
  Memory usage: 20%                IPv4 address for eth0: 10.1.5.28
  Swap usage:   0%


This system is built by the Bento project by Chef Software
More information can be found at https://github.com/chef/bento
Last login: Fri Dec 24 12:58:01 2021 from 10.1.5.14
```
7. Соберите дамп трафика утилитой tcpdump в формате pcap, 100 пакетов. Откройте файл pcap в Wireshark.
Собираем дамп трафика из 100 пакетов.
```commandline
root@vagrant:/home/vagrant# tcpdump -c 100 -w GDZ.pcap -Z root
tcpdump: listening on eth0, link-type EN10MB (Ethernet), capture size 262144 bytes
100 packets captured
103 packets received by filter
0 packets dropped by kernel
```
Качаем дам трафика на локьную машину для открытия в Wireshark
```commandline
root@vagrant:/home/vagrant# scp GDZ.pcap yolo@10.1.5.14:/home/yolo/
```
Открываем в Wireshark
```commandline
wireshark GDZ.pcap
```
<br>![WS!](/14_Lesson_sec_1/images/wireshark.png)
