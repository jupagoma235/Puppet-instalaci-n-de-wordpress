# - Archivo de puppet para la instalación de wordpress en laboratorio1 wordpress
# - Autor : Juan Pablo Gonzalez Marin
# - 29/11/2023
    
	# -Actualiza los paquetes del sistema.
	exec { 'apt-update':
		command => '/usr/bin/apt-get update'
	}

	# -Se definen las rutas o path que utilizara el sitio
	Exec { path => "/bin/:/sbin/:/usr/bin/:/usr/sbin/:/usr/local/bin:/usr/local/sbin:~/.composer/vendor/bin/" }

	# -Notificación de inicio de la instalación
	notify {'Start install':
		message  => "#########**  Inicia la verificación...✔  **########",
		withpath => false,
		require  => Exec['apt-update'],
	}
	
	# -Carga o llamado de los modulos del sitio
	require apache
	require php
	require mysql
	require wordpress
	
	# -Notificación de instalacion de apache, dependiente del modulo de apache
	notify{'Instalación_Apache':
		message  => "#########**  Modulo Apache instalado...✔  **########",
		withpath => false,
		require  => Service['apache2'],
	}
	
	# -Notificación de instalación de php, dependiente del modulo de php
	notify{'Instalación_Php':
		message  => "#########**  Modulo Php instalado...✔     **#########",
		withpath => false,
		require  => Package['php-mysqli'],
	}
	
	# -Notificación de instalación de Mysql, dependiente del modulo de Mysql
	notify{'Instalación_Mysql':
		message  => "#########**  Modulo Mysql instalado...✔   **#########",
		withpath => false,
		require  => Exec['grant_wordpress_privileges'],
	}
	
	# -Notificación de instalación de Wordpress, dependiente del modulo de Wordpress
	notify{'Instalación_Wordpress':
		message  => "#########**  Modulo Wordpress instalado..✔**##########",
		withpath => false,		
		require  => File['/var/www/html/wordpress/wp-config.php'],
	}
	
	# -Notificación de finalización de instalación de paquetes
	notify {'Finished install':
		message  => "#########**  INSTALACION EXITOSA!!!!..✔   **##########",
		withpath => false,
		require  => Notify['Instalación_Wordpress'],
	}
