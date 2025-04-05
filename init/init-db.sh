#!/bin/bash
set -e

echo "Создание таблицы mock_data..."
psql --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -f /docker-entrypoint-initdb.d/sql/init_mock_data.sql

echo "Импорт всех CSV-файлов в mock_data..."

for file in /docker-entrypoint-initdb.d/исходные\ данные/MOCK_DATA*.csv; do
  if [ -f "$file" ]; then
    echo "Импорт файла: $file"
    psql --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" \
         -c "\COPY mock_data FROM '$file' WITH CSV HEADER"
  else
    echo "Файл $file не найден, пропускаем..."
  fi
done

echo "Выполнение ddl_create_tables.sql..."
psql --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -f /docker-entrypoint-initdb.d/sql/ddl_create_tables.sql

echo "Выполнение dml_insert_data.sql..."
psql --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" -f /docker-entrypoint-initdb.d/sql/dml_insert_data.sql

echo "Инициализация завершена!"
