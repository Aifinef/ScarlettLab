#!/system/bin/sh

# Установка прав на dig для всех популярных архитектур
chmod 755 /system/bin/arm64-v8a/dig 2>/dev/null
chmod 755 /system/bin/armeabi-v7a/dig 2>/dev/null
chmod 755 /system/bin/x86/dig 2>/dev/null
chmod 755 /system/bin/x86_64/dig 2>/dev/null
chmod 755 /data/adb/modules/dns_watch_dog_checker/action.sh 2>/dev/null

# Установка прав на основной скрипт (если он есть)
chmod 755 /system/bin/dns_watch_dog_checker.sh 2>/dev/null