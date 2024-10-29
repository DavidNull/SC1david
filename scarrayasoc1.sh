#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Uso: $0 color1 color2 color3 ..."
    exit 1
fi

echo "Número de colores introducidos: $#"

declare -A colores_hex

for color in "$@"; do
    read -p "Introduce el valor hexadecimal para el color $color: " hex
    colores_hex[$color]=$hex
done

echo "Colores disponibles para selección:"
for color in "${!colores_hex[@]}"; do
    echo "- $color"
done

read -p "Selecciona el color de fondo de la página web: " fondo
read -p "Selecciona el color del párrafo/div: " parrafo
read -p "Selecciona el color del texto: " texto

ip_address=$(ifconfig | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}' | head -n 1)

cat << EOF > index_tunombre.html
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Colores de Página Web</title>
    <style>
        body { background-color: ${colores_hex[$fondo]}; color: ${colores_hex[$texto]}; }
        p { color: ${colores_hex[$parrafo]}; }
    </style>
</head>
<body>
    <p>Esta es una página generada automáticamente con los siguientes colores:</p>
    <ul>
        <li>Color de fondo: $fondo (${colores_hex[$fondo]})</li>
        <li>Color del párrafo: $parrafo (${colores_hex[$parrafo]})</li>
        <li>Color del texto: $texto (${colores_hex[$texto]})</li>
    </ul>
    <p>Dirección IP de la máquina: $ip_address</p>
</body>
</html>
EOF

echo "Página web generada como index_tunombre.html con la configuración especificada."

