
#!/bin/sh

PORT="${PORT:-10000}"
HOST="modulo-00-servidor-dmz-jserna.onrender.com"

echo "=========================================="
echo "LABORATORIO: ESCANEO DE PUERTOS"
echo "Estudiante: John Serna Hernandez"
echo "Unidad 2 - Seguridad en redes y aplicaciones web"
echo "=========================================="

echo "Iniciando reconocimiento de la DMZ..."
echo "Objetivo: $HOST"

echo "Analizando puertos comunes..."

for port in 21 22 80 443 8080 3306; do
    echo "------------------------------------------"
    echo "Analizando puerto $port..."

    nc -zv -w 2 "$HOST" "$port" 2>&1

done

echo "=========================================="
echo "ESCANEO DE PUERTOS FINALIZADO"
echo "=========================================="

echo "Iniciando servidor de demostracion..."

python3 -m http.server "$PORT" --bind 0.0.0.0

