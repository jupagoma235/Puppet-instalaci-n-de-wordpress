#!/bin/bash

# - Archivo ejecutable para presentación de laboratorio1 de herramientas de automatización
# - Autor : Juan Pablo Gonzalez Marin
# - 30/11/2023

########################## - Descarga e instalación de puppet - ##########################
user=$( /usr/bin/mysql -u root -e "SELECT User FROM mysql.user WHERE User='AdminWordpress' AND Host='localhost';" )
echo user
if [ "$user" != "AdminWordpress" ]; then
	sudo /usr/bin/mysql -e "CREATE USER 'AdminWordpress'@'localhost' IDENTIFIED BY 'Admin12345';"	
	echo "usuario creado"
else
	echo "usuario ya existe"
	echo "$user"
fi