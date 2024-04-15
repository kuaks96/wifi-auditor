Wi-FI AUDITOR

PROGRAM: CRACK0XFF

Este script de Bash está diseñado para facilitar la configuración de una interfaz de red inalámbrica en modo monitor y realizar algunas operaciones básicas de auditoría de seguridad en redes Wi-Fi. Es importante destacar que este script debe ser utilizado únicamente con fines educativos y legales. No se debe utilizar para acceder a redes Wi-Fi sin permiso.
Requisitos

    Sistema operativo basado en Linux.
    Permisos de superusuario (root) para ejecutar algunas operaciones del script.
    Herramientas instaladas: aircrack-ng y macchanger.

Uso

    Descarga el script en tu sistema.
    Abre una terminal y navega hasta el directorio donde se encuentra el script.
    Ejecuta el script con permisos de superusuario utilizando el siguiente comando:

bash

sudo ./crack.sh

    Sigue las instrucciones en pantalla para realizar las siguientes acciones:
        Cambiar la dirección MAC de la interfaz de red.
        Iniciar el modo monitor en la interfaz de red.
        Ejecutar el programa airodump-ng para escanear las redes Wi-Fi cercanas.
        Realizar ataques de desautenticación (aireplay-ng) a una red Wi-Fi específica.



![Panel de Menu ](https://raw.githubusercontent.com/kuaks96/wifi-auditor/main/crack.png)





# Ejecucion del programa

[*] Comprobando programas necesarios....

[*] Herramientas aircrack-ng... (V)

[*] Herramientas macchanger... (V)

Ingrese el nombre de la tarjeta de red: (ID)

Cambiando la direccion MAC de la tarjeta de red (ID).....

Current MAC:   FF:FF:FF:FF:FF:FF (unknown)
Permanent MAC: FF:FF:FF:FF:FF:FF (unknown)

Direccion MAC cambiada.


Iniciando airmon-ng en la tarjeta de red (ID)....


 BSSID              PWR  Beacons    #Data, #/s  CH   MB   ENC CIPHER  AUTH ESSID
 FF:FF:FF:FF:FF:FF -73        1        0    0   3  270   WPA2 CCMP   PSK  RED

# Aca se van a ver las redes detectadas

# Siempre con Ctrl_C se avanza a la siguiente funcion declarada en el programa

Quitting...

Airodump-ng se ha cerrado....

Ingrese el canal: 1
Ingrese el BSSID: FF:FF:FF:FF:FF:FF
Ingrese el nombre del archivo de salida: file
00:00:00  Created capture file "file-01.cap".

BSSID              PWR RXQ  Beacons    #Data, #/s  CH   MB   ENC CIPHER  AUTH ESSID

 FF:FF:FF:FF:FF:FF  0       10        0    0   1  405   WPA2 CCMP   PSK       RED

 SSID              STATION            PWR   Rate    Lost    Frames  Notes  Probes

Quitting...


Ingrese la direccion MAC de la red: FF:FF:FF:FF:FF:FF

Ingrese la direccion MAC del cliente:  

02:27:52  Waiting for beacon frame (BSSID:  FF:FF:FF:FF:FF:FF ) on channel 1


02:27:52  Sending 64 directed DeAuth (code 7). STMAC: [ FF:FF:FF:FF:FF:FF ] [127|127 ACKs]

02:27:53  Sending 64 directed DeAuth (code 7). STMAC: [ FF:FF:FF:FF:FF:FF ] [117|117 ACKs]

02:27:54  Sending 64 directed DeAuth (code 7). STMAC: [ FF:FF:FF:FF:FF:FF ] [136|136 ACKs]

¿Desea seguir con la misma direccion MAC? (1 = yes, 2 = no): 1

02:27:59  Waiting for beacon frame (BSSID: FF:FF:FF:FF:FF:FF) on channel 1

02:28:00  Sending 64 directed DeAuth (code 7). STMAC: [ FF:FF:FF:FF:FF:FF ] [125|125 ACKs]

02:28:01  Sending 64 directed DeAuth (code 7). STMAC: [ FF:FF:FF:FF:FF:FF ] [126|126 ACKs]

02:28:01  Sending 64 directed DeAuth (code 7). STMAC: [ FF:FF:FF:FF:FF:FF ] [111|111 ACKs]


02:28:02  Sending 64 directed DeAuth (code 7). STMAC: [ FF:FF:FF:FF:FF:FF ] [147|147 ACKs]




Importante

Este script se proporciona únicamente con fines educativos y de aprendizaje. El uso de este script para acceder a redes Wi-Fi sin autorización es ilegal y está estrictamente prohibido. El autor no se hace responsable del mal uso de este script.


Finalidad

Sumamente didactico, ademas no tuve problemas con la interfaz (mon), con un iwconfig, la placa de red observer que estaba en modo monitor.
Esto es para sistemas de ArchLinux, manjaro, con las modificaciones correctas pueden ejecutarse en  cualquier distro de linux.


Tambien se agregaran nuevas actualizaciones utilizando herramientas como aircrack-ng, john the ripper, etc...


# Importante con Ctrl_C se avanza a la siguiente funcion. Solo para aclarar

AUTOR: Almy
