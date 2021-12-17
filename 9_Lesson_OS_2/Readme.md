###Домашнее задание к занятию "3.4. Операционные системы, лекция 2"   
1. Все установил, файл в systemd зарегистрировал, остановку, запуск, перезапуск и автозапуск проверил.
Сначала не понял про передачу параметров через файл, подумал что необходимо прям через systemctl start служба --файл_с_параметрами.
Потом увидел что есть параметр EnviromentFile, через который можно предавать параметры.
Содержимое файлов службы и файла с параметрами.
```commandline
root@vagrant:/lib/systemd/system# cat ne.service 
# /lib/systemd/system/ne.service
[Unit]
Description=Node Exporter server
After=network.target

[Service]
EnvironmentFile=/etc/default/ne
ExecStart=/node_exporter-1.3.1.linux-amd64/node_exporter $EXTRA_OPTS
KillMode=mixed
Restart=on-failure

[Install]
WantedBy=multi-user.target
root@vagrant:/lib/systemd/system# cat /etc/default/ne
EXTRA_OPTS="--collector.cpu"
```
Вывод запущенный службы, с демонстрацией параметра.
```commandline
root@vagrant:/lib/systemd/system# systemctl status ne
● ne.service - Node Exporter server
     Loaded: loaded (/lib/systemd/system/ne.service; enabled; vendor preset: enabled)
     Active: active (running) since Thu 2021-12-16 11:31:40 UTC; 22min ago
   Main PID: 639 (node_exporter)
      Tasks: 5 (limit: 1071)
     Memory: 16.9M
     CGroup: /system.slice/ne.service
             └─639 /node_exporter-1.3.1.linux-amd64/node_exporter --collector.cpu

Dec 16 11:31:40 vagrant node_exporter[639]: ts=2021-12-16T11:31:40.324Z caller=node_exporter.go:115 level=info collector=thermal_zone
Dec 16 11:31:40 vagrant node_exporter[639]: ts=2021-12-16T11:31:40.324Z caller=node_exporter.go:115 level=info collector=time
Dec 16 11:31:40 vagrant node_exporter[639]: ts=2021-12-16T11:31:40.325Z caller=node_exporter.go:115 level=info collector=timex
Dec 16 11:31:40 vagrant node_exporter[639]: ts=2021-12-16T11:31:40.325Z caller=node_exporter.go:115 level=info collector=udp_queues

```
2. Бзовые метрики необходимые для мониторинга системы:
CPU - статистика по утилизации мощности ЦП.
DISKSTATS - статистика по производительности дисковой подсистемы
FILESYSTEM - состояние файловой системы и её утилизация по свободному пространству.
MEMINFO - состояние и утилизация оперативной памяти.
NETSTAT - состояние и утилизация сетевой подсистемы.
THERMAL_ZONE - состояние системы охлаждения и показатели температурных датчиков.
3. Установил, порт пробросил, значительно наглядней для человека чем просторой node_exporter.
```commandline
sudo lsof -i :19999                                                                   bash   100  16:39:25 
[sudo] password for yolo: 
COMMAND     PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
chrome     1786 yolo   57u  IPv4 372336      0t0  TCP localhost:36184->localhost:19999 (ESTABLISHED)
chrome     1786 yolo   66u  IPv4 373444      0t0  TCP localhost:36192->localhost:19999 (ESTABLISHED)
chrome     1786 yolo   74u  IPv4 374835      0t0  TCP localhost:36250->localhost:19999 (ESTABLISHED)
chrome     1786 yolo  119u  IPv4 370615      0t0  TCP localhost:36234->localhost:19999 (ESTABLISHED)
chrome     1786 yolo  126u  IPv4 370617      0t0  TCP localhost:36238->localhost:19999 (ESTABLISHED)
VBoxHeadl 26465 yolo   21u  IPv4 370093      0t0  TCP *:19999 (LISTEN)
VBoxHeadl 26465 yolo   24u  IPv4 372718      0t0  TCP localhost:19999->localhost:36250 (ESTABLISHED)
VBoxHeadl 26465 yolo   25u  IPv4 373437      0t0  TCP localhost:19999->localhost:36184 (ESTABLISHED)
VBoxHeadl 26465 yolo   27u  IPv4 371480      0t0  TCP localhost:19999->localhost:36192 (ESTABLISHED)
VBoxHeadl 26465 yolo   28u  IPv4 373535      0t0  TCP localhost:19999->localhost:36234 (ESTABLISHED)
VBoxHeadl 26465 yolo   29u  IPv4 373536      0t0  TCP localhost:19999->localhost:36238 (ESTABLISHED)
```
4. Да можно, если запустить команду sudo /var/log/dmesg | grep virtual
```commandline
root@vagrant:/var/log# dmesg | grep virtual
[    0.003071] CPU MTRRs all blank - virtualized system.
[    0.101152] Booting paravirtualized kernel on KVM
[    2.422197] systemd[1]: Detected virtualization oracle.
```
По второй и третей строке можно понять, что мы находимся на виртуальной машине.
Пример вывода команды с железного ноутбука.
```commandline
root@01nbk0518:/var/log# dmesg | grep virtual
[    0.027356] Booting paravirtualized kernel on bare hardware
[    7.952149] input: HP Wireless hotkeys as /devices/virtual/input/input12
[    8.787928] input: HP WMI hotkeys as /devices/virtual/input/input13
```
В первой строчке указывается, что ядро запущено на чистом железе.
5. `sysctl fs.nr_open` задает системное ограничение на количество открытых файловых дескрипторов, по умолчанию в системе его значению равно 
```commandline
vagrant@vagrant:~$ /sbin/sysctl -n fs.nr_open
1048576
```
В дополнение к нему, а точнее перед ним срабатывают два других ограчения просмотр которых доступен через `ulimit -a` и `ulimit -aH`.
Первая команда показывает "мягкие" ограничения и вторая команда "жесткие". При помощи вызова команды `ulimit` можно увеличить "мягкие"
ограничения до размеров "жесктих". Все внесенные изменния таким образом, сохраняются только на время жизни сессии.
6. Создает процесс в собственном namespace.
```commandline
screen
unshare -f --pid --mount-proc /bin/sleep 1h
```
и проверяем
```commandline
root@vagrant:/# ps -e | grep sleep
   2337 pts/1    00:00:00 sleep
root@vagrant:/# nsenter -t 2337 -p -m
root@vagrant:/# ps aux
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.0  0.0   9828   528 pts/1    S+   12:04   0:00 /bin/sleep 1h
root           2  0.3  0.3  11560  3872 pts/0    S    12:05   0:00 -bash
root          11  0.0  0.3  13216  3444 pts/0    R+   12:05   0:00 ps aux

```
7. Определяет функцию с именем ":". В теле функции она запускает саму себя рекурсивно.
Для того чтобы предотвратить пагубное влияние подобных функций на систему, есть ограничение количествао процессов на пользователя.
`ulimit -u 10` где 10 это максимальное разрешенное количество процессов в системе от этого пользователя.