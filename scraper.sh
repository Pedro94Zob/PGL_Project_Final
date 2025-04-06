#!/bin/bash

# Clé API Alpha Vantage
API_KEY="710GETY1YDRJ6GQH"

# Choix du symbole boursier (ici TSLA)
SYMBOL="TSLA"

# URL de l'API pour récupérer les données Global Quote
URL="https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=${SYMBOL}&apikey=${API_KEY}"

# Appel de l'API et récupération de la réponse JSON
response=$(curl -s "$URL")

# Extraction du prix actuel (champ "05. price")
price=$(echo "$response" | grep -oP '"05\. price":\s*"\K[^"]+')

# Extraction du dernier jour de trading (champ "07. latest trading day")
trading_day=$(echo "$response" | grep -oP '"07\. latest trading day":\s*"\K[^"]+')

# Affiche les infos pour vérification
echo "Symbole : ${SYMBOL}"
echo "Prix actuel : ${price}"
echo "Dernier jour de trading : ${trading_day}"

# Enregistrer la date courante et le prix dans data.csv
current_time=$(date "+%Y-%m-%d %H:%M:%S")
echo "${current_time},${price}" >> data.csv
