# Balanceador de Carga con Apache en Arquitectura de 3 Niveles

Práctica de **Implantación de Aplicaciones Web (2.º ASIR)** consistente en el despliegue automatizado de una aplicación web sobre una arquitectura de tres niveles con balanceo de carga en Apache, seguridad perimetral mediante firewall (UFW) y cifrado HTTPS con certificado válido de Let's Encrypt.


## Índice

1. [Introducción](#1-introducción)
2. [Arquitectura e infraestructura](#2-arquitectura-e-infraestructura)
3. [Aprovisionamiento de la infraestructura con Vagrant](#3-aprovisionamiento-de-la-infraestructura-con-vagrant)
4. [Configuración de la Capa 1: Balanceador de carga con Apache](#4-configuración-de-la-capa-1-balanceador-de-carga-con-apache)
5. [Configuración de la Capa 2: Servidores Web (Backend)](#5-configuración-de-la-capa-2-servidores-web-backend)
6. [Configuración de la Capa 3: Servidor de Base de Datos](#6-configuración-de-la-capa-3-servidor-de-base-de-datos)
7. [Seguridad: Reglas de firewall (UFW)](#7-seguridad-reglas-de-firewall-ufw)
8. [Instalación del certificado SSL/TLS con Certbot y Let's Encrypt](#8-instalación-del-certificado-ssltls-con-certbot-y-lets-encrypt)
9. [Pruebas de funcionamiento](#9-pruebas-de-funcionamiento)
10. [Screencast de demostración](#10-screencast-de-demostración)
