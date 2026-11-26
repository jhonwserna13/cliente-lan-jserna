
#!/bin/sh

PORT="${PORT:-10000}"
HOST="modulo-00-servidor-dmz-jserna.onrender.com"

echo "=========================================="
echo "LABORATORIO DE CIBERSEGURIDAD"
echo "MODULO 02 - ESCANEO DE PUERTOS"
echo "Estudiante: John Serna Hernandez"
echo "=========================================="

echo "[INFO] Iniciando reconocimiento de la DMZ..."
echo "[OBJETIVO] $HOST"

echo "=========================================="
echo "INICIANDO ESCANEO DE PUERTOS"
echo "=========================================="

for port in 21 22 80 443 8080 3306; do
    echo "------------------------------------------"
    echo "[INFO] Analizando puerto $port..."

    if nc -z -w 3 "$HOST" "$port" 2>/dev/null; then
        echo "[ABIERTO] Puerto $port"
    else
        echo "[CERRADO O SIN RESPUESTA] Puerto $port"
    fi
done

echo "=========================================="
echo "ESCANEO DE PUERTOS FINALIZADO"
echo "=========================================="

# Crear página de presentación del laboratorio
mkdir -p /tmp/web

cat > /tmp/web/index.html <<'EOF'
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Laboratorio de Ciberseguridad - Módulo 02</title>

<style>
body {
    font-family: Arial, sans-serif;
    background: #101827;
    color: #e5e7eb;
    margin: 0;
    padding: 30px;
}
main {
    max-width: 850px;
    margin: auto;
}
.card {
    background: #1e293b;
    padding: 25px;
    border-radius: 12px;
    margin: 20px 0;
}
h1, h2 {
    color: #38bdf8;
}
.status {
    color: #4ade80;
    font-size: 26px;
    font-weight: bold;
}
small {
    color: #94a3b8;
}
</style>
</head>

<body>
<main>

<h1>Laboratorio de Ciberseguridad</h1>

<h2>Unidad 2 - Escaneo de puertos</h2>

<p>Estudiante: <strong>John Serna Hernandez</strong></p>

<div class="card">
<h2>Estado del laboratorio</h2>
<p class="status">SERVICIO ACTIVO</p>
<p>Servidor de demostración disponible.</p>
</div>

<div class="card">
<h2>Reconocimiento de red</h2>
<p>El módulo de escaneo de puertos se ejecutó correctamente.</p>
<p>Objetivo analizado: servidor DMZ del laboratorio.</p>
<p>Puertos examinados: 21, 22, 80, 443, 8080 y 3306.</p>
</div>

<div class="card">
<h2>Análisis de seguridad</h2>
<p>El escaneo de puertos permite identificar servicios
accesibles y posibles puntos de exposición.</p>

<p><strong>Medidas preventivas:</strong></p>
<ul>
<li>Cerrar los puertos que no se utilicen.</li>
<li>Configurar reglas de firewall.</li>
<li>Monitorear los servicios expuestos.</li>
<li>Realizar auditorías periódicas.</li>
</ul>
</div>

<p><small>Laboratorio educativo de ciberseguridad.</small></p>

</main>
</body>
</html>
EOF

echo "[INFO] Iniciando servidor web de demostración..."

python3 -m http.server "$PORT" \
    --bind 0.0.0.0 \
    --directory /tmp/web

