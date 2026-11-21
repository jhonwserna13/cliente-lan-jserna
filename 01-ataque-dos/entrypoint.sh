#!/bin/sh

PORT="${PORT:-10000}"
TARGET_URL="${TARGET_URL:-https://modulo-00-servidor-dmz-jserna.onrender.com}"

echo "=========================================="
echo "LABORATORIO: SIMULACION CONTROLADA DOS"
echo "Estudiante: John Serna Hernandez"
echo "Unidad 2 - Seguridad en redes y aplicaciones web"
echo "=========================================="

echo "[INFO] Iniciando servidor de monitoreo..."

mkdir -p /tmp/web
cat > /tmp/web/index.html <<'EOF'
<!DOCTYPE html>
<html lang="es">
<head><meta charset="UTF-8"><title>Laboratorio DoS</title></head>
<body>
<h1>Laboratorio de Ciberseguridad</h1>
<p>Estudiante: John Serna Hernandez</p>
<p>Modulo 01 - Simulacion controlada de trafico HTTP.</p>
<p>Servidor de monitoreo activo.</p>
</body>
</html>
EOF

python3 -m http.server "$PORT" --bind 0.0.0.0 --directory /tmp/web &
SERVER_PID=$!

sleep 3

echo "[INFO] Servidor de monitoreo activo."
echo "[INFO] Objetivo DMZ: $TARGET_URL"
echo "[INFO] Iniciando cinco solicitudes de prueba controladas."

for i in 1 2 3 4 5; do
    echo "------------------------------------------"
    echo "[SOLICITUD $i] Enviando peticion HTTP al servidor DMZ."

    if wget -q -O /dev/null "$TARGET_URL"; then
        echo "[EXITO] Respuesta recibida correctamente."
    else
        echo "[ERROR] No se pudo conectar con el servidor DMZ."
    fi

    sleep 2
done

echo "=========================================="
echo "ANALISIS DE TRAFICO FINALIZADO"
echo "Total de solicitudes programadas: 5"
echo "SIMULACION CONTROLADA COMPLETADA"
echo "No se ejecuto una denegacion de servicio real."
echo "=========================================="

wait "$SERVER_PID"

