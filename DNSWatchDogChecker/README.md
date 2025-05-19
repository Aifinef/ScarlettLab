DNS Watch Dog Checker
Проверяет доступность ИИ-сервисов, Xbox, AdGuard, NextDNS и Comss через выбранный DNS-сервер.

В config.txt укажите один из следующих вариантов:

Публичный AdGuard DNS:
DNS_SERVER=dns.adguard.com

Персональный AdGuard DNS:
DNS_SERVER=ВАШ_ID.d.adguard-dns.com

Публичный NextDNS:
DNS_SERVER=dns.nextdns.io

Персональный NextDNS:
DNS_SERVER=ВАШ_ID.dns.nextdns.io

DNS Comss:
DNS_SERVER=dns.comss.one

DNS для Xbox:
DNS_SERVER=xbox-dns.ru

Запуск через терминал:

sh /system/bin/dns_watch_dog_checker.sh

Полный результат проверки появится в терминале и сохранится в файле:
/sdcard/Android/dnswatchdogchecker/dns_check_result.txt
