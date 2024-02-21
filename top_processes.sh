#!/bin/bash

##########################################################
# Script: top_processes.sh
# Descripción: Este script lista los 10 procesos con mayor consumo de memoria, los 10 procesos con mayor consumo de CPU y los 10 procesos con mayor E/S a disco.
# Autor: Jose Garagorry <jj@softraincorp.com>
##########################################################

# Listar los 10 procesos con mayor consumo de memoria
echo -e "\e[1;34mTop 10 procesos con mayor consumo de memoria:\e[0m"
ps -eo pid,comm,%mem --sort=-%mem | head -n 11

# Calcular el total de consumo de memoria de los 10 procesos principales
total_mem=$(ps -eo %mem --sort=-%mem | awk 'NR<=11 {sum += $1} END {print sum}')
echo -e "\e[1;34mTotal de consumo de memoria de los 10 procesos principales:\e[0m $total_mem%"

# Listar los 10 procesos con mayor consumo de CPU
echo -e "\n\e[1;34mTop 10 procesos con mayor consumo de CPU:\e[0m"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 11

# Listar los 10 procesos con mayor E/S a disco
echo -e "\n\e[1;34mTop 10 procesos con mayor E/S a disco:\e[0m"
iotop_output=$(iotop -bqqto --iter=1)
echo "$iotop_output" | head -n 11

# Calcular el total de E/S a disco de los 10 procesos principales
total_io=$(echo "$iotop_output" | awk 'NR>6 {sum += $4} END {print sum}')
echo -e "\e[1;34mTotal de E/S a disco de los 10 procesos principales:\e[0m $total_io"

