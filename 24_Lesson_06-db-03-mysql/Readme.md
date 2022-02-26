# Домашнее задание к занятию "6.3. MySQL"

## Задача 1

Используя docker поднимите инстанс MySQL (версию 8). Данные БД сохраните в volume.

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/master/06-db-03-mysql/test_data) и 
восстановитесь из него.  
![taskrestore!](/24_Lesson_06-db-03-mysql/images/taskrestoredb.png)  
Перейдите в управляющую консоль `mysql` внутри контейнера.
Используя команду `\h` получите список управляющих команд.  
![taskrestoredb!](/24_Lesson_06-db-03-mysql/images/taskrestoredb.png)    
Найдите команду для выдачи статуса БД и **приведите в ответе** из ее вывода версию сервера БД.  
![taskstatus!](/24_Lesson_06-db-03-mysql/images/taskstatus.png)    
Подключитесь к восстановленной БД и получите список таблиц из этой БД.  
![taskshwotables!](/24_Lesson_06-db-03-mysql/images/showtables.png)  
**Приведите в ответе** количество записей с `price` > 300.  
![taskselect!](/24_Lesson_06-db-03-mysql/images/taskselect.png)   


## Задача 2

Создайте пользователя test в БД c паролем test-pass, используя:
- плагин авторизации mysql_native_password
- срок истечения пароля - 180 дней 
- количество попыток авторизации - 3 
- максимальное количество запросов в час - 100
- аттрибуты пользователя:
    - Фамилия "Pretty"
    - Имя "James"

```sql
CREATE USER 'test'@'localhost' 
IDENTIFIED WITH mysql_native_password BY 'test' 
PASSWORD EXPIRE INTERVAL 180 DAY 
FAILED_LOGIN_ATTEMPTS 3 
ATTRIBUTE '{"fname": "James", "lname": "Pretty"}';
```
```sql
ALTER USER 'test'@'localhost' WITH MAX_QUERIES_PER_HOUR 100;
```  
![taskuser!](/24_Lesson_06-db-03-mysql/images/taskuser.png)  

Предоставьте привелегии пользователю `test` на операции SELECT базы `test_db`.
```sql
GRANT SELECT ON test_db.* TO 'test'@'localhost';
```
Используя таблицу INFORMATION_SCHEMA.USER_ATTRIBUTES получите данные по пользователю `test` и 
**приведите в ответе к задаче**.
```sql
SELECT * FROM INFORMATION_SCHEMA.USER_ATTRIBUTES WHERE USER = 'test' AND HOST = 'localhost';
```
![taskattr!](/24_Lesson_06-db-03-mysql/images/taskattr.png)  

## Задача 3
Установите профилирование `SET profiling = 1`.
Изучите вывод профилирования команд `SHOW PROFILES;`.

Исследуйте, какой `engine` используется в таблице БД `test_db` и **приведите в ответе**.
```sql
SELECT TABLE_NAME,
       ENGINE
FROM   information_schema.TABLES
WHERE  TABLE_SCHEMA = 'test_db';
```
Измените `engine` и **приведите время выполнения и запрос на изменения из профайлера в ответе**:
- на `MyISAM`  
![taskmyisambenchmark!](/24_Lesson_06-db-03-mysql/images/taskmyisambenchmark.png)  
- на `InnoDB`  
![taskinnobenchmark!](/24_Lesson_06-db-03-mysql/images/taskinnobenchmark.png)  

Изменение UPDATE в InnoDB выполняется в 2 раза быстрее. Select в моем случае выполнился за одинаковое кол-во времени.
## Задача 4 

Изучите файл `my.cnf` в директории /etc/mysql.

Измените его согласно ТЗ (движок InnoDB):
- Скорость IO важнее сохранности данных - innodb_flush_method = O_DSYNC; innodb_flush_log_at_trx_commit = 2;
- Нужна компрессия таблиц для экономии места на диске - innodb_default_row_format=COMPRESSED;
- Размер буффера с незакомиченными транзакциями 1 Мб - innodb_log_buffer_size = 1MB;
- Буффер кеширования 30% от ОЗУ - innodb_buffer_pool_size = 10GB;
- Размер файла логов операций 100 Мб - innodb_log_file_size = 100MB;

Приведите в ответе измененный файл `my.cnf`.  
В файле `my.cnf` есть строка, указывающая, что собственные конфигурации должны храниться в ином файле. 
В `/etc/mysql/conf.d` создаем файл `addedoptions.cnf` и вносим туда поля.
```commandline
[mysqld]
innodb_flush_method = O_DSYNC
innodb_flush_log_at_trx_commit = 2
innodb_default_row_format=COMPRESSED
innodb_log_buffer_size = 1MB
innodb_buffer_pool_size = 10GB
innodb_log_file_size = 100MB
```

