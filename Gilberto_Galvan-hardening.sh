#!/bin/bash

# Es recomendado estar logeados como root
# Hecho por Gilberto Eduardo Galvan Garcia 1958955

#Verificamos si es Ubuntu, Centos u otro OS (1)
if cat /var/log/syslog > /dev/null 2>&1; then
        echo "Es Ubuntu"

        #Instalamos Antivirus (2)
        if clamscan --version > /dev/null 2>&1; then
		echo "El Antivirus Clamav ya esta Instalado:Desinstalando Clamav"
		sudo /etc/init.d/clamav-freshclam stop
		sudo apt remove -y clamav > /dev/null 2>&1
		echo "Instalando Clamav"
		sudo apt install -y clamav > /dev/null 2>&1
	else
		sudo apt install -y clamav > /dev/null 2>&1
		 
	fi
	sudo /etc/init.d/clamav-freshclam start
	#Verificamos que se instalo el Antivirus Clamav
        if clamscan --version > /dev/null 2>&1; then
		echo "Antivirus Clamav Instalado"
	fi
	
        #Actualizamos paquetes (4)                              
        echo "Actualizando Paquetes (Puede Tardar un Poco)..."
        sudo apt-get update > /dev/null 2>&1
        sudo apt-get upgrade > /dev/null 2>&1
        echo "Paquetes Actualizados"

#Verificamos si es Ubuntu, Centos u otro OS (1)
elif cat /var/log/messages > /dev/null 2>&1; then
        echo "Es Centos"

        #Instalamos Antiviurs (2)
	if clamscan --version > /dev/null 2>&1; then
                echo "El Antivirus Clamav ya esta Instalado:Desinstalando Clamav"
                sudo yum remove -y clamav > /dev/null 2>&1
                echo "Instalando Clamav"
                sudo yum install -y clamav > /dev/null 2>&1
        else
                sudo yum install -y clamav > /dev/null 2>&1

        fi

	#Verificamos que se instalo el Antivirus Clamav
	if clamscan --version > /dev/null 2>&1; then
        	echo "Antivirus Clamav Instalado"
	fi

	#Instalamos Repositorio EPEL (3) 
        echo "Instalando Repositorio EPEL..."
        sudo yum install -y epel-release > /dev/null 2>&1
        sudo yum repolist > /dev/null 2>&1
        echo "Repositorio EPEL Instalado"

        #Actualizamos paquetes (4)                              
        echo "Actualizando Paquetes..."
        sudo yum update -y > /dev/null 2>&1
        sudo yum upgrade -y > /dev/null 2>&1
        echo "Paquetes Actualizados"


else
        echo "Es Otro Sistema Operativo"
fi
