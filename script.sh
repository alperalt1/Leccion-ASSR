#!/usr/bin/expect

set espera1 1
set espera2 2
set espera10 10
set ip_switch [lindex $argv 0]
set usuario_switch [lindex $argv 1]
set contrasena_switch [lindex $argv 2]
set servidor_ftp [lindex $argv 3]
set fichero_destino [lindex $argv 4]

#Abrimos una sesion SSH contra el switch
spawn ssh -l $usuario_switch $ip_switch
sleep $espera2

#Captura la petición de contraseña de conexión SSH y la envía
expect {
"word:" {send "$contrasena_switch\r"}
}
sleep $espera1

#Enviamos el comando de obtener la configuración del switch y enviarla al servidor FTP
expect {
"#" {send "copy startup-config ftp:\r"}
}
sleep $espera1

#Esperamos a las dos preguntas de confirmación al conectar con el FTP
#El servidor y el nombre del fichero destino
expect {
"?" {send "$servidor_ftp\r"}
}
sleep $espera1
expect {
"?" {send "$fichero_destino\r"}
}

#Esperamos el tiempo suficiente hasta que concluya el envío FTP y salimos
sleep $espera10