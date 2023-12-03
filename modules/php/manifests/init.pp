# - Archivo de puppet para la instalación de php en laboratorio1 wordpress
# - Autor : Juan Pablo Gonzalez Marin
# - 29/11/2023

class php {
	
	# -Declaración de orden de llamado de recursos
	Package['php'] -> Package['php-mysqli'] -> Package['php-cli']

	# -Recurso para instalar php
	package {'php':
		ensure => installed,		
	}
	
	# -Recurso para instalar complemento que permite a php conectarse con mysql
	package {'php-mysqli':
		ensure => installed,
		require => Package['php'],
	}
	
	# -Recurso para instalar complemento que permite configurar php desde la consola de comandos
	package {'php-cli':
		ensure => installed,
		require => Package['php-mysqli'],
	}	
	
}
