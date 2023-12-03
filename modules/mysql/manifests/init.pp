# - Archivo de puppet para la instalación de mysql en laboratorio1 wordpress
# - Autor : Juan Pablo Gonzalez Marin
# - 29/11/2023

class mysql {

	# -Declaración de orden de llamado de recursos
	Package['mysql-server'] ~> Service['mysql'] -> Exec['configurar_wp_database'] -> Exec['crear_wordpress_usuario'] -> Exec['grant_wordpress_privileges']
	
	# -Recurso para instalar mysql
	package {'mysql-server':
		ensure    => installed,
	}

	# -Recurso que lanza el servicio despues de la instalación del aplicativo, necesario para las configuraiones posteriores de la BD
	service {'mysql':
		ensure    => running,
		enable    => true,
		hasstatus => true,
	}
	
	# -Recurso que inserta el comando en la consola directamente para crear la BD que utilizara wordpress
	exec {'configurar_wp_database':
		command   => '/usr/bin/mysql -e "CREATE DATABASE IF NOT EXISTS wordpress;"',
		path      => ['/usr/bin','/bin'],
		unless    => '/usr/bin/mysql -e "SWOW DATABASE;" | grep mydatabase',
	}
	
	# -Recurso que inserta el comando en la consola directamente para llamar un script que crea un usuario en la BD, se hace de este modo ya que 
	#  con los comandos comentados y recomendados para la instalación no se logro dar solucion (se debe optimizar)
	exec {'crear_wordpress_usuario':
	    command   => 'sudo sh /opt/puppetlabs/puppet/modules/mysql/files/user.sh',
		#command  => '/usr/bin/mysql -e "CREATE USER \'AdminWordpress\'@\'localhost\' IDENTIFIED BY \'Admin12345\';"',		          
		#onlyif   => '/usr/bin/mysql -u root -e "SELECT User FROM mysql.user WHERE User=\'AdminWordpress\' AND Host=\'localhost\';" | grep -q \'AdminWordpress\'',
        #unless   => '/usr/bin/mysql -u root -e "SELECT User FROM mysql.user WHERE User=\'AdminWordpress\' AND Host=\'localhost\';" | grep -q \'AdminWordpress\'',
		#path     => ['/usr/bin','/bin','/usr/bin/mysql'],
		require   => Exec['configurar_wp_database'],	
	}
	
	# -Recurso que inserta el comando en la consola directamente para dar privilegios de administrador en la BD al usuario creado
	exec {'grant_wordpress_privileges':
		command   => '/usr/bin/mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO \'AdminWordpress\'@\'localhost\';"',
		path      => ['/usr/bin','/bin'],
		require   => Exec['crear_wordpress_usuario'],
	}	
	
}
