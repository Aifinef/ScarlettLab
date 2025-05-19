#!/system/bin/sh

# Определение архитектуры устройства (ABI)
ABI=$(getprop ro.product.cpu.abi)
DIG="/system/bin/$ABI/dig"

CONFIG_DIR="/sdcard/Android/dnswatchdogchecker"
CONFIG_FILE="$CONFIG_DIR/config.txt"
RESULT_FILE="$CONFIG_DIR/dns_check_result.txt"
mkdir -p "$CONFIG_DIR"
: > "$RESULT_FILE"

# Чтение пользовательского DNS из конфига
if [ -f "$CONFIG_FILE" ]; then
    . "$CONFIG_FILE"
fi
USER_DNS=${DNS_SERVER:-"8.8.8.8"}

# Список доменов для проверки
DOMAINS="chat.openai.com gemini.google.com gpt.com xbox.com"

# Список DNS-серверов: имя и адрес
DNS_LIST="
Пользовательский $USER_DNS
AdGuard 94.140.14.14
NextDNS 45.90.28.0
Comss 83.220.169.155
"

{
echo "=== DNS Watch Dog Checker by Aifinef ==="
echo "Выбранный пользовательский DNS: $USER_DNS"
echo "Список используемых DNS:"
while read NAME ADDR; do
    [ -z "$NAME" ] && continue
    echo "  $NAME: $ADDR"
done <<EOF
$DNS_LIST
EOF
echo "-----------------------------"

for DOMAIN in $DOMAINS; do
    echo "Проверка $DOMAIN:"
    while read NAME ADDR; do
        [ -z "$NAME" ] && continue
        IPS=$($DIG @"$ADDR" "$DOMAIN" +short 2>/dev/null)
        if [ -z "$IPS" ]; then
            IPS="(нет ответа)"
        fi
        echo "  $NAME ($ADDR):"
        echo "$IPS" | sed 's/^/    /'
    done <<EOF
$DNS_LIST
EOF
    echo "-----------------------------"
done

echo "Готово! Результаты в $RESULT_FILE"
} | tee "$RESULT_FILE"