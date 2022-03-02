# Домашнее задание к занятию "6.4. PostgreSQL"

## Задача 1

Используя docker поднимите инстанс PostgreSQL (версию 13). Данные БД сохраните в volume.

Подключитесь к БД PostgreSQL используя `psql`.

Воспользуйтесь командой `\?` для вывода подсказки по имеющимся в `psql` управляющим командам.

**Найдите и приведите** управляющие команды для:
- вывода списка БД `\l`
- подключения к БД `\c`
- вывода списка таблиц `\dt`
- вывода описания содержимого таблиц `\d+`
- выхода из psql `\q`

## Задача 2

Используя `psql` создайте БД `test_database`.

Изучите [бэкап БД](https://github.com/netology-code/virt-homeworks/tree/master/06-db-04-postgresql/test_data).

Восстановите бэкап БД в `test_database`.

Перейдите в управляющую консоль `psql` внутри контейнера.

Подключитесь к восстановленной БД и проведите операцию ANALYZE для сбора статистики по таблице.

Используя таблицу [pg_stats](https://postgrespro.ru/docs/postgresql/12/view-pg-stats), найдите столбец таблицы `orders` 
с наибольшим средним значением размера элементов в байтах.

**Приведите в ответе** команду, которую вы использовали для вычисления и полученный результат.  
```sql
select tablename,attname,avg_width from pg_stats where tablename='orders';
```  
или если хотим совсем красиво то вот так можно  
```sql
select tablename,attname,avg_width from pg_stats where tablename='orders' order by avg_width desc limit 1;
```  
![taskavgwidth!](/25_Lesson_06-db-04-postgresql/images/taskavgwidth.png)<br>


## Задача 3

Архитектор и администратор БД выяснили, что ваша таблица orders разрослась до невиданных размеров и
поиск по ней занимает долгое время. Вам, как успешному выпускнику курсов DevOps в нетологии предложили
провести разбиение таблицы на 2 (шардировать на orders_1 - price>499 и orders_2 - price<=499).

Предложите SQL-транзакцию для проведения данной операции.  
```sql
CREATE TABLE orders_1 ( CHECK ( price > 499)) INHERITS (orders);  
CREATE TABLE orders_2 ( CHECK ( price <= 499)) INHERITS (orders);
```  
Далее создаем правила, для корректной передачи(перенаправления/распределения) данных по разделенным таблицам.  
```sql
CREATE RULE orders_insert_to_1 AS ON INSERT TO orders WHERE ( price > 499) DO INSTEAD INSERT INTO orders_1 VALUES (NEW.*);  
CREATE RULE orders_insert_to_2 AS ON INSERT TO orders WHERE ( price <= 499) DO INSTEAD INSERT INTO orders_2 VALUES (NEW.*);
```  
![taskshard!](/25_Lesson_06-db-04-postgresql/images/taskshard.png)<br>

Можно ли было изначально исключить "ручное" разбиение при проектировании таблицы orders?  
Думаю да, должна была быть возможность продумать возможный размер и нагрузку на таблицу. Исходя из данных, можно было бы сделать вывод о необходимости шардирования и\или изменении структуры таблицы.

## Задача 4

Используя утилиту `pg_dump` создайте бекап БД `test_database`.

Как бы вы доработали бэкап-файл, чтобы добавить уникальность значения столбца `title` для таблиц `test_database`?  
Если я верно понял формулировку задания. Предположу, что название столбца `test` недостаточно точно определяет его содержимое. Судя по содержимому таблицы `orders`
мы имеем дело с чем-то книжным, из простого предложил бы переименовать столбец `title` в `booktitle` или более общее `goodstitle`.

---
#Доработка "Задача 4"

После отправки на доработку, формулировка задания изменилась, стало яснее.  
Как бы вы доработали бэкап-файл, чтобы добавить уникальность значенияМ столбца `title` для таблиц `test_database`? 
```sql
    CREATE TABLE public.orders (
    id integer NOT NULL,
    title character varying(80) NOT NULL,
    price integer DEFAULT 0
);
```

В коде создании таблицы `orders` добавил бы параметр ```sql UNIQUE ```  который след за уникальностью данных в этом столбце, на моменте внесения данных или изменения.
Если смотреть еще глубже, то возможна такая ситуация, когда поля в столбце `title` должны быть одинаковыми и никак иначе, например книги одинаковые, но различаются издательством или годом.
В таком случае параметр уникальности надо включать для двух полей одновременно, и тогда мы должны либо:
1) `id` переделать в SERIAL и дать уникальность по двум полям
```sql
    CREATE TABLE public.orders (
    id serial NOT NULL,
    title character varying(80) NOT NULL,
    price integer DEFAULT 0
    UNIQUE (id, title)
);
```
2) Или надеемся на то, что цена у нас тоже всегда разная и тогда задаем уникальность по полю `price` и `title`
```sql
    CREATE TABLE public.orders (
    id integer NOT NULL,
    title character varying(80) NOT NULL,
    price integer DEFAULT 0
    UNIQUE (title, price)
); 
```
---

