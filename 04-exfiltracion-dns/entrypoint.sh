
#!/bin/sh

PORT="${PORT:-10000}"

echo "=========================================="
echo "LABORATORIO DE CIBERSEGURIDAD"
echo "MODULO 04 - SIMULACION DNS"
echo "Estudiante: John Serna Hernandez"
echo "=========================================="

DATO_FICTICIO="dato_demo_laboratorio"
DATO_CODIFICADO=$(printf '%s' "$DATO_FICTICIO" | base64 | tr -d '\n')
DOMINIO_SIMULADO="${DATO_CODIFICADO}.laboratorio.invalid"

echo "[INFO] Preparando simulacion DNS..."
echo "[INFO] Dato ficticio codificado correctamente."
echo "[DNS] Dominio reservado: $DOMINIO_SIMULADO"

mkdir -p /app/web

cat > /app/web/index.html <<EOF
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Modulo 04 - Laboratorio DNS</title>
<style>
body {
  margin: 0;
  padding: 30px;
  font-family: Arial, sans-serif;
  background: #0f172a;
  color: #f1f5f9;
}
main { max-width: 900px; margin: auto; }
.card {
  background: #1e293b;
  padding: 25px;
  margin: 20px 0;
  border-radius: 12px;
}
h1, h2 { color: #38bdf8; }
.ok { color: #4ade80; font-weight: bold; }
table { width: 100%; border-collapse: collapse; }
td, th {
  padding: 13px;
  border: 1px solid #475569;
  text-align: left;
  overflow-wrap: anywhere;
}
th { color: #38bdf8; }
</style>
</head>
<body>
<main>
<h1>Laboratorio de Ciberseguridad</h1>
<h2>Unidad 4 - Simulacion de Exfiltracion DNS</h2>
<p>Estudiante: <strong>John Serna Hernandez</strong></p>

<div class="card">
<h2>Estado del laboratorio</h2>
<p class="ok">SERVICIO ACTIVO</p>
<p>Servidor disponible para pruebas controladas.</p>
</div>

<div class="card">
<h2>Simulacion DNS</h2>
<table>
<tr><th>Elemento</th><th>Resultado</th></tr>
<tr><td>Dato de prueba</td><td>Dato ficticio de laboratorio</td></tr>
<tr><td>Codificacion</td><td>Base64</td></tr>
<tr><td>Payload</td><td>$DATO_CODIFICADO</td></tr>
<tr><td>Dominio simulado</td><td>$DOMINIO_SIMULADO</td></tr>
<tr><td>Estado</td><td class="ok">SIMULACION COMPLETADA</td></tr>
<tr><td>Transmision externa</td><td>NO</td></tr>
</table>
</div>

<div class="card">
<h2>Analisis de seguridad</h2>
<p>La exfiltracion DNS puede utilizar consultas de nombres de dominio para intentar extraer informacion.</p>
<p>Esta practica utiliza datos ficticios y un dominio reservado para simulacion.</p>
<p class="ok">No se transmitio informacion a servidores externos.</p>
</div>
</main>
</body>
</html>
EOF

echo "[OK] Panel web generado correctamente."
echo "[OK] Simulacion registrada localmente."

python3 -m http.server "$PORT" --directory /app/web --bind 0.0.0.0 &
SERVER_PID=$!

wait "$SERVER_PID"

