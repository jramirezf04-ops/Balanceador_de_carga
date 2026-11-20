#!/bin/bash
apt-get update
apt-get install -y apache2 php libapache2-mod-php php-mysql git ufw

# Descargar y desplegar la aplicación
rm -rf /tmp/iaw-practica-lamp
git clone https://github.com/josejuansanchez/iaw-practica-lamp.git /tmp/iaw-practica-lamp
rm -f /var/www/html/index.html
cp -r /tmp/iaw-practica-lamp/src/* /var/www/html/

# Configurar conexión con la BBDD en Capa 3
sed -i "s/'localhost'/'192.168.20.20'/" /var/www/html/config.php
sed -i "s/'database_name_here'/'lamp_db'/" /var/www/html/config.php
sed -i "s/'username_here'/'lamp_user'/" /var/www/html/config.php
sed -i "s/'password_here'/'lamp_password'/" /var/www/html/config.php

# Mostrar qué servidor web responde
HOSTNAME=$(hostname)
sed -i "s/<body>/<body><p style='background:#222;color:#0f0;padding:8px;text-align:center;'>Atendido por: <b>$HOSTNAME<\/b><\/p>/" /var/www/html/index.php

# Firewall (UFW): solo SSH (Vagrant) y HTTP exclusivamente desde el Balanceador
ufw default deny incoming
ufw default allow outgoing
ufw allow 22/tcp
ufw allow from 192.168.10.10 to any port 80 proto tcp
ufw --force enable

systemctl restart apache2