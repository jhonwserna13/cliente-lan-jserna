#!/bin/sh

PORT="${PORT:-10000}"

TARGET="${TARGET_URL:-https://modulo-00-servidor-dmz-jserna.onrender.com}"
TARGET="${TARGET%/}"

mkdir -p /app/web

echo "=========================================="
echo "LABORATORIO DE CIBERSEGURIDAD"
echo "MODULO 03 - ENUMERACION DE RUTAS"
echo "Estudiante: John Serna Hernandez"
echo "=========================================="

echo "<!DOCTYPE html>
<html lang='es'>
<head>
<meta charset='UTF-8'>
<meta name='viewport' content='width=device-width, initial-scale=1'>
<title>Laboratorio - Modulo 03</title>
<style>
body {font-family:Arial;background:#101827;color:#e5e7eb;padding:30px}
main {max-width:900px;margin:auto}
.card {background:#1e293b;padding:22px;border-radius:12px;margin:18px 0}
h1,h2 {color:#38bdf8}
.ok {color:#4ade80;font-weight:bold}
.warning {color:#fbbf24;font-weight:bold}
table {width:100%;border-collapse:collapse}
td,th {padding:12px;border:1px solid #475569;text-align:left}
th {color:#38bdf8}
small {color:#94a3b8}
</style>
</head>
<body>
<main>
<h1>Laboratorio de Ciberseguridad</h1>
<h2>Unidad 3 - Enumeracion de rutas</h2>
<p>Estudiante: <strong>John Serna Hernandez</strong></p>
<div class='card'>
<h2>Estado del laboratorio</h2>
<p class='ok'>SERVICIO ACTIVO</p>
<p>Modulo disponible para pruebas controladas.</p>
</div>
<div class='card'>
<h2>Reconocimiento de rutas</h2>
<p>Servidor objetivo: $TARGET</p>
<table>
<tr><th>Ruta</th><th>Respuesta HTTP</th></tr>" > /app/web/index.html

echo "[INFO] Verificando disponibilidad del servidor DMZ..."

LISTO=0
INTENTO=1

while [ "$INTENTO" -le 8 ]; do

    CODE=$(curl -sS -o /dev/null \
        --connect-timeout 5 \
        --max-time 10 \
        -w "%{http_code}" "$TARGET/" 2>/dev/null || true)

    echo "[INFO] Intento $INTENTO: HTTP ${CODE:-000}"

    if [ "$CODE" = "200" ]; then
        LISTO=1
        break
    fi

    INTENTO=$((INTENTO + 1))
    sleep 10

done

if [ "$LISTO" -eq 1 ]; then

    echo "[INFO] DMZ disponible. Iniciando enumeracion."

    for ruta in /admin /config.php /login /secret /backup.zip /index.html; do

        echo "------------------------------------------"
        echo "[INFO] Analizando ruta: $ruta"

        CODE=$(curl -sS -o /dev/null \
            --connect-timeout 5 \
            --max-time 10 \
            -w "%{http_code}" "$TARGET$ruta" 2>/dev/null || true)

        CODE="${CODE:-000}"

        echo "[RESULTADO] $ruta -> HTTP $CODE"

        printf "<tr><td>%s</td><td>%s</td></tr>\n" \
            "$ruta" "$CODE" >> /app/web/index.html

    done

else

    echo "[ERROR] El servidor DMZ no respondio correctamente."

    echo "<tr><td colspan='2' class='warning'>
    Servidor DMZ no disponible. No fue posible completar la prueba.
    </td></tr>" >> /app/web/index.html

fi

cat >> /app/web/index.html <<'EOF'
</table>
</div>
<div class="card">
<h2>Analisis de seguridad</h2>
<p>La enumeracion de rutas permite identificar recursos
publicados y posibles puntos de exposicion.</p>
<ul>
<li>Proteger las rutas administrativas.</li>
<li>Evitar publicar archivos de configuracion.</li>
<li>Implementar controles de acceso.</li>
<li>Monitorear solicitudes sospechosas.</li>
</ul>
</div>
<p><small>Simulacion educativa controlada.</small></p>
</main>
</body>
</html>
EOF

echo "=========================================="
echo "ENUMERACION DE RUTAS FINALIZADA"
echo "=========================================="

echo "[INFO] Iniciando servidor web..."

exec python3 -m http.server "$PORT" \
    --directory /app/web \
    --bind 0.0.0.0
