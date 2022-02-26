# Домашнее задание к занятию "6.2. SQL"

## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 12) c 2 volume, 
в который будут складываться данные БД и бэкапы.

```
version: '3.1'

services:

  db:
    image: postgres:12
    restart: always
    environment:
      POSTGRES_USER: pguser
      POSTGRES_PASSWORD: pguser
    volumes:
      - db-data:/var/lib/postgresql/data
      - db-bak:/var/pgbak

  adminer:
    image: adminer
    restart: always
    ports:
      - 8080:8080

volumes:
  db-data:
  db-bak:
  ```
## Задача 2
```commandline
docker exec -it 36533471ec5f bash
psql -U pguser
```
В БД из задачи 1:  
создайте пользователя test-admin-user и БД test_db
```sql
CREATE USER "test-admin-user";  
CREATE DATABASE "test_db";
- ```

- в БД test_db создайте таблицу orders и clients (спeцификация таблиц ниже)
```sql 
\c test_db
CREATE TABLE orders(id SERIAL PRIMARY KEY, naimenovanie VARCHAR, cena INT);
CREATE TABLE clients(id SERIAL PRIMARY KEY, familiya VARCHAR, stranav VARCHAR, zakaz INT, FOREIGN KEY (zakaz) REFERENCES orders (id) );
```
- предоставьте привилегии на все операции пользователю test-admin-user на таблицы БД test_db
```sql
GRANT ALL ON DATABASE test_db TO "test-admin-user";
```
- создайте пользователя test-simple-user 
```sql
CREATE USER "test-simple-user";
```
- предоставьте пользователю test-simple-user права на SELECT/INSERT/UPDATE/DELETE данных таблиц БД test_db
```sql
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO "test-simple-user";
```
Таблица orders:
- id (serial primary key)
- наименование (string)
- цена (integer)

Таблица clients:
- id (serial primary key)
- фамилия (string)
- страна проживания (string, index)
- заказ (foreign key orders)

Приведите:
- итоговый список БД после выполнения пунктов выше  
![task2!](/23_Lesson_06-db-02-sql/images/task2.png)<br>
- описание таблиц (describe)  
![task22!](/23_Lesson_06-db-02-sql/images/task2.2.png)<br>
- SQL-запрос для выдачи списка пользователей с правами над таблицами test_db 
```sql
SELECT grantee, privilege_type FROM information_schema.role_table_grants WHERE table_name='orders';
SELECT grantee, privilege_type FROM information_schema.role_table_grants WHERE table_name='clients';
```
![task23!](/23_Lesson_06-db-02-sql/images/task2.3.png)<br>
- список пользователей с правами над таблицами test_db
```sql
\z orders
\z clients
```  
![task24!](/23_Lesson_06-db-02-sql/images/task2.4.png)<br>

## Задача 3

Используя SQL синтаксис - наполните таблицы следующими тестовыми данными:

Таблица orders

|Наименование|цена|
|------------|----|
|Шоколад| 10 |
|Принтер| 3000 |
|Книга| 500 |
|Монитор| 7000|
|Гитара| 4000|
  Создание таблицы Orders
```sql
INSERT INTO 
orders (naimenovanie, cena)
VALUES 
('Шоколад', 10),
('Принтер', 3000), 
('Книга', 500), 
('Монитор', 7000), 
('Гитара', 4000);
```

Таблица clients

|ФИО|Страна проживания|
|------------|----|
|Иванов Иван Иванович| USA |
|Петров Петр Петрович| Canada |
|Иоганн Себастьян Бах| Japan |
|Ронни Джеймс Дио| Russia|
|Ritchie Blackmore| Russia|
  Создание таблицы Clients
```sql
INSERT INTO 
clients (familiya, stranav, zakaz)
VALUES 
('Иванов Иван Иванович', 'USA', NULL),
('Петров Петр Петрович', 'Canada',NULL), 
('Иоганн Себастьян Бах', 'Japan',NULL), 
('Ронни Джеймс Дио', 'Russia',NULL), 
('Ritchie Blackmore', 'Russia',NULL);
```
Используя SQL синтаксис:
- вычислите количество записей для каждой таблицы 
```sql
SELECT COUNT(id) FROM orders;
SELECT COUNT(id) FROM clients;
```
![taskCount!](/23_Lesson_06-db-02-sql/images/taskCOUNT.png)<br>
- приведите в ответе:
    - запросы 
    - результаты их выполнения.

