# Домашнее задание к занятию "6.6. Troubleshooting"

## Задача 1

Перед выполнением задания ознакомьтесь с документацией по [администрированию MongoDB](https://docs.mongodb.com/manual/administration/).

Пользователь (разработчик) написал в канал поддержки, что у него уже 3 минуты происходит CRUD операция в MongoDB и её 
нужно прервать. 

**Вы как инженер поддержки решили произвести данную операцию:**
**- напишите список операций, которые вы будете производить для остановки запроса пользователя**
1) Необходимо локализовать проблемную транзакцию и узнать ее operation ID.
Если нагрузка на сервис не велика, достаточно выполнить команду через консоль mongosh `db.currentOp`
и в полученном выводе найти проблемную транзакцию. Если запросов на сервер поступает много, то необходимо конкретизировать
запрос. В запросе ниже мы отбираем все активные запросы длительностью свыше 3 секунд, для базы данных db1.
```
db.currentOp(
   {
     "active" : true,
     "secs_running" : { "$gt" : 3 },
     "ns" : /^db1\./
   }
)
```
2) После получение opID, выполняем команду `db.killOp(opID)`

**- предложите вариант решения проблемы с долгими (зависающими) запросами в MongoDB**
1) Если проблема возникла с операцией чтения, необходимо уменьшить число выдаваемых результатов, сделать запрос на 
выборку данных более точным, использовать индексы.
2) Если проблема возникла с операцией записи, необходимо уменьшить количество информацией записываемой за один запрос,
использовать индексы.

## Задача 2

Перед выполнением задания познакомьтесь с документацией по [Redis latency troobleshooting](https://redis.io/topics/latency).

Вы запустили инстанс Redis для использования совместно с сервисом, который использует механизм TTL. 
Причем отношение количества записанных key-value значений к количеству истёкших значений есть величина постоянная и
увеличивается пропорционально количеству реплик сервиса. 

**При масштабировании сервиса до N реплик вы увидели, что:**
**- сначала рост отношения записанных значений к истекшим.**  
Предположим, что сервис Redis не справляется с увеличенной нагрузкой, причина тому недостаточно кол-во оперативной памяти
и как следствие использование SWAP раздела, что ведет к увеличению общей задержки работы сервера. Если включен лог транзакций
AOF в режиме always, это еще больше усложнит жизнь дисковой подсистемы и увеличит задержки.  
**- Redis блокирует операции записи.**  
Операции записи буду заблокированы, как только Redis займет всю оперативную память и SWAP.

**Как вы думаете, в чем может быть проблема?**  
Сервер, выступающий в роли хостовой машины для Redis, подобран неверно, недостаточное количество оперативной памяти, и 
быстродействия дисковой подсистемы. Либо слишком много слоев виртуализации, что ухудшает взаимодействия Redis с памятью.
 
## Задача 3

Перед выполнением задания познакомьтесь с документацией по [Common Mysql errors](https://dev.mysql.com/doc/refman/8.0/en/common-errors.html).

Вы подняли базу данных MySQL для использования в гис-системе. При росте количества записей, в таблицах базы,
пользователи начали жаловаться на ошибки вида:
```python
InterfaceError: (InterfaceError) 2013: Lost connection to MySQL server during query u'SELECT..... '
```

**Как вы думаете, почему это начало происходить и как локализовать проблему?**  
Логично предположить из текста ошибки, что проблема возникла при долгом Select запросе. Из текста задачи известно, ГИС
система и большие таблицы. Как следвия сложные и большие запросы.
Сначала смотрим через Explain, что происходит с БД во время запроса.   
**Какие пути решения данной проблемы вы можете предложить?**  
Ставим Limit на выдачу информации. Обязательно настраиваем необходимое и достаточное количество индексов в таблицах.
Попутно заглядывая в мониторинг, наблюдаем, что происходит с сетью и не перегружена ли она в момент возникновения подобных
ошибок. И как дополнительный вариант, для случая если мы понимаем что делаем, увеличить время ожидания ответа от сервера
на запрос. Чаще всего значение по-умолчанию установлено на 30 сек. Можно увеличить, верхняя граница зависит от целей 
запроса и ТЗ бизнеса.

## Задача 4

Перед выполнением задания ознакомтесь со статьей [Common PostgreSQL errors](https://www.percona.com/blog/2020/06/05/10-common-postgresql-errors/) из блога Percona.

Вы решили перевести гис-систему из задачи 3 на PostgreSQL, так как прочитали в документации, что эта СУБД работает с 
большим объемом данных лучше, чем MySQL.

После запуска пользователи начали жаловаться, что СУБД время от времени становится недоступной. В dmesg вы видите, что:

`postmaster invoked oom-killer`

**Как вы думаете, что происходит?**
Сервис PostgreSQL забирается себе всю оперативную память.
OOM-Killer - Out Of Memory Killer - завершает процессы, которые занимают всю свободную оперативную память.

**Как бы вы решили данную проблему?**
PostgreSQL очень гибкая в настройках система, от этого и очень сложная. Для начала необходимо воспользоваться online
калькулятором параметров для сервиса PostgreSQL исходя из конфигурации сервера.
Добавить ресурсов если это возможно.

Если знаем, что делаем можно(но крайне не рекомендуется) отключить OOM-Killer.  

И пора бы настроить мониторинг, для получения оповещения о скором окончания оперативной памяти раньше, чем включится OOM-Killer.
И на всякий случай посмотреть нет ли новой версии, т.к. если все в порядке, то это может быть баг PostgreSQL и утечка
памяти как следствие.

---
