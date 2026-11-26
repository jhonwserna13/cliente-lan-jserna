
#!/bin/sh

PORT="${PORT:-10000}"

echo "=========================================="
echo "LABORATORIO DE CIBERSEGURIDAD"
echo "MODULO 05 - CADENA DE SUMINISTRO"
echo "Estudiante: John Serna Hernandez"
echo "=========================================="

echo "[INFO] Verificando integridad del componente..."

if [ -f "/app/dependency_demo.sh" ]; then
    echo "[ALERTA] Componente de demostracion detectado."
    sh /app/dependency_demo.sh
else
    echo "[ERROR] No se encontro el componente."
fi

mkdir -p /app/web

cat > /app/web/index.html <<'EOF'
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Modulo 05 - Cadena de Suministro</title>
<style>
body {
    font-family: Arial, sans-serif;
    background: #101827;
    color: white;
    margin: 0;
    padding: 40px 20px;
}
main {
    max-width: 850px;
    margin: auto;
}
section {
    background: #202d42;
    padding: 25px;
    margin: 20px 0;
    border-radius: 12px;
}
h1, h2 { color: #38bdf8; }
.ok { color: #4ade80; font-weight: bold; }
table {
    width: 100%;
    border-collapse: collapse;
}
td, th {
    padding: 13px;
    border: 1px solid #475569;
    text-align: left;
}
</style>
</head>
<body>
<main>
<h1>Laboratorio de Ciberseguridad</h1>
<h2>Unidad 5 - Cadena de suministro</h2>
<p>Estudiante: <strong>John Serna Hernandez</strong></p>

<section>
<h2>Estado del laboratorio</h2>
<p class="ok">SERVICIO ACTIVO</p>
<p>Entorno disponible para pruebas controladas.</p>
</section>

<section>
<h2>Simulacion de integridad</h2>
<table>
<tr><th>Elemento</th><th>Resultado</th></tr>
<tr><td>Componente de prueba</td><td>Detectado</td></tr>
<tr><td>Verificacion</td><td>Completada</td></tr>
<tr><td>Ejecucion</td><td>Demostracion local</td></tr>
<tr><td>Estado</td><td class="ok">SIMULACION COMPLETADA</td></tr>
</table>
</section>

<section>
<h2>Analisis de seguridad</h2>
<p>La seguridad de la cadena de suministro busca garantizar
la integridad de los componentes y dependencias utilizados
en el desarrollo de software.</p>
<ul>
<li>Verificar el origen de las dependencias.</li>
<li>Controlar los componentes incorporados.</li>
<li>Analizar cambios no autorizados.</li>
<li>Realizar auditorias de integridad.</li>
</ul>
</section>
</main>
</body>
</html>
EOF

echo "[OK] Panel web generado."
echo "[INFO] Iniciando servidor web..."

python3 -m http.server "$PORT" \
    --bind 0.0.0.0 \
    --directory /app/web &
SERVER_PID=$!

wait "$SERVER_PID"

