
#!/bin/sh

PORT="${PORT:-10000}"
LOG_FILE="/tmp/credential_stuffing.log"

echo "=========================================="
echo "LABORATORIO: CREDENTIAL STUFFING"
echo "Estudiante: John Serna Hernandez"
echo "=========================================="

echo "[INFO] Iniciando simulacion defensiva..."
echo "[INFO] Utilizando usuarios y eventos ficticios."

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
        registrar_evento "[ALERTA] Intento de autenticacion fallido."
    fi

    echo "------------------------------------------"
}

echo "[INFO] Ejecutando pruebas de autenticacion..."

simular_intento "admin" "origen-demo-01" "FALLIDO"
simular_intento "root" "origen-demo-01" "FALLIDO"
simular_intento "usuario" "origen-demo-01" "FALLIDO"
simular_intento "docente" "origen-demo-02" "FALLIDO"
simular_intento "gestor" "origen-demo-02" "FALLIDO"

echo "=========================================="
echo "ANALISIS DE SEGURIDAD"

if [ "$ALERTAS" -ge 3 ]; then
    echo "[DETECCION] Actividad sospechosa identificada."
    echo "[ALERTA] Se detectaron multiples fallos."
fi

echo "[RESUMEN] Intentos simulados: $INTENTOS"
echo "[RESUMEN] Fallos detectados: $ALERTAS"
echo "[REGISTRO] Eventos guardados en $LOG_FILE"
echo "[ANALISIS] No se realizaron conexiones a cuentas reales."
echo "=========================================="
echo "SIMULACION FINALIZADA"

mkdir -p /app

cat > /app/index.html <<'HTML'
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Laboratorio Credential Stuffing</title>
</head>
<body>
<h1>Laboratorio Credential Stuffing Activo</h1>
<h2>Estudiante: John Serna Hernandez</h2>
<p>Modulo 06 - Seguridad en redes y aplicaciones web</p>
<p>Simulacion defensiva de autenticacion y auditoria.</p>
</body>
</html>
HTML

python3 -m http.server "$PORT" --bind 0.0.0.0 --directory /app
