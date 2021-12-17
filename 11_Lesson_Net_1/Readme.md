###Домашнее задание к занятию "3.6. Компьютерные сети, лекция 1"

1. В ответ на выполнение запросов получил ответ.
`HTTP/1.1 301 Moved Permanently` - запращиваемый ресур был перенесен на постоянной основе в новое месторасположение.
Куда перенесен ресурс указано в поле ответа `location: https://stackoverflow.com/questions`
2. Первый ответ от сайта сразу stackoverflow.com c кодом 200.
Дольше всего грузилась именно эта часть 346ms.<br>
![net!](/11_Lesson_Net_1/images/net1.png)<br>
3. Для определения внешнего IP-адреса можно выполнить команду из bash.
```commandline
wget -O - -q icanhazip.com.                                                                     bash   100  16:31:10 
194.8.230.58
```
194.8.230.58 - Внешний IP-адрес.
4. Провайдер
```commandline
whois 194.8.230.58 | grep org-name                                                            bash   100  16:50:02 
org-name:       Southern Shipbuilding and ship repair center JSC
```
Номер AS
```commandline
hois 194.8.230.58 | grep origin
origin:         AS50863
```
5. Список сетей при прохождение пакета до 8.8.8.8
```commandline
traceroute 8.8.8.8                                                                            bash   100  16:53:06 
traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets
 1  (внутренняя сеть компании)  0.530 ms  1.044 ms  1.283 ms
 2  (внутренняя сеть компании)  0.455 ms  0.518 ms  0.564 ms
 3  (внутренняя сеть компании)  2.532 ms  2.650 ms  2.804 ms
 4  (внутренняя сеть компании)  2.225 ms  2.342 ms  2.368 ms
 5  (внутренняя сеть компании)  2.032 ms  2.040 ms  2.078 ms
 6  (внутренняя сеть компании)  2.640 ms  2.841 ms  2.796 ms
 7  l2tp.cnrg.ru (194.8.230.1)  2.985 ms  3.573 ms  3.521 ms
 8  178.35.229.49 (178.35.229.49)  3.995 ms  4.073 ms  4.048 ms
 9  87.226.183.89 (87.226.183.89)  32.468 ms  32.746 ms  32.632 ms
10  74.125.52.232 (74.125.52.232)  32.195 ms 74.125.51.172 (74.125.51.172)  32.698 ms  32.676 ms
11  * 108.170.250.66 (108.170.250.66)  32.435 ms 108.170.250.83 (108.170.250.83)  33.633 ms
12  209.85.255.136 (209.85.255.136)  47.718 ms 209.85.249.158 (209.85.249.158)  46.839 ms *
13  74.125.253.94 (74.125.253.94)  47.381 ms 172.253.66.108 (172.253.66.108)  47.361 ms 216.239.43.20 (216.239.43.20)  67.034 ms
14  216.239.49.115 (216.239.49.115)  46.346 ms 172.253.51.239 (172.253.51.239)  48.058 ms 172.253.51.237 (172.253.51.237)  52.633 ms
15  * * *
16  * * *
17  * * *
18  * * *
19  * * *
20  * * *
21  * * *
22  * * *
23  * * *
24  dns.google (8.8.8.8)  45.752 ms  45.683 ms  48.072 ms
```
Номера AS выводим через ключ -A
```commandline
traceroute 8.8.8.8 -A                                                                            bash   100  16:57:17 
traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets
 1  (внутренняя сеть компании) [*]  0.498 ms  0.996 ms  1.266 ms
 2  (внутренняя сеть компании) [*]  0.389 ms  0.440 ms  0.487 ms
 3  (внутренняя сеть компании) [*]  2.361 ms  2.529 ms  2.571 ms
 4  (внутренняя сеть компании) [*]  2.382 ms  2.519 ms  2.545 ms
 5  (внутренняя сеть компании) [*]  2.273 ms  2.259 ms  2.285 ms
 6  (внутренняя сеть компании) [*]  2.654 ms  2.707 ms  2.568 ms
 7  l2tp.cnrg.ru (194.8.230.1) [AS50863]  6.716 ms  8.043 ms  9.082 ms
 8  178.35.229.49 (178.35.229.49) [AS12389]  9.626 ms  9.558 ms  9.503 ms
 9  87.226.183.89 (87.226.183.89) [AS12389]  33.990 ms  33.854 ms  34.948 ms
10  74.125.52.232 (74.125.52.232) [AS15169]  34.574 ms 74.125.51.172 (74.125.51.172) [AS15169]  36.386 ms 5.143.253.105 (5.143.253.105) [AS12389]  37.782 ms
11  108.170.250.66 (108.170.250.66) [AS15169]  34.661 ms 108.170.250.34 (108.170.250.34) [AS15169]  35.523 ms 108.170.250.66 (108.170.250.66) [AS15169]  35.327 ms
12  216.239.51.32 (216.239.51.32) [AS15169]  66.150 ms 142.251.49.158 (142.251.49.158) [AS15169]  50.534 ms *
13  216.239.43.20 (216.239.43.20) [AS15169]  49.193 ms 216.239.57.222 (216.239.57.222) [AS15169]  47.435 ms 172.253.65.159 (172.253.65.159) [AS15169]  50.058 ms
14  142.250.56.127 (142.250.56.127) [AS15169]  47.004 ms 216.239.54.201 (216.239.54.201) [AS15169]  50.427 ms 142.250.56.125 (142.250.56.125) [AS15169]  49.122 ms
15  * * *
16  * * *
17  * * *
18  * * *
19  * * *
20  * * *
21  * * *
22  * * *
23  * * *
24  dns.google (8.8.8.8) [AS15169]  46.358 ms  44.850 ms *
```
6. Продолжил из дома. Самая большая задержка была тут.<br>
![net!](/11_Lesson_Net_1/images/net2.png)<br>

