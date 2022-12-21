#!/usr/bin/expect

set espera1 1
set espera2 2
set espera10 10
set ip_router [lindex $argv 0]
set usuario_router [lindex $argv 1]
set contrasena_router [lindex $argv 2]
set fichero_destino [lindex $argv 4]

#Abrimos una sesion SSH contra el switch
spawn ssh -oKexAlgorithms=+diffie-hellman-group1-sha1 -c $algoritmo -l $usuario_switch $ip_switch
sleep $espera2

#Captura la petición de contraseña de conexión SSH y la envía
expect {
"word:" {send "$contrasena_router\r"}
}
sleep $espera1

#Enviamos el comando de obtener la configuración del switch y enviarla al servidor FTP
expect {
"#" {send "copy startup-config:\r"}
}
sleep $espera1

#El servidor y el nombre del fichero destino
expect {
"?" {send "$fichero_destino\r"}
}
