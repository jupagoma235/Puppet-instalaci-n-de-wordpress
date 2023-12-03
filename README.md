# Aprovisionamiento de instalación de Wordpress con Puppet

El presente ejercicio corresponde a la instalación del aplicativo Wordpress mediante el aprovisionamiento de apache, php y msql, mediante la automatización con Puppet y levantando directamente la instalación con el agente.

En el repositorio se encuentra :

 -> Sript en bash que automatiza la instalación de lo necesario para el funcionamiento de agente de puppet (Main.sh). 
 
 -> Directorio modules que contiene los modulos necesarios. 
   
    -> Directorio manifests que contiene el archivo de configuración del sitio y que integra los otros modulos (site.pp).    
    -> Directorio del modulo apache.
       -> Directorio files en donde se encuentra el archivo de configuración de wordpress en apache.
       -> Directorio manifest que contiene el archivo de puppet que automatiza la instalación (Init.pp).
    -> Directorio del modulo php.      
       -> Directorio manifest que contiene el archivo de puppet que automatiza la instalación (Init.pp).
    -> Directorio del modulo mysql.
       -> Directorio files en donde se encuentra un script en bash para crear el usuario de wordpress en la BD.
       -> Directorio manifest que contiene el archivo de puppet que automatiza la instalación (Init.pp)
    -> Directorio del modulo wordpress.
       -> Directorio templates en donde se encuentra la plantilla de configuración de wordpress.
       -> Directorio manifest que contiene el archivo de puppet que automatiza la instalación (Init.pp).

En el presente ejercicio se da manejo a archivos, plantillas, scripts en bash, integrados a puppet para la instalación.