## Задача 4

Часть пользователей из таблицы clients решили оформить заказы из таблицы orders.
Используя foreign keys свяжите записи из таблиц, согласно таблице:

|ФИО|Заказ|
|------------|----|
|Иванов Иван Иванович| Книга |
|Петров Петр Петрович| Монитор |
|Иоганн Себастьян Бах| Гитара |

Приведите SQL-запросы для выполнения данных операций.  
```sql
UPDATE clients SET zakaz=(SELECT id FROM orders WHERE naimenovanie like 'Книга') WHERE familiya like 'Иванов Иван Иванович';
UPDATE clients SET zakaz=(SELECT id FROM orders WHERE naimenovanie like 'Монитор') WHERE familiya like 'Петров Петр Петрович';
UPDATE clients SET zakaz=(SELECT id FROM orders WHERE naimenovanie like 'Гитара') WHERE familiya like 'Иоганн Себастьян Бах';
```  
Приведите SQL-запрос для выдачи всех пользователей, которые совершили заказ, а также вывод данного запроса.
```sql
SELECT * FROM clients WHERE zakaz != 0;
```
Или если хотим красиво то вот так:
```sql
SELECT familiya, naimenovanie FROM clients INNER JOIN orders ON zakaz=orders.id;
```  
![task3!](/23_Lesson_06-db-02-sql/images/task3.png)<br>

## Задача 5

Получите полную информацию по выполнению запроса выдачи всех пользователей из задачи 4 
(используя директиву EXPLAIN).

```sql
test_db=# EXPLAIN SELECT familiya, naimenovanie FROM clients INNER JOIN orders ON zakaz=orders.id;
                              QUERY PLAN                               
-----------------------------------------------------------------------
 Hash Join  (cost=37.00..57.24 rows=810 width=64)
   Hash Cond: (clients.zakaz = orders.id)
   ->  Seq Scan on clients  (cost=0.00..18.10 rows=810 width=36)
   ->  Hash  (cost=22.00..22.00 rows=1200 width=36)
         ->  Seq Scan on orders  (cost=0.00..22.00 rows=1200 width=36)
(5 rows)
```
Планировщик используется соединение по хешу, при котором строки одной таблицы записываются в хеш-таблицу в памяти,
после чего сканируется другая таблица и для каждой её строки проверяется совпадение по хеш-таблице. Hash Cond условия
отбора для объединения. Выполняется последовательное сканирование таблицы Clients и далее Hash создает хеш массив со 
строками из источника хэшированными с помощью элемента объединения столбец ID в orders.

## Задача 6

Создайте бэкап БД test_db и поместите его в volume, предназначенный для бэкапов (см. Задачу 1).
```commandline
root@86c0f8a0a126:/# pg_dump -U pguser test_db > /var/pgbak/test_db.bak
root@86c0f8a0a126:/# ls -a /var/pgbak/
.  ..  test_db.bak

```
Остановите контейнер с PostgreSQL (но не удаляйте volumes).
Контейнер остановил, но Volume с базой данных подключил другой. Все делал через docker-compouse. Содержания файла куда
восстанавливал.
```commandline
version: '3.1'

services:

  db:
    image: postgres:12
    restart: always
    environment:
      POSTGRES_USER: pguser
      POSTGRES_PASSWORD: pguser
    volumes:
      - db-restore:/var/lib/postgresql/data
      - db-bak:/var/pgbak

  adminer:
    image: adminer
    restart: always
    ports:
      - 8080:8080

volumes:
  db-restore:
  db-bak:
```
Поднимите новый пустой контейнер с PostgreSQL.
Включил контейнер, получил контейнер с другим названием.
Восстановите БД test_db в новом контейнере.
Для восстановления БД необходимо создать пустую базу данных, и пользователей которым выданы права на нее.
Для этого подключаемся внутрь контейнера и выполняем команды из прошлых заданий.

Приведите список операций, который вы применяли для бэкапа данных и восстановления.  
![taskrestore!](/23_Lesson_06-db-02-sql/images/taskrestore.png)<br>
Результат.  
![taskrestorerezult!](/23_Lesson_06-db-02-sql/images/taskrestorerezult.png)<br>

---