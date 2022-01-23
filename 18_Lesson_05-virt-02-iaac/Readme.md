Домашнее задание к занятию "5.2. Применение принципов IaaC в работе с виртуальными машинами"

1) Задача 1  
Опишите своими словами основные преимущества применения на практике IaaC паттернов.  
Создать и маштабировать инфраструктуру быстрее кодом, а не руками. Меньше шансов ошибиться(допустить разницу) в конфигурации при тестах, разработке и на проде. При верном подходе инфраструктуру при проблеме быстрее поднять с 0, а не чинить.

Какой из принципов IaaC является основополагающим?  
Индемпотентность - при выполнении кода создания инфраструктуры мы всегда получим один и тотже результат.

2) Задача 2  
Чем Ansible выгодно отличается от других систем управление конфигурациями?  
Ansible не требует наличие агента на управляемом хосте, достаточно настройки SSH подключения.
Простота развертывания и установки.

Какой, на ваш взгляд, метод работы систем конфигурации более надёжный push или pull?  
При использовании метода PUSH мы сами определяем когда сервер должен принимать и использовать новую конфигурацию, при методе PULL это невозможно. При PUSH мы быстрее обнаружим сбойные сервер, т.к. возникнут проблемы либо с подключениме, либо с применением конфигурации. 

3) Задача 3
Установить на личный компьютер:
VirtualBox
```commandline
vboxmanage --version                                                                         
6.1.26_Ubuntur145957
sudo apt install virtualbox                                                                  
[sudo] пароль для yolo: 
Чтение списков пакетов… Готово
Построение дерева зависимостей… Готово
Чтение информации о состоянии… Готово         
Уже установлен пакет virtualbox самой новой версии (6.1.26-dfsg-4).
Обновлено 0 пакетов, установлено 0 новых пакетов, для удаления отмечено 0 пакетов, и 0 пакетов не обновлено.
```
Vagrant
```commandline
vagrant --version
Vagrant 2.2.19
```
Ansible
```commandline
ansible --version                                                                      
ansible 2.10.8
  config file = None
  configured module search path = ['/home/yolo/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  executable location = /usr/bin/ansible
  python version = 3.9.7 (default, Sep 10 2021, 14:59:43) [GCC 11.2.0]
```
4) Задача 4 (*)  
Воспроизвести практическую часть лекции самостоятельно.  
Создать виртуальную машину.  
```commandline
vagrant up
Bringing machine 'server1.netology' up with 'virtualbox' provider...
==> server1.netology: Importing base box 'bento/ubuntu-20.04'...
==> server1.netology: Matching MAC address for NAT networking...
==> server1.netology: Checking if box 'bento/ubuntu-20.04' version '202112.19.0' is up to date...
==> server1.netology: Setting the name of the VM: server1.netology
==> server1.netology: Clearing any previously set network interfaces...
==> server1.netology: Preparing network interfaces based on configuration...
    server1.netology: Adapter 1: nat
    server1.netology: Adapter 2: hostonly
==> server1.netology: Forwarding ports...
    server1.netology: 22 (guest) => 20011 (host) (adapter 1)
    server1.netology: 22 (guest) => 2222 (host) (adapter 1)
==> server1.netology: Running 'pre-boot' VM customizations...
==> server1.netology: Booting VM...
==> server1.netology: Waiting for machine to boot. This may take a few minutes...
    server1.netology: SSH address: 127.0.0.1:2222
    server1.netology: SSH username: vagrant
    server1.netology: SSH auth method: private key
    server1.netology: 
    server1.netology: Vagrant insecure key detected. Vagrant will automatically replace
    server1.netology: this with a newly generated keypair for better security.
    server1.netology: 
    server1.netology: Inserting generated public key within guest...
    server1.netology: Removing insecure key from the guest if it's present...
    server1.netology: Key inserted! Disconnecting and reconnecting using new SSH key...
==> server1.netology: Machine booted and ready!
==> server1.netology: Checking for guest additions in VM...
==> server1.netology: Setting hostname...
==> server1.netology: Configuring and enabling network interfaces...
==> server1.netology: Mounting shared folders...
    server1.netology: /vagrant => /home/yolo/vagans
==> server1.netology: Running provisioner: ansible...
    server1.netology: Running ansible-playbook...

PLAY [nodes] *******************************************************************

TASK [Gathering Facts] *********************************************************
ok: [server1.netology]

TASK [Create directory for ssh-keys] *******************************************
ok: [server1.netology]

TASK [Adding rsa-key in /root/.ssh/authorized_keys] ****************************
An exception occurred during task execution. To see the full traceback, use -vvv. The error was: If you are using a module and expect the file to exist on the remote, see the remote_src option
fatal: [server1.netology]: FAILED! => {"changed": false, "msg": "Could not find or access '~/.ssh/id_rsa.pub' on the Ansible Controller.\nIf you are using a module and expect the file to exist on the remote, see the remote_src option"}
...ignoring

TASK [Checking DNS] ************************************************************
changed: [server1.netology]

TASK [Installing tools] ********************************************************
ok: [server1.netology] => (item=['git', 'curl'])

TASK [Installing docker] *******************************************************
changed: [server1.netology]

TASK [Add the current user to docker group] ************************************
changed: [server1.netology]

PLAY RECAP *********************************************************************
server1.netology           : ok=7    changed=3    unreachable=0    failed=0    skipped=0    rescued=0    ignored=1   
```
Зайти внутрь ВМ, убедиться, что Docker установлен с помощью команды.  
```commandline
vagrant ssh                                                                                        
Welcome to Ubuntu 20.04.3 LTS (GNU/Linux 5.4.0-91-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

 System information disabled due to load higher than 1.0


This system is built by the Bento project by Chef Software
More information can be found at https://github.com/chef/bento
Last login: Sun Jan 23 18:55:51 2022 from 10.0.2.2
vagrant@server1:~$ docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
vagrant@server1:~$
```