7. Держателями доменной зоны dns.google являются следующие сервера имен.
```commandline
dig -t NS dns.google

; <<>> DiG 9.16.1-Ubuntu <<>> -t NS dns.google
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 63552
;; flags: qr rd ra; QUERY: 1, ANSWER: 4, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;dns.google.                    IN      NS

;; ANSWER SECTION:
dns.google.             6322    IN      NS      ns1.zdns.google.
dns.google.             6322    IN      NS      ns3.zdns.google.
dns.google.             6322    IN      NS      ns4.zdns.google.
dns.google.             6322    IN      NS      ns2.zdns.google.

;; Query time: 76 msec
;; SERVER: 127.0.0.53#53(127.0.0.53)
;; WHEN: Пт дек 17 22:00:49 +04 2021
;; MSG SIZE  rcvd: 116
```
ns1-ns4.zdns.google
A записи для домене dns.google
```commandline
dig -t A dns.google                                                                               bash   100  22:00:49 

; <<>> DiG 9.16.1-Ubuntu <<>> -t A dns.google
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 41525
;; flags: qr rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 0, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 65494
;; QUESTION SECTION:
;dns.google.                    IN      A

;; ANSWER SECTION:
dns.google.             865     IN      A       8.8.8.8
dns.google.             865     IN      A       8.8.4.4

;; Query time: 40 msec
;; SERVER: 127.0.0.53#53(127.0.0.53)
;; WHEN: Пт дек 17 22:04:14 +04 2021
;; MSG SIZE  rcvd: 71
```
8. PTR
Для интереса сделал сначала
```commandline
ig ns1.zdns.google | grep IN
;ns1.zdns.google.               IN      A
ns1.zdns.google.        7002    IN      A       216.239.32.114
```
и теперь просим показать PTR
```commandline
dig -x 216.239.32.114 | grep IN                                                                       bash   100  22:25:20 
;114.32.239.216.in-addr.arpa.   IN      PTR
114.32.239.216.in-addr.arpa. 7081 IN    PTR     ns1.zdns.google.
```

