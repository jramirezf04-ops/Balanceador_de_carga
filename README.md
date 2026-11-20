# Balanceador de Carga con Apache en Arquitectura de 3 Niveles

Práctica de **Implantación de Aplicaciones Web** consistente en el despliegue automatizado de una aplicación web sobre una arquitectura de tres niveles con balanceo de carga en Apache, seguridad perimetral mediante firewall (UFW) y cifrado HTTPS con certificado válido de Let's Encrypt.


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

## 1. Introducción

El objetivo de esta práctica es desplegar una aplicación web escalable y segura separando sus responsabilidades en **tres niveles independientes** (balanceador, servidores de aplicación y base de datos). Esta separación mejora tanto el rendimiento al repartir las peticiones entre varios nodos web como la seguridad, ya que únicamente el balanceador queda expuesto al exterior mientras los servidores web y la base de datos permanecen aislados en redes privadas.

Para el despliegue se ha utilizado **Vagrant** junto con **VirtualBox**, automatizando la creación y configuración inicial de las cuatro máquinas virtuales mediante scripts de aprovisionamiento en Bash.


## 2. Arquitectura e infraestructura

La infraestructura se compone de cuatro máquinas virtuales organizadas en tres capas:

| Capa | Nombre de la máquina | Rol | Red / Acceso | Servicios principales |
| :--- | :--- | :--- | :--- | :--- |
| **Capa 1** | `JavierRamirezBalanceador` | Balanceador de carga | Red pública (puertos `8080→80` y `8443→443`) y red privada | Apache, Certbot, UFW |
| **Capa 2** | `JavierRamirezWeb1` | Servidor Web 1 (Backend) | Red privada (`192.168.10.11`) | Apache, PHP, aplicación web, UFW |
| **Capa 2** | `JavierRamirezWeb2` | Servidor Web 2 (Backend) | Red privada (`192.168.10.12`) | Apache, PHP, aplicación web, UFW |
| **Capa 3** | `JavierRamirezBBDD` | Servidor de Base de Datos | Red privada | MariaDB, UFW |

## 3. Aprovisionamiento de la infraestructura con Vagrant

El entorno se ha definido en el archivo `Vagrantfile`, que levanta las cuatro máquinas virtuales, asigna los nombres de host correspondientes, configura los adaptadores de red y ejecuta los scripts de aprovisionamiento (`instalar_balanceador.sh`, scripts de servidores web y script de base de datos).

Para iniciar todo el escenario se ejecuta:

```bash
vagrant up
```


