Домашнее задание к занятию "5.1. Введение в виртуализацию. Типы и функции гипервизоров. Обзор рынка вендоров и областей применения."

1) Опишите кратко, как вы поняли: в чем основное отличие полной (аппаратной) виртуализации, паравиртуализации и виртуализации на основе ОС.  

Программная виртуализация  
Вся виртуализация проходит на уровне ядра операционной системы. В результате каждая из отдельных виртуальных машин работают как самостоятельный сервер. Преимущество программной виртуализации состоит в том, что любые процессы могут работать на высокой скорости.

Аппаратная виртуализация  
Подобная виртуализация осуществляется на основе процессорной архитектуры. Аппаратная виртуализация предусматривает разделение процессора на мониторную и гостевую части (root и non-root режимы). При такой виртуализации с помощью гипервизора возможно прямое управление гостевыми системами, которые используются изолировано друг от друга.

Контейнерная виртуализация  
Контейнерная виртуализация связана с изоляцией на уровне процессов ОС, доступна только в Linux и работает благодаря механизмам контейнеризации namespaces и cgroups. Такое решение обычно используется на уровне разных сервисов, которые являются частью программы.

В чём разница при работе с ядром гостевой ОС для полной и паравиртуализации?
При паравиртуализации ядро гостевой ОС модифицируется для взаимодействия с прослойков в виде гипервизора. При полной виртуализации ядро гостевой ОС остается неизменным и работает полностью изолированно.


2) Задача 2
Выберите один из вариантов использования организации физических серверов, в зависимости от условий использования.
  
Высоконагруженная база данных, чувствительная к отказу. - Желательно использовать или физический сервер или аппаратную виртуализацию. Для уменьшения шанса отказа лучше собирать в кластер.  
Различные web-приложения - Виртуализация уровня ОС, контейнеры. Оптимальное использование ресурсов, маштабируемость, отказоустойчивость.
Windows системы для использования бухгалтерским отделом. - Физические машины если боимся за ЭЦП и прочее, или паравиртуализация скорее всего на LinuxLike т.к. Hyper-V еще не научились прокидывать USB ключи.
Системы, выполняющие высокопроизводительные расчеты на GPU. - Или физический сервер с полным доступом к ресурсам системы для максимальной утилизации ресурсов для расчеты, или аппаратная виртуализация с пробросом GPU.  

3) Выберите подходящую систему управления виртуализацией для предложенного сценария. Детально опишите ваш выбор.

Сценарии:

a. 100 виртуальных машин на базе Linux и Windows, общие задачи, нет особых требований. Преимущественно Windows based инфраструктура, требуется реализация программных балансировщиков нагрузки, репликации данных и автоматизированного механизма создания резервных копий.  
Использовать Hyper-V. Собрать кластер из нескольких физических серверов для обеспечения отказоустойчивости и балансировки нагрузки. Отказоустойчиовсть достигается за счет репликации данных вирутальных машин между физическими серверами. Для резервоного копирования можно использовать или скрипты на psh или MS DataProtectionManager. В случае если используем сервера и общее хранилище данных, то можно обойтись репликацией между хранилищами. Hyper-v одинаково хорошо работает с Windows и Linux гостевыми машинами. Аналогичный функционал можно собрать и на ProxMox. Но потребуется иная экосистема. Физическая инфрастуруктура может быть одинаковой.
  
b. Требуется наиболее производительное бесплатное open source решение для виртуализации небольшой (20-30 серверов) инфраструктуры на базе Linux и Windows виртуальных машин.  
Предложил бы Xen PV. Бесплатно, c Windows работает лучше чем просто Xen. 
  
c. Необходимо бесплатное, максимально совместимое и производительное решение для виртуализации Windows инфраструктуры.  
Предложил бы Xen PV. Бесплатно, c Windows работает лучше чем просто Xen.

d. Необходимо рабочее окружение для тестирования программного продукта на нескольких дистрибутивах Linux.  
Если бесплатно то KVM или XEN. Если можем платить то Vmware или Hyper-V будет к месту, но очень избыточны для тестирования. Можно использовать их условнобесплтаные или ограниченные варианты такие как Vmware ESXI или Hyper-V core.

4) Опишите возможные проблемы и недостатки гетерогенной среды виртуализации (использования нескольких систем управления виртуализацией одновременно) и что необходимо сделать для минимизации этих рисков и проблем. Если бы у вас был выбор, то создавали бы вы гетерогенную среду или нет? Мотивируйте ваш ответ примерами.  

При создание подобных систем надо уделять особое внимание совместимости между собой слоям виртуализации. И соблюдать необходимость установки настроек для возможности выполнения вложенной виртуализации.
При использовании подобных систем увеличиваются "наклданые расходы" на виртуализацию. % ресурсов физической машины который вложенная виртуальная машина может использовать уменьшается, с количеством вложенных слоев.
Намного сложнее администрировать и локализовывать проблемы, особенно при использовании различных систем.
Создавал бы и использовал бы я такие. Если того требует продукт да, но минимизировал бы количество слоев, соблюдал бы совместимость между собой. Примерами вложенной виртуализации могут служить виртуальные машины облачных провайдеров. Так как купив несколько таких машин, мы можем организовать свое облако. Без необходимости строить такие системы смысла нет, будем платить за накладные расходы.
