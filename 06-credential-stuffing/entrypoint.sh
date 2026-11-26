#!/bin/sh

PORT="${PORT:-10000}"
LOG_FILE="/tmp/credential_stuffing.log"

echo "=========================================="
echo "LABORATORIO: CREDENTIAL STUFFING"
echo "Estudiante: John Serna Hernandez"
echo "=========================================="

touch "$LOG_FILE"

INTENTOS=0
ALERTAS=0

registrar_evento() {
    echo "$1" | tee -a "$LOG_FILE"
}

simular_intento() {
    USUARIO="$1"
    ORIGEN="$2"
    RESULTADO="$3"

    INTENTOS=$((INTENTOS + 1))

    registrar_evento "[AUDITORIA] Intento: $INTENTOS"
    registrar_evento "[USUARIO] $USUARIO"
    registrar_evento "[ORIGEN SIMULADO] $ORIGEN"
    registrar_evento "[RESULTADO] $RESULTADO"

    if [ "$RESULTADO" = "FALLIDO" ]; then
        ALERTAS=$((ALERTAS + 1))
        registrar_evento "[ALERTA] Autenticacion fallida."
    fi
}

echo "[INFO] Ejecutando pruebas defensivas..."

simular_intento "admin" "origen-demo-01" "FALLIDO"
simular_intento "root" "origen-demo-01" "FALLIDO"
simular_intento "usuario" "origen-demo-01" "FALLIDO"
simular_intento "docente" "origen-demo-02" "FALLIDO"
simular_intento "gestor" "origen-demo-02" "FALLIDO"

echo "[RESUMEN] Intentos: $INTENTOS"
echo "[RESUMEN] Fallos: $ALERTAS"

mkdir -p /app

cat > /app/index.html <<'HTML'
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Laboratorio de Ciberseguridad - Unidad 6</title>

<style>
* {
    box-sizing: border-box;
}

body {
    margin: 0;
    padding: 35px 18px;
    background: #101827;
    color: #f1f5f9;
    font-family: Arial, sans-serif;
}

.container {
    max-width: 1000px;
    margin: auto;
}

h1, h2 {
    color: #38bdf8;
}

h1 {
    font-size: 34px;
    margin-bottom: 10px;
}

.subtitle {
    color: #38bdf8;
    font-size: 23px;
    font-weight: bold;
}

.student {
    margin: 18px 0 25px;
}

.card {
    background: #202d42;
    border-radius: 14px;
    padding: 25px;
    margin-bottom: 22px;
    border: 1px solid #293c55;
}

.card h2 {
    margin-top: 0;
    font-size: 23px;
}

.status {
    color: #4ade80;
    font-weight: bold;
    font-size: 18px;
}

.stats {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 18px;
}

.stat {
    background: #172438;
    padding: 22px;
    border-radius: 12px;
    text-align: center;
}

.number {
    font-size: 38px;
    font-weight: bold;
    color: #38bdf8;
}

.danger {
    color: #f87171;
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 15px;
}

th, td {
    border: 1px solid #40516a;
    padding: 14px;
    text-align: left;
}

th {
    color: #38bdf8;
    background: #172438;
}

.failed {
    color: #f87171;
    font-weight: bold;
}

.warning {
    color: #fbbf24;
    font-weight: bold;
}

.success {
    color: #4ade80;
    font-weight: bold;
}

.footer {
    text-align: center;
    color: #94a3b8;
    padding: 20px;
    font-size: 13px;
}

@media (max-width: 600px) {
    .stats {
        grid-template-columns: 1fr;
    }

    h1 {
        font-size: 27px;
    }

    .card {
        padding: 17px;
        overflow-x: auto;
    }
}
</style>
</head>

<body>
<div class="container">

<header>
<h1>Laboratorio de Ciberseguridad</h1>
<div class="subtitle">Unidad 6 - Credential Stuffing</div>
<p class="student">
Estudiante: <strong>John Serna Hernandez</strong>
</p>
</header>

<section class="card">
<h2>Estado del laboratorio</h2>
<p class="status">● SERVICIO ACTIVO</p>
<p>Entorno disponible para pruebas controladas de seguridad.</p>
</section>

<section class="card">
<h2>Resumen de actividad</h2>

<div class="stats">
<div class="stat">
<div class="number">05</div>
<p>Intentos simulados</p>
</div>

<div class="stat">
<div class="number danger">05</div>
<p>Fallos detectados</p>
</div>
</div>
</section>

<section class="card">
<h2>Simulación de autenticación</h2>
<p>Registro de eventos con usuarios y orígenes ficticios.</p>

<table>
<thead>
<tr>
<th>Usuario</th>
<th>Origen simulado</th>
<th>Resultado</th>
</tr>
</thead>

<tbody>
<tr>
<td>admin</td>
<td>origen-demo-01</td>
<td class="failed">● FALLIDO</td>
</tr>
<tr>
<td>root</td>
<td>origen-demo-01</td>
<td class="failed">● FALLIDO</td>
</tr>
<tr>
<td>usuario</td>
<td>origen-demo-01</td>
<td class="failed">● FALLIDO</td>
</tr>
<tr>
<td>docente</td>
<td>origen-demo-02</td>
<td class="failed">● FALLIDO</td>
</tr>
<tr>
<td>gestor</td>
<td>origen-demo-02</td>
<td class="failed">● FALLIDO</td>
</tr>
</tbody>
</table>
</section>

<section class="card">
<h2>Análisis de seguridad</h2>
<p class="warning">⚠ ACTIVIDAD SOSPECHOSA IDENTIFICADA</p>
<p>Se detectaron múltiples intentos de autenticación fallidos.</p>
<p class="success">
✓ Se generaron alertas de seguridad.
</p>
<p class="success">
✓ Los eventos fueron registrados para auditoría.
</p>
</section>

<section class="card">
<h2>Medidas de protección</h2>
<ul>
<li>Implementar autenticación multifactor.</li>
<li>Establecer límites de intentos de acceso.</li>
<li>Monitorear patrones de autenticación.</li>
<li>Bloquear temporalmente accesos sospechosos.</li>
<li>Utilizar contraseñas seguras y únicas.</li>
</ul>
</section>

<section class="card">
<h2>Conclusión</h2>
<p>
La simulación permitió identificar cómo múltiples intentos
de autenticación fallidos pueden representar un riesgo
para la seguridad de las cuentas y aplicaciones web.
</p>
<p class="success">
SIMULACIÓN COMPLETADA
</p>
</section>

<footer class="footer">
Laboratorio académico de ciberseguridad |
John Serna Hernandez | Unidad 6
</footer>

</div>
</body>
</html>
HTML

echo "[OK] Panel visual generado."
echo "[OK] Simulacion defensiva finalizada."
echo "[ANALISIS] No se utilizaron cuentas reales."

python3 -m http.server "$PORT" --bind 0.0.0.0 --directory /app

