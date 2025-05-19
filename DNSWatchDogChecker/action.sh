#!/system/bin/sh

# Для вывода сообщений в окно ACTION
exec 5>&1
printMsg() { echo "$*" >&5; }

# Логирование для отладки
exec 1>/data/local/tmp/dns_watchdog_action.log 2>&1
set -x

# Настройки путей
CONFIG_DIR="/sdcard/Android/dnswatchdogchecker"
mkdir -p "$CONFIG_DIR"
CONFIG_FILE="$CONFIG_DIR/config.txt"
RESULT_FILE="$CONFIG_DIR/dns_check_result.txt"

# Сообщение о времени закрытия окна
printMsg "ℹ️ Это окно закроется через 20 секунд."
printMsg "Полный результат - в файле $RESULT_FILE"
printMsg ""

printMsg "=== DNS Watch Dog Checker ==="
printMsg ""

# Автосоздание config.txt с понятной инструкцией
if [ ! -f "$CONFIG_FILE" ]; then
    cat > "$CONFIG_FILE" <<EOF
# Укажите здесь адрес DNS-сервера или доменное имя.
# Пример для AdGuard:
DNS_SERVER=dns.adguard.com
# Пример для NextDNS:
# DNS_SERVER=dns.nextdns.io
# Пример для персонального AdGuard:
# DNS_SERVER=ВАШ_ID.d.adguard-dns.com
# Пример для персонального NextDNS:
# DNS_SERVER=ВАШ_ID.dns.nextdns.io
# Пример для Comss:
# DNS_SERVER=dns.comss.one
EOF
    printMsg "Создан config.txt с примерами. Откройте и измените этот файл под свой DNS."
fi

# Получаем DNS из конфига
DNS_SERVER=$(grep -E '^DNS_SERVER=' "$CONFIG_FILE" | cut -d'=' -f2 | tr -d '\r\n ')

if [ -z "$DNS_SERVER" ]; then
    printMsg "❗ В config.txt не прописан DNS_SERVER или строка пуста."
    printMsg "Проверьте файл: $CONFIG_FILE"
    printMsg "Пример строки: DNS_SERVER=dns.adguard.com"
    printMsg "После правки config.txt снова запустите проверку!"
    sleep 10
    exit 1
fi

# Запуск основного скрипта
/system/bin/dns_watch_dog_checker.sh

# Проверка результата
if [ ! -f "$RESULT_FILE" ]; then
    printMsg "Ошибка: не удалось получить результаты проверки."
    exit 1
fi

# Выводим весь результат (можно листать!)
cat "$RESULT_FILE" | while read line; do
    printMsg "$line"
done
printMsg ""
printMsg "Полный результат - в файле $RESULT_FILE"
printMsg "Логи: /data/local/tmp/dns_watchdog_action.log"
sleep 20