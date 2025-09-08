#!/bin/sh

echo "[INFO] Waiting for MariaDB to be ready..."
until mysqladmin ping -h"mariadb" --silent; do
  echo "[INFO] MariaDB is unavailable - sleeping"
  sleep 2
done

if [ ! -f "wp-config.php" ]; then
    echo "[INFO] Downloading WordPress..."
    wp core download --allow-root

    echo "[INFO] Creating wp-config.php..."
    wp config create --allow-root \
        --dbname="${MYSQL_DATABASE}" \
        --dbuser="${MYSQL_USER}" \
        --dbpass="${MYSQL_PASSWORD}" \
        --dbhost="mariadb"

    echo "[INFO] Installing WordPress..."
    wp core install --allow-root \
        --url="https://${DOMAIN_NAME}" \
        --title="Inception" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}"

    echo "[INFO] Creating additional user..."
    wp user create --allow-root \
        "${WP_USER}" "${WP_USER_EMAIL}" \
        --role=author \
        --user_pass="${WP_USER_PASSWORD}"
else
    echo "[INFO] WordPress already configured."
fi

exec php-fpm7.4 -F
