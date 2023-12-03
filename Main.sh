#!/bin/bash

# - Archivo ejecutable para presentación de laboratorio1 de herramientas de automatización
# - Autor : Juan Pablo Gonzalez Marin
# - 29/11/2023

########################## - Descarga e instalación de puppet - ##########################
wget "https://apt.puppetlabs.com/puppet6-release-bionic.deb"

sudo dpkg -i puppet6-release-bionic.deb

sudo apt-get update

sudo apt-get install -y puppet-agent

sleep 5

##################### - Copiar la carpeta de los modulos en puppet - #####################
sudo mv /tmp/modules /opt/puppetlabs/puppet/

sleep 3

sudo chmod -R 777 /opt/puppetlabs/puppet/modules

sleep 5

####################### - Crear variable de entorno para puppet - ########################
export PATH=/opt/puppetlabs/bin:$PATH

sleep 5

######################### - Lanzar el servicio de puppet-agente - ########################
sudo service puppet start

################### - Se instala el recurso para descargar paquetes - ####################
sudo apt-get install -y curl

sleep 5

#################### - Lanzar la aplicación de los modulos y tareas - ####################
sudo /opt/puppetlabs/bin/puppet apply /opt/puppetlabs/puppet/modules/manifests/site.pp