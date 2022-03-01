# Домашнее задание к занятию "5.4. Оркестрация группой Docker контейнеров на примере Docker Compose"


---

## Задача 1

Создать собственный образ операционной системы с помощью Packer.

Для получения зачета, вам необходимо предоставить:
- Скриншот страницы, как на слайде из презентации (слайд 37).  
Выполнено  
![task1!](/20_Lesson_05-virt-04-docker-compose/images/task1.png)<br>

## Задача 2

Создать вашу первую виртуальную машину в Яндекс.Облаке.

Для получения зачета, вам необходимо предоставить:
  
Выполнено  
![task2!](/20_Lesson_05-virt-04-docker-compose/images/task2.png)<br>



## Задача 3

Создать ваш первый готовый к боевой эксплуатации компонент мониторинга, состоящий из стека микросервисов.

Для получения зачета, вам необходимо предоставить:

Выполнено  
![task3!](/20_Lesson_05-virt-04-docker-compose/images/task3.png)<br>


## Задача 4 (*)

Создать вторую ВМ и подключить её к мониторингу развёрнутому на первом сервере.
Знатно пришлось подумать, в итоге сделал вторую ноду другой конфигурации для наглядности и экономии. 
Переписал playbook ansible, хотел сделать быстрее, просто задублировал код настройки первой ноды, для второй ноды сделал
отдельную группу и пакет задач. Аналогично поступил с compose файлом, оставил только cadvisor, nodeexporter и caddy.
Прописал через caddy проброс портов, на prometheus указал через ansible дополнительные точки сбора информации.
На grafana красивый вариант был бы реализовать через переменный Dashboard, для того чтобы попеременно отображать данные
с каждой из node, выбирая из выпадающего списка. Быстро не нагуглил, сделал по другому варианту, задублировал элементы
Dashboard и для уникальности отображения добавил отбор по instance.

Выполнено.  
Консоль яндекса, параметры вирт. машин.
![task41!](/20_Lesson_05-virt-04-docker-compose/images/task41.png)<br>
Grafana  
![task42!](/20_Lesson_05-virt-04-docker-compose/images/task42.png)<br>