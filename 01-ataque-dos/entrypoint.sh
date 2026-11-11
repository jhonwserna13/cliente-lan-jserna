
#!/bin/sh

PORT="${PORT:-10000}"

echo "=========================================="
echo "SIMULACION CONTROLADA DE TRAFICO HTTP"
echo "Laboratorio de John Serna Hernandez"
echo "=========================================="

echo "Iniciando servidor de demostracion..."

python3 -m http.server "$PORT" --bind 0.0.0.0 &
SERVER_PID=$!

sleep 3

echo "Generando cinco solicitudes locales de prueba..."

for i in 1 2 3 4 5; do
    echo "Solicitud de prueba numero: $i"
    wget -q -O /dev/null http://127.0.0.1:"$PORT"/
    sleep 1
done

echo "=========================================="
echo "SIMULACION FINALIZADA"
echo "Servidor activo para monitoreo"
echo "=========================================="

wait "$SERVER_PID"
