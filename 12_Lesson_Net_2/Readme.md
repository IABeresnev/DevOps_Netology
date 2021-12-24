###Домашнее задание к занятию "3.7. Компьютерные сети, лекция 2

1. Команды linux networkctl list; iconfig; ip addr show; Windows ipconfig; netsh interface ipv4; Get-NetAdapter
```commandline
networkctl list                                                                                      bash   100  16:05:39 
WARNING: systemd-networkd is not running, output will be incomplete.

IDX LINK TYPE     OPERATIONAL SETUP    
  1 lo   loopback n/a         unmanaged
  2 eno1 ether    n/a         unmanaged
  3 wlo1 wlan     n/a         unmanaged

3 links listed.
ifconfig
eno1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.1.5.14  netmask 255.255.255.0  broadcast 10.1.5.255
        inet6 fe80::7893:b7ea:8d3a:d7cc  prefixlen 64  scopeid 0x20<link>
        ether f0:92:1c:53:73:91  txqueuelen 1000  (Ethernet)
        RX packets 2983182  bytes 3722918873 (3.7 GB)
        RX errors 0  dropped 522  overruns 0  frame 0
        TX packets 924256  bytes 120343797 (120.3 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 15122  bytes 1642334 (1.6 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 15122  bytes 1642334 (1.6 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

wlo1: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        ether 68:17:29:95:1c:a3  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

ip addr show                                                                                        bash   100  16:07:08 
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: eno1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether f0:92:1c:53:73:91 brd ff:ff:ff:ff:ff:ff
    altname enp14s0
    inet 10.1.5.14/24 brd 10.1.5.255 scope global dynamic noprefixroute eno1
       valid_lft 400674sec preferred_lft 400674sec
    inet6 fe80::7893:b7ea:8d3a:d7cc/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever
3: wlo1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN group default qlen 1000
    link/ether 68:17:29:95:1c:a3 brd ff:ff:ff:ff:ff:ff
    altname wlp7s0
``` 
2. Протокол называет LLDP - Link Layer Discovery Protocol  протокол канального уровня, который позволяет сетевым устройствам анонсировать в сеть информацию о себе и о своих возможностях, а также собирать эту информацию о соседних устройствах. Из интернета. Или есть проприетарный цисковой протокол CDP - Cisco Discovery Protocol.
В Linux есть два пакета LLDPAD - демон. LLDPD - клиент-демон для обработки ответов. Пример ответа с локального ноута.
```commandline
root@01nbk0518:/home/yolo# lldpctl
-------------------------------------------------------------------------------
LLDP neighbors:
-------------------------------------------------------------------------------
Interface:    eno1, via: LLDP, RID: 1, Time: 0 day, 00:00:57
  Chassis:     
    ChassisID:    mac 00:1c:b0:49:c8:08
    SysName:      cabinetIT4.7.cisco.com
    SysDescr:     Cisco IOS Software, C2960 Software (C2960-LANBASE-M), Version 12.2(40)SE, RELEASE SOFTWARE (fc3)
                  Copyright (c) 1986-2007 by Cisco Systems, Inc.
                  Compiled Thu 23-Aug-07 20:45 by myl
    Capability:   Bridge, off
    Capability:   Router, off
  Port:        
    PortID:       local Fa0/8
    PortDescr:    FastEthernet0/8
    TTL:          120
    PMD autoneg:  supported: yes, enabled: yes
      Adv:          1000Base-X, HD: no, FD: yes
      Adv:          1000Base-T, HD: yes, FD: no
      MAU oper type: 100BaseTXFD - 2 pair category 5 UTP, full duplex mode
  VLAN:         12, pvid: yes
-------------------------------------------------------------------------------
Interface:    eno1, via: LLDP, RID: 2, Time: 0 day, 00:00:37
  Chassis:     
    ChassisID:    mac 00:26:8b:04:23:64
    SysName:      US102N/DS102N
    SysDescr:     V4.3.0.0-10309
    MgmtIP:       10.1.5.25
    Capability:   Tel, on
  Port:        
    PortID:       ifname eth0
    PortDescr:    eth0
    TTL:          240
  LLDP-MED:    
    Device Type:  Communication Device Endpoint (Class III)
    Capability:   Capabilities, yes
    Capability:   Policy, yes
    Capability:   MDI/PD, yes
    Capability:   Inventory, yes
    LLDP-MED Network Policy for: Voice, Defined: no
      Priority:     Best effort
      PCP:          0
      DSCP Value:   0
-------------------------------------------------------------------------------
```
3. Предположу что в вопросе подразумевается ответ VLAN.
VLAN (Virtual Local Area Network) — группа устройств, имеющих возможность взаимодействовать между собой напрямую на канальном уровне, хотя физически при этом они могут быть подключены к разным сетевым коммутаторам. И наоборот, устройства, находящиеся в разных VLAN'ах, невидимы друг для друга на канальном уровне, даже если они подключены к одному коммутатору, и связь между этими устройствами возможна только на сетевом и более высоких уровнях.
В Linux Debian-like обычно использовал вот такую конфигурацию: 14 - номер VLAN, 0 - номер физического интерфейса.
```commandline
auto eth0.14
iface eth0.14 inet static
        address 192.168.1.1
        netmask 255.255.255.0
        vlan_raw_device eth0
```
В Linux должен быть подключен модуль ядра.
```commandline
lsmod | grep 8021q
8021q                  32768  0
garp                   16384  1 8021q
mrp                    20480  1 8021q
```
Дополнительно можно установить пакет vlan `apt install vlan` тогда появиться функционал `vconfig`  
`vconfig add eth0 14` создать на 0 интерфейсе саб-интерфейс с 14 Vlan.
4. Объединение сетевых интерфейсов(Bonding) – это механизм, используемый Linux-серверами и предполагающий связь нескольких физических интерфейсов в один виртуальный, что позволяет обеспечить большую пропускную способность или отказоустойчивость в случае повреждения кабеля.  
####Режимы работы
<strong>mode=0 (balance-rr)</strong>  
При этом методе объединения трафик распределяется по принципу «карусели»: пакеты по очереди направляются на сетевые карты объединённого интерфейса. Например, если у нас есть физические интерфейсы eth0, eth1, and eth2, объединенные в bond0, первый пакет будет отправляться через eth0, второй — через eth1, третий — через eth2, а четвертый снова через eth0 и т.д.  
<strong>mode=1 (active-backup)</strong>  
Когда используется этот метод, активен только один физический интерфейс, а остальные работают как резервные на случай отказа основного.  
<strong>mode=2 (balance-xor)</strong>  
В данном случае объединенный интерфейс определяет, через какую физическую сетевую карту отправить пакеты, в зависимости от MAC-адресов источника и получателя.  
<strong>mode=3 (broadcast)</strong>  
Широковещательный режим, все пакеты отправляются через каждый интерфейс. Имеет ограниченное применение, но обеспечивает значительную отказоустойчивость.  
<strong>mode=4 (802.3ad)</strong>  
Особый режим объединения. Для него требуется специально настраивать коммутатор, к которому подключен объединенный интерфейс. Реализует стандарты объединения каналов IEEE и обеспечивает как увеличение пропускной способности, так и отказоустойчивость.  
<strong>mode=5 (balance-tlb)</strong>  
Распределение нагрузки при передаче. Входящий трафик обрабатывается в обычном режиме, а при передаче интерфейс определяется на основе данных о загруженности.  
<strong>mode=6 (balance-alb)</strong>  
Адаптивное распределение нагрузки. Аналогично предыдущему режиму, но с возможностью балансировать также входящую нагрузку.  
Пример конфигурации:  
```commandline
sudo nano /etc/network/interfaces
# The primary network interface
auto bond0
iface bond0 inet static
    address 192.168.1.150
    netmask 255.255.255.0    
    gateway 192.168.1.1
    dns-nameservers 192.168.1.1 8.8.8.8
    dns-search domain.local
        slaves eth0 eth1
        bond_mode 0
        bond-miimon 100
        bond_downdelay 200
        bound_updelay 200
```
И через netplan в версиях ubuntu старше 17.10
```commandline
network: 
    renderer: networkd 
    version: 2 
    ethernets: 
        eth0:
          dhcp4: no
        eth1:
          dhcp4: no
    bonds: 
      bond0:
        dhcp4: no
        interfaces: [eth0, eth1]
        parameters:
          mode: 802.3ad
          mii-monitor-interval: 1
```
5. Сколько IP адресов в сети с маской /29?  8 Адресов, но максимальное возможное количество хостов 6.
Сколько /29 подсетей можно получить из сети с маской /24. 32 сети. 
Приведите несколько примеров /29 подсетей внутри сети 10.10.10.0/24.
```commandline
Сеть:    	10.10.10.0/29   
Хост(min):	10.10.10.1	    
Хост(max):	10.10.10.6	    
Broadcast:	10.10.10.7	    
2.
Сеть:       10.10.10.8/29   
Хост(min):	10.10.10.9	    
Хост(max):	10.10.10.14	   
Broadcast:	10.10.10.15	
3.
Сеть:    	10.10.10.16/29 
Хост(min):	10.10.10.17	
Хост(max):	10.10.10.22
Broadcast:	10.10.10.23
...
32.
Сеть:    	10.10.10.248/29
Хост(min):	10.10.10.249	
Хост(max):	10.10.10.254
Broadcast:	10.10.10.255
```
6. Очень интересный вопрос, с подобным сталкиваться не приходилось. Но гугл по запросу Bogon Networks, предлагает список сетей и RFC с ним.
Ознакомился и могу предложить использоваться несколько вариантов. Информацию и описание взял с сайта https://www.securitylab.ru/blog/personal/aodugin/305208.php
```commandline
192.0.2.0/24
198.51.100.0/24
203.0.113.0/24
Эти три подсети, в соответствии с RFC5737 , зарезервированы для описания в документах. 
Многие, думаю, сталкивались с ситуацией, когда для статьи в журнале либо презентации на конференции нужно показать некоторое адресное пространство, 
которое, с одной стороны, не должно ассоциироваться с локальными RFC1918-адресами и как бы показывать Интернет, 
но, в то же время, и не принадлежать никому, чтобы не было лишних вопросов со стороны владельца адресов.
198.18.0.0/15
Диапазон выделен под лаборатории нагрузочного тестирования (Benchmarking) в соответствии с RFC2544 и уточнением в RFC6815,
что данный диапазон не должен быть досутпен в Интернет во избежание конфликтов.
```
Для организации сети на 40-50 хостов можно взять 26 маску, для хостов будет доступно 62 адреса.  
Верный ответ:  
100.64.0.0/10
В соответствии с RFC6598, используется как транслируемый блок адресов для межпровайдерских взаимодействий и Carrier Grade NAT. Особенно полезен как общее свободное адресное IPv4-пространство RFC1918, необходимое для интеграции ресурсов провайдеров, а также для выделения немаршрутизируемых адресов абонентам. Конечно, в последнем случае никто не мешает использовать RFC1918 - на откуп сетевым архитекторам.
7. ARP таблица в Linux ```apr -a``` Удалить конкретный адрес Linux ```arp -d @address@```
Для очистки всех записей в ARP таблице в Linux предлагается либо написать скрипт на основе цикла перебора IP-адресов и подставноки их в команду по удалению 1 адреса.
Либо использовать перезагрузку опции использования ARP на интерфейсе. Пример:  
```ip link set arp off dev eth0; ip link set arp on dev eth0```
