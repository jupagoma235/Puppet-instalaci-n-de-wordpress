# - Archivo de puppet para la instalación de wordpress en laboratorio1 wordpress
# - Autor : Juan Pablo Gonzalez Marin
# - 29/11/2023

class wordpress {
	
	# -Declaración de orden de llamado de recursos
	Exec['descargar_wordpress'] -> File['/var/www/html/wordpress/wp-config.php'] ~> Service['apache2']
	
	# -Recurso que inserta el comando en la consola directamente para descargar el wordpress, descomprimirlo y moverlo al directorio de plublicacion
	exec {'descargar_wordpress':
		command      => 'curl -o /tmp/latest.tar.gz https://wordpress.org/latest.tar.gz && tar -xzvf /tmp/latest.tar.gz -C /var/www/html/ && chmod -R 777 /var/www/html/wordpress',
		cwd          => '/tmp',
	}
	
	# -Recurso que utiliza un template para generar un archivo de configuración de wordpress para la conexión con la BD
	file {'/var/www/html/wordpress/wp-config.php':
	    ensure => present,
		#owner       => root,
		#group       => root,
		mode         => '0777',
		content      => template('wordpress/wp-config.php.erb'),
		require      => Exec['descargar_wordpress'],
	} 
	
}
