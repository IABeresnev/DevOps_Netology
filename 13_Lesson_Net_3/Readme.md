### Домашнее задание к занятию "3.8. Компьютерные сети, лекция 3
1. Подключитесь к публичному маршрутизатору в интернет. Найдите маршрут к вашему публичному IP
```commandline
show ip route 194.8.230.1/32
```
Ругается на ошибку синтаксиса, при написании без указания маски отработало корректно.
```commandline
route-views>show ip route 194.8.230.1   
Routing entry for 194.8.230.0/24
  Known via "bgp 6447", distance 20, metric 0
  Tag 3303, type external
  Last update from 217.192.89.50 6d21h ago
  Routing Descriptor Blocks:
  * 217.192.89.50, from 217.192.89.50, 6d21h ago
      Route metric is 0, traffic share count is 1
      AS Hops 3
      Route tag 3303
      MPLS label: none
```
Команда show bgp 194.8.230.0/24 
```commandline
show bgp 194.8.230.0/24
BGP routing table entry for 194.8.230.0/24, version 1571577452
Paths: (22 available, best #14, table default)
  Not advertised to any peer
  Refresh Epoch 1
  1351 6939 31133 50863
    132.198.255.253 from 132.198.255.253 (132.198.255.253)
      Origin IGP, localpref 100, valid, external
      path 7FE01BE57860 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  6939 31133 50863
    64.71.137.241 from 64.71.137.241 (216.218.252.164)
      Origin IGP, localpref 100, valid, external
      path 7FE10444ED58 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  20912 3257 174 31133 50863
    212.66.96.126 from 212.66.96.126 (212.66.96.126)
      Origin IGP, localpref 100, valid, external
      Community: 3257:8070 3257:30155 3257:50001 3257:53900 3257:53902 20912:65004
      path 7FE10CA94F30 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3333 31133 50863
    193.0.0.56 from 193.0.0.56 (193.0.0.56)
      Origin IGP, localpref 100, valid, external
      path 7FE04946A2C0 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 2
  8283 31133 50863
    94.142.247.3 from 94.142.247.3 (94.142.247.3)
      Origin IGP, metric 0, localpref 100, valid, external
      Community: 8283:1 8283:101
      unknown transitive attribute: flag 0xE0 type 0x20 length 0x18
        value 0000 205B 0000 0000 0000 0001 0000 205B
              0000 0005 0000 0001 
      path 7FE0EB273348 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3356 12389 50863
    4.68.4.46 from 4.68.4.46 (4.69.184.201)
      Origin IGP, metric 0, localpref 100, valid, external
      Community: 3356:2 3356:22 3356:100 3356:123 3356:501 3356:903 3356:2065
      path 7FE02028EC40 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  101 11164 2603 31133 50863
    209.124.176.223 from 209.124.176.223 (209.124.176.223)
      Origin IGP, localpref 100, valid, external
      Community: 0:714 0:2854 0:3216 0:5580 0:6461 0:6939 0:8075 0:8359 0:9002 0:12389 0:12876 0:12989 0:13335 0:15169 0:16265 0:16276 0:16302 0:16509 0:16625 0:20485 0:20764 0:20940 0:21859 0:22697 0:24940 0:32338 0:32590 0:33438 0:33891 0:39832 0:42668 0:46489 0:47541 0:47542 0:49544 0:49981 0:56550 0:56630 0:57976 0:60280 101:20100 101:22100 2603:302 2603:666 2603:65100 11164:1170 11164:7880
      Extended Community: RT:101:22100
      path 7FE03D5201F8 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  852 3356 12389 50863
    154.11.12.212 from 154.11.12.212 (96.1.209.43)
      Origin IGP, metric 0, localpref 100, valid, external
      path 7FE140318C30 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3549 3356 12389 50863
    208.51.134.254 from 208.51.134.254 (67.16.168.191)
      Origin IGP, metric 0, localpref 100, valid, external
      Community: 3356:2 3356:22 3356:100 3356:123 3356:501 3356:903 3356:2065 3549:2581 3549:30840
      path 7FE0BE7C1818 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  53767 174 31133 50863
    162.251.163.2 from 162.251.163.2 (162.251.162.3)
      Origin IGP, localpref 100, valid, external
      Community: 174:21101 174:22028 53767:5000
      path 7FE022A751D8 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  20130 6939 31133 50863
    140.192.8.16 from 140.192.8.16 (140.192.8.16)
      Origin IGP, localpref 100, valid, external
      path 7FE1637D69F0 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  57866 3356 12389 50863
    37.139.139.17 from 37.139.139.17 (37.139.139.17)
      Origin IGP, metric 0, localpref 100, valid, external
      Community: 3356:2 3356:22 3356:100 3356:123 3356:501 3356:903 3356:2065
      path 7FE10CA93CB0 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  2497 12389 50863
    202.232.0.2 from 202.232.0.2 (58.138.96.254)
      Origin IGP, localpref 100, valid, external
      path 7FE17C27E4A8 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 3
  3303 31133 50863
    217.192.89.50 from 217.192.89.50 (138.187.128.158)
      Origin IGP, localpref 100, valid, external, best
      Community: 3303:1004 3303:1006 3303:1030 3303:3056
      path 7FE0EECDE7D8 RPKI State not found
      rx pathid: 0, tx pathid: 0x0
  Refresh Epoch 1
  4901 6079 1299 31133 50863
    162.250.137.254 from 162.250.137.254 (162.250.137.254)
      Origin IGP, localpref 100, valid, external
      Community: 65000:10100 65000:10300 65000:10400
      path 7FE129D80DE8 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  7660 2516 12389 50863
    203.181.248.168 from 203.181.248.168 (203.181.248.168)
      Origin IGP, localpref 100, valid, external
      Community: 2516:1050 7660:9003
      path 7FE0A4D9C800 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  7018 1299 31133 50863
    12.0.1.63 from 12.0.1.63 (12.0.1.63)
      Origin IGP, localpref 100, valid, external
      Community: 7018:5000 7018:37232
      path 7FE0B2C1CEA8 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  49788 12552 31133 50863
    91.218.184.60 from 91.218.184.60 (91.218.184.60)
      Origin IGP, localpref 100, valid, external
      Community: 12552:12000 12552:12100 12552:12101 12552:22000
      Extended Community: 0x43:100:1
      path 7FE125F93348 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  1221 4637 12389 50863
    203.62.252.83 from 203.62.252.83 (203.62.252.83)
      Origin IGP, localpref 100, valid, external
      path 7FE139F7DF48 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  701 1273 12389 50863
    137.39.3.55 from 137.39.3.55 (137.39.3.55)
      Origin IGP, localpref 100, valid, external
      path 7FE12E331108 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3561 3910 3356 12389 50863
    206.24.210.80 from 206.24.210.80 (206.24.210.80)
      Origin IGP, localpref 100, valid, external
      path 7FE0D1E93FB0 RPKI State not found
      rx pathid: 0, tx pathid: 0
  Refresh Epoch 1
  3257 1299 31133 50863
    89.149.178.10 from 89.149.178.10 (213.200.83.26)
      Origin IGP, metric 10, localpref 100, valid, external
      Community: 3257:8794 3257:30052 3257:50001 3257:54900 3257:54901
      path 7FE14B375DC8 RPKI State not found
      rx pathid: 0, tx pathid: 0
```
2. Создайте dummy0 интерфейс в Ubuntu. Добавьте несколько статических маршрутов. Проверьте таблицу маршрутизации.
Создание интерфейса.
```commandline
vagrant@vagrant:~$ sudo su
root@vagrant:/home/vagrant# ip link add dummy0 type dummy
root@vagrant:/home/vagrant# ip adr show
Object "adr" is unknown, try "ip help".
root@vagrant:/home/vagrant# ip addr show
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:b1:28:5d brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 brd 10.0.2.255 scope global dynamic eth0
       valid_lft 83828sec preferred_lft 83828sec
    inet6 fe80::a00:27ff:feb1:285d/64 scope link 
       valid_lft forever preferred_lft forever
3: dummy0: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether 6e:06:e9:5c:dc:63 brd ff:ff:ff:ff:ff:ff
root@vagrant:/home/vagrant# ip addr add 10.0.10.15/24 dev dummy0
root@vagrant:/home/vagrant# ip link set dummy0 up
root@vagrant:/home/vagrant# ip route show
default via 10.0.2.2 dev eth0 proto dhcp src 10.0.2.15 metric 100 
10.0.2.0/24 dev eth0 proto kernel scope link src 10.0.2.15 
10.0.2.2 dev eth0 proto dhcp scope link src 10.0.2.15 metric 100 
10.0.10.0/24 dev dummy0 proto kernel scope link src 10.0.10.15
```
Добавляем маршруты.
```commandline
root@vagrant:/home/vagrant# ip route add 172.16.0.0/24 via 10.0.10.1 dev dummy0
root@vagrant:/home/vagrant# ip route show
default via 10.0.2.2 dev eth0 proto dhcp src 10.0.2.15 metric 100 
10.0.2.0/24 dev eth0 proto kernel scope link src 10.0.2.15 
10.0.2.2 dev eth0 proto dhcp scope link src 10.0.2.15 metric 100 
10.0.10.0/24 dev dummy0 proto kernel scope link src 10.0.10.15 
172.16.0.0/24 via 10.0.10.1 dev dummy0 
root@vagrant:/home/vagrant# ip route add 192.168.1.0/24 via 10.0.10.1 dev dummy0
root@vagrant:/home/vagrant# ip route show
default via 10.0.2.2 dev eth0 proto dhcp src 10.0.2.15 metric 100 
10.0.2.0/24 dev eth0 proto kernel scope link src 10.0.2.15 
10.0.2.2 dev eth0 proto dhcp scope link src 10.0.2.15 metric 100 
10.0.10.0/24 dev dummy0 proto kernel scope link src 10.0.10.15 
172.16.0.0/24 via 10.0.10.1 dev dummy0 
192.168.1.0/24 via 10.0.10.1 dev dummy0
```
3. Открытые порты TCP.
```commandline
root@vagrant:/home/vagrant# lsof -i -P -n | grep LISTEN
systemd-r   604 systemd-resolve   13u  IPv4  20912      0t0  TCP 127.0.0.53:53 (LISTEN)
sshd        823            root    3u  IPv4  23348      0t0  TCP *:22 (LISTEN)
sshd        823            root    4u  IPv6  23350      0t0  TCP *:22 (LISTEN)
root@vagrant:/home/vagrant# netstat -tulpn | grep LISTEN
tcp        0      0 127.0.0.53:53           0.0.0.0:*               LISTEN      604/systemd-resolve 
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      823/sshd: /usr/sbin 
tcp6       0      0 :::22                   :::*                    LISTEN      823/sshd: /usr/sbin 
root@vagrant:/home/vagrant# ss -tulpn | grep LISTEN
tcp     LISTEN   0        4096        127.0.0.53%lo:53            0.0.0.0:*      users:(("systemd-resolve",pid=604,fd=13))                                      
tcp     LISTEN   0        128               0.0.0.0:22            0.0.0.0:*      users:(("sshd",pid=823,fd=3))                                                  
tcp     LISTEN   0        128                  [::]:22               [::]:*      users:(("sshd",pid=823,fd=4))
```
Открытые порты принадлежат сервису SSH(Сетевой протокол прикладного уровня) и DNS(Сетевой протокол прикладного уровня) предназначен для разрешения имен.
4. Открытые UDP порты.
```commandline
root@vagrant:/home/vagrant# ss -uap
State                  Recv-Q                  Send-Q                                    Local Address:Port                                     Peer Address:Port                 Process                                                    
UNCONN                 0                       0                                         127.0.0.53%lo:domain                                        0.0.0.0:*                     users:(("systemd-resolve",pid=604,fd=12))                 
UNCONN                 0                       0                                        10.0.2.15%eth0:bootpc                                        0.0.0.0:*                     users:(("systemd-network",pid=602,fd=19))                 
root@vagrant:/home/vagrant# netstat -uap
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name    
udp        0      0 localhost:domain        0.0.0.0:*                           604/systemd-resolve 
udp        0      0 vagrant:bootpc          0.0.0.0:*                           602/systemd-network
```
Первая строка использует DNS протокол. Вторая строка BOOTP протокол необходим для автоматического назначения IP-адреса.
5. L3 схема сети.  
![l3Network!](/13_Lesson_Net_3/images/l3_netology.png)<br>