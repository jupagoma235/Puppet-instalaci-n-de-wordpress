# - Archivo de puppet para la instalación de apache en laboratorio1 wordpress
# - Autor : Juan Pablo Gonzalez Marin
# - 29/11/2023

class apache{

	# -Declaración de orden de llamado de recursos
	Package['apache2'] -> File['/etc/apache2/sites-available/wordpress.conf'] ~> Service['apache2'] 
	
	# -Recurso para instalar apache
	package {'apache2':
		ensure      => installed,
	}
	
	# -Recurso que traslada un archivo de configuración de wordpress para que sea reconocido por el apache
	file {'/etc/apache2/sites-available/wordpress.conf':	
		ensure      => present,
		source      => 'puppet:///modules/wordpress/wordpress.conf',
	}	
	
	# -Recurso que lanza el servicio despues de la instalación del aplicativo
	service { 'apache2':
		ensure      => running,
		enable      => true,
		hasstatus   => true,
	}	
	
}
