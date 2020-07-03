# Este script actualiza el Security Group indicado
# eliminando reglas existentes y añadiendo una nueva
# Para la IP pública del usuario que ejecuta el script

#Requisitos

# Tener creadas las credenciales de AWS
# Tener instalado el AWS CLI
# Si las credenciales tienen un nombre diferente en los ficheros credentials o config
# cambiar esta variable, en caso contrario dejarlo en default
profile="default"

#!/bin/bash

#Variables dependientes de vuestro entorno
security_group_id="sg-0d0faee6b039a6cd9"
port=22
# Obtenemos la IP Publica
myip=$(curl ifconfig.me/ip)

echo "Actualizando el SG $security_group_id con la IP $myip por el puerto $port"

updatecommand="aws ec2 authorize-security-group-ingress --group-id $security_group_id --ip-permissions IpProtocol=tcp,FromPort=$port,ToPort=$port,IpRanges=[{CidrIp=$myip/32}] --profile $profile"

update=$($updatecommand)
