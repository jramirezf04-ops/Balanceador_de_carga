#!/bin/bash
apt-get update
apt-get install -y apache2 certbot python3-certbot-apache ufw

# Activar los módulos necesarios para balanceo de carga en Apache
a2enmod proxy
a2enmod proxy_http
a2enmod proxy_balancer
a2enmod lbmethod_byrequests

# Configurar el VirtualHost de Apache como balanceador
cat <<EOF > /etc/apache2/sites-available/000-default.conf
<VirtualHost *:80>
    <Proxy "balancer://servidores_web">
        BalancerMember http://192.168.10.11
        BalancerMember http://192.168.10.12
        ProxySet lbmethod=byrequests
    </Proxy>

    ProxyPreserveHost On
    ProxyPass / balancer://servidores_web/
    ProxyPassReverse / balancer://servidores_web/
</VirtualHost>
EOF

# Firewall (UFW): permitir SSH, HTTP y HTTPS
ufw default deny incoming
ufw default allow outgoing
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw --force enable

systemctl restart apache2