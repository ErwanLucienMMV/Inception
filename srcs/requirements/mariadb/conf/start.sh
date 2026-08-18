#!/bin/bash

if [ ! -d "/var/lib/mysql/mysql" ]; then

    echo "[INFO] MariaDB is not initialized."
    echo "[INFO] Initializing database files..."

    mariadb-install-db \
        --user=mysql \
        --datadir=/var/lib/mysql

    echo "[OK] Database files initialized."

    echo "[INFO] Starting temporary MariaDB server..."

    mysqld_safe --datadir=/var/lib/mysql &

    echo "[INFO] Waiting for MariaDB to become ready..."

    until mysqladmin ping --silent; do
        sleep 1
    done

    echo "[OK] MariaDB is ready."

    echo "[INFO] Creating database: ${SQL_DATABASE}"

    mysql -u root <<-EOF
        CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
EOF

    echo "[OK] Database created."

    echo "[INFO] Creating user: ${SQL_USER}"

    mysql -u root <<-EOF
        CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';
EOF

    echo "[OK] User created."

    echo "[INFO] Granting privileges..."

    mysql -u root <<-EOF
        GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO '${SQL_USER}'@'%';
        FLUSH PRIVILEGES;
EOF

    echo "[OK] Privileges granted."

    echo "[INFO] Setting root password..."

    mysql -u root <<-EOF
        ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
        FLUSH PRIVILEGES;
EOF

    echo "[OK] Root password configured."

    echo "[INFO] Stopping temporary MariaDB server..."

    mysqladmin -u root -p"${SQL_ROOT_PASSWORD}" shutdown

    echo "[OK] Temporary server stopped."

else

    echo "[INFO] MariaDB is already initialized."
    echo "[INFO] Skipping database initialization."

fi

exec mysqld_safe --datadir=/var/lib/mysql