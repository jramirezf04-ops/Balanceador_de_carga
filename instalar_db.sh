#!/bin/bash
apt-get update
apt-get install -y mariadb-server ufw

# Permitir conexiones desde la red privada
sed -i "s/bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf
systemctl restart mariadb

# Crear BBDD, usuario y tabla
mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS lamp_db DEFAULT CHARACTER SET utf8mb4;
CREATE USER IF NOT EXISTS 'lamp_user'@'%' IDENTIFIED BY 'lamp_password';
GRANT ALL PRIVILEGES ON lamp_db.* TO 'lamp_user'@'%';
FLUSH PRIVILEGES;

USE lamp_db;
CREATE TABLE IF NOT EXISTS users (
  id int(11) NOT NULL auto_increment,
  name varchar(100) NOT NULL,
  age int(3) NOT NULL,
  email varchar(100) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
EOF

# Firewall (UFW): solo SSH (para Vagrant) y MySQL desde Web1 y Web2
ufw default deny incoming
ufw default allow outgoing
ufw allow 22/tcp
ufw allow from 192.168.20.11 to any port 3306 proto tcp
ufw allow from 192.168.20.12 to any port 3306 proto tcp
ufw --force enable

# Aislar de Internet eliminando la puerta de enlace por defecto
ip route del default dev eth0