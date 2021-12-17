## Домашнее задание к занятию "3.2. Работа в терминале, лекция 2"

1) `cd` - это команда встроенная в оболочку BASH. Иной она быть не может так как отвечает за базовый функционал, смену рабочей директории.
Она могла бы быть функцией, но тогда у неё должны были бы быть, еще более низкоуровневые подкоманды.
Или как более удобный alias гипотетической команды `chdir()`.  
2) `grep <some_string> <some_file> | wc -l` можно заменить на `grep -c <some_string> <some_file>`.  
3) `pstree -p` - systemd(1)  
4) `ls 2> /dev/pts/X`  
5) `grep <sometext> < inputFile 1> outputFile`  
![grepinout!](/7_Lesson_terminal_2/images/grepinout.png)<br>
6) Можно, если использовать перенаправление вывода. Как пример можно сделать такую конструкцию
`echo "hello to tty3 from desktop terminal" > /dev/tty3`
результата в графическом режиме не будет, надо переключиться на 3 TTY используя сочетание клавиш ctrl+alt+f3. 
И можно также сделать ответ `echo "replay" > /dev/pts/3`. Куда отправлять ответ можно узнать, выполнив команду в графическом терминале `tty`.
7) При выполнении `bash 5>&1` будет создан дескриптор 5 и он будет перенаправлен в поток вывода.
Далее при выполнении команды `echo netology > /proc/$$/fd/5` результат её выполнения будет виден на экране терминала.
8) Перезапустим виртуальную машину, сделаем новый дескриптор и перенаправим его в поток ошибок `bash 5>$2` и далее выполним команду   
`ls -l error 2>&1 1>&5 |grep or -c`  
`vagrant@vagrant:~$ ls -l error 2>&1 1>&5 |grep or -c`  
`1`
9) Команда `cat /proc/$$/environ` выводит список переменных окружения. Более читаемый вид дадут команды `strings /proc/$$/environ`, `env`, `printenv`.
10) `/proc/<PID>/cmdline` - содержит полную строку запуска для данного процесса с параметрами. Пока это процесс не станет "Зомби"
`/proc/<PID>/exe` - символическая ссылка на путь к исполняемому файлу процесса, при попытке выполнить эту ссылку будет запущена копия процесса.
11) `cat /proc/cpuinfo | grep sse` - sse4_2 Локальная машина, не Vagrant.
12) `ssh -t localhost 'tty'` - с такой командой все будет работать. `-t` принудительно выделяет псевдотерминал при запуске ssh.
13) Сначала устанавливаем пакет содержащий `reptyr`, `apt install reptyr`. Вносим изменения в конфигурационный файл `/etc/sysctl.d/10-ptrace.conf`.
`kernel.yama.ptrace_scope = 1` меням на `kernel.yama.ptrace_scope = 0`. Иначе получим ошибку доступа. И теперь по инструкции с github
`https://github.com/nelhage/reptyr#typical-usage-pattern` все получилось без ошибок. Вместо tmux использовал screen. Вместо `top` попробовал `tail` и `ping`.
14) `sudo echo string > /root/new_file` - если выполнить данную команду, то `echo` будет иметь права суперпользователя, а перенаправление в файл уже нет, так как выполняется средствами `bash`
`echo string | sudo tee /root/new_file` - в данном случае `echo` имеет обычны права и через | передает строку команде `tee` работающей с повышенными правами и
проблем с записью в файл уже нет.

 