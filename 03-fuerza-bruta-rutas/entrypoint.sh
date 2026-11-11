
#!/bin/sh

PORT="${PORT:-10000}"

echo "======================================"
echo "LABORATORIO: ENUMERACION DE RUTAS"
echo "Estudiante: John Serna Hernandez"
echo "======================================"

mkdir -p /app/web
echo "Pagina principal del laboratorio" > /app/web/index.html
echo "Panel administrativo de demostracion" > /app/web/admin.html
echo "Pagina de inicio de sesion de prueba" > /app/web/login.html

python3 -m http.server "$PORT" --directory /app/web --bind 0.0.0.0 &
SERVER_PID=$!

sleep 3

echo "Iniciando pruebas de rutas locales..."

for ruta in index.html admin.html login.html backup.zip config.php; do
    CODE=$(wget -q -O /dev/null -S "http://127.0.0.1:$PORT/$ruta" 2>&1 | awk '$1 ~ /^HTTP\// {code=$2} END {print code}')
    echo "Ruta: /$ruta -> HTTP $CODE"
done

echo "======================================"
echo "ENUMERACION FINALIZADA"
echo "======================================"

wait "$SERVER_PID"
