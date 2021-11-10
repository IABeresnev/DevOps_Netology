## Домашнее задание по уроку «2.4. Инструменты Git»
### 1) Найдите полный хеш и комментарий коммита, хеш которого начинается на aefea.
`git log -1 --pretty=format:'%H %s' aefea`  
aefead2207ef7e2aa5dc81a34aedf0cad4c32545 Update CHANGELOG.md
### 2) Какому тегу соответствует коммит 85024d3?
`git log -1 --pretty=format:'%D' 85024d3`  
tag: v0.12.23
### 3) Сколько родителей у коммита b8d720? Напишите их хеши.
`git rev-parse b8d720^@`  
56cd7859e05c36c06b56d013b55a252d0bb7e158  
9ea88f22fc6269854151c571162c5bcf958bee2b
### 4) Перечислите хеши и комментарии всех коммитов которые были сделаны между тегами v0.12.23 и v0.12.24.
`git log --oneline v0.12.23...v0.12.24`  
33ff1c03b (tag: v0.12.24) v0.12.24  
b14b74c49 [Website] vmc provider links  
3f235065b Update CHANGELOG.md  
6ae64e247 registry: Fix panic when server is unreachable  
5c619ca1b website: Remove links to the getting started guide's old location  
06275647e Update CHANGELOG.md  
d5f9411f5 command: Fix bug when using terraform login on Windows  
4b6d06cc5 Update CHANGELOG.md  
dd01a3507 Update CHANGELOG.md  
225466bc3 Cleanup after v0.12.23 release  
### 5)Найдите коммит в котором была создана функция func providerSource, ее определение в коде выглядит так func providerSource(...) (вместо троеточего перечислены аргументы). 
1) `git log -S'func providerSource' --oneline`  
5af1e6234 main: Honor explicit provider_installation CLI config when present -- Изменена   
8c928e835 main: Consult local directories as potential mirrors of providers -- Создана  
2) `git show 8c928e835`  
"+func providerSource(services *disco.Disco) getproviders.Source {" - первая строка объявления функции  
### 6) Найдите все коммиты в которых была изменена функция globalPluginDirs.
Нашел два варианта решения задачи, варианты случайно родились при детальном разборе различия ключей -L и -S команды git log.  
<b>Вариант 1.</b>  
Ищем коммит в котором была создана функция.  
1) `git log -S'globalPluginDirs' --oneline`  
35a058fb3 main: configure credentials from the CLI config file  
c0b176109 prevent log output during init  
8364383c3 Push plugin discovery down into command package  
2) `git show 8364383c3`  
Определям файл в котором была объявлена функция. plugins.go Видно из внесенных изменений в коммите и о том в какой файл была добавлена функция.  
3) Выводим все коммиты где была изменена функций "по разумению" GIT в файле plugins.go. Как запустить команду git log -L с добавлением ключа --pretty как в пункте 1 придумать не получилось. Использовал инструменты командной строки.  
`git log -L :globalPluginDirs:plugins.go | grep commit`  
commit 78b12205587fe839f10d946ea3fdc06719decb05  
commit 52dbf94834cb970b510f2fba853a5b49ad9b1a46  
commit 41ab0aef7a0fe030e84018973a64135b11abcd70  
commit 66ebff90cdfaa6938f26f908c7ebad8d547fea17  
commit 8364383c359a6b738a436d1b7745ccdce178df47  
<b>Вариант 2</b>  
Ищем файл в котором была создана функция.  
1. `git grep -n globalPluginDirs`  
commands.go:88:         GlobalPluginDirs: globalPluginDirs(),  
commands.go:430:        helperPlugins := pluginDiscovery.FindPlugins("credentials", globalPluginDirs())  
internal/command/cliconfig/config_unix.go:34: // FIXME: homeDir gets called from globalPluginDirs during init, before  
plugins.go:12:// globalPluginDirs returns directories that should be searched for  
plugins.go:18:func globalPluginDirs() []string {  
Объявление функции находится 5-ой строке и указывает на файл pugins.go  
2. Выводим все коммиты где была изменена функций "по разумению" GIT в файле plugins.go. Как запустить команду git log -L с добавлением ключа --pretty как в пункте 1 придумать не получилось. Использовал инструменты командной строки.  
`git log -L :globalPluginDirs:plugins.go | grep commit`  
commit 78b12205587fe839f10d946ea3fdc06719decb05  
commit 52dbf94834cb970b510f2fba853a5b49ad9b1a46  
commit 41ab0aef7a0fe030e84018973a64135b11abcd70  
commit 66ebff90cdfaa6938f26f908c7ebad8d547fea17  
commit 8364383c359a6b738a436d1b7745ccdce178df47  
### 7) Кто автор функции synchronizedWriters?
1) `git log -S'synchronizedWriters' --oneline`  
bdfea50cc remove unused  
fd4f7eb0b remove prefixed io  
5ac311e2a main: synchronize writes to VT100-faker on Windows -- Создана функция  
Если использовать команду "git grep -n synchronizedWriters" - ничего не находит. Я думаю, из-за того что файл и все упоминания о функции в текущий момент времени удалены из репозитория, на актуальном коммите.  
2) `git log -1 --pretty=format:'%an' 5ac311e2a`  
Martin Atkins
