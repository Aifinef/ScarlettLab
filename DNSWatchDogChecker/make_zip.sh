#!/bin/bash

# Папка с твоим модулем (относительно текущей директории)
MODULE_DIR="DNSWatchDogChecker"

# Читаем версию из module.prop
VERSION=$(grep "^version=" "$MODULE_DIR/module.prop" | cut -d'=' -f2 | tr -d '[:space:]')

# Имя итогового архива
ZIP_NAME="${MODULE_DIR}-v${VERSION}.zip"

# Удаляем старый архив, если был
rm -f "$ZIP_NAME"

# Заходим в папку с модулем и пакуем всё содержимое на первый уровень архива
cd "$MODULE_DIR"
zip -r "../$ZIP_NAME" ./*
cd ..

echo "Готово! Архив $ZIP_NAME создан."
