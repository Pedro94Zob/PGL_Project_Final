#!/bin/bash

# Lire le fichier data.csv et extraire la première et la dernière ligne pour avoir le prix d'ouverture et de clôture
opening=$(head -n 1 data.csv | cut -d',' -f2)
closing=$(tail -n 1 data.csv | cut -d',' -f2)

# Calculer une "volatilité" approximative (écart entre ouverture et clôture)
volatilite=$(echo "$closing - $opening" | bc -l)

current_date=$(date "+%Y-%m-%d")
echo "Rapport du ${current_date}" > report.txt
echo "Prix d'ouverture : ${opening}" >> report.txt
echo "Prix de clôture : ${closing}" >> report.txt
echo "Volatilité (approximative) : ${volatilite}" >> report.txt
