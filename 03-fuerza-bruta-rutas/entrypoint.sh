#!/bin/sh

PORT="${PORT:-10000}"

TARGET="${TARGET_URL:-https://modulo-00-servidor-dmz-jserna.onrender.com}"

RUTAS="/admin /config.php /login /secret /backup.zip /index.html"

echo "=========================================="
echo "LABORATORIO DE CIBERSEGURIDAD"
echo "MODULO 03 - ENUMERACION DE RUTAS"
echo "Estudiante: John Serna Hernandez"
echo "=========================================="

echo "[INFO] Iniciando enumeracion de rutas..."
echo "[OBJETIVO DMZ] $TARGET"
echo "=========================================="

for ruta in $RUTAS; do

    echo "------------------------------------------"
    echo "[INFO] Analizando ruta: $ruta"

    CODE=$(curl -sS -o /dev/null \
        --connect-timeout 5 \
        --max-time 10 \
        -w "%{http_code}" \
        "$TARGET$ruta" 2>/dev/null || true)

    if [ -z "$CODE" ]; then
        CODE="000"
    fi

    echo "[RESULTADO] Ruta: $ruta -> HTTP $CODE"

done

echo "=========================================="
echo "ENUMERACION DE RUTAS FINALIZADA"
echo "=========================================="

echo "[INFO] Iniciando servidor web de demostracion..."

exec python3 -m http.server "$PORT" --bind 0.0.0.0

