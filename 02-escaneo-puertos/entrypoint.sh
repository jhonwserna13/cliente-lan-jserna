
#!/bin/sh

PORT="${PORT:-10000}"

echo "======================================"
echo "LABORATORIO: ESCANEO DE PUERTOS"
echo "Estudiante: John Serna Hernandez"
echo "======================================"

echo "Iniciando servidor de demostracion..."

python3 -m http.server "$PORT" --bind 0.0.0.0 &
SERVER_PID=$!

sleep 3

echo "Analizando puertos locales de demostracion..."

for port in 21 22 80 443 8080 10000; do
    if nc -z -w 2 127.0.0.1 "$port" 2>/dev/null; then
        echo "[ABIERTO] Puerto $port"
    else
        echo "[CERRADO] Puerto $port"
    fi
done

echo "======================================"
echo "RECONOCIMIENTO FINALIZADO"
echo "======================================"

wait "$SERVER_PID"
