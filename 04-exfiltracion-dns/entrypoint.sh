
#!/bin/sh

PORT="${PORT:-10000}"

echo "=========================================="
echo "SIMULACION DE EXFILTRACION DNS"
echo "Estudiante: John Serna Hernandez"
echo "=========================================="

DATO_FICTICIO="dato_demo_laboratorio"
DATO_CODIFICADO=$(printf '%s' "$DATO_FICTICIO" | base64 | tr -d '\n')

echo "[INFO] Dato ficticio: $DATO_FICTICIO"
echo "[INFO] Dato codificado: $DATO_CODIFICADO"
echo "[ALERTA] Se detecto un payload codificado."
echo "[SIMULACION] Consulta DNS registrada localmente."
echo "[ANALISIS] No se envio informacion a dominios externos."

python3 -m http.server "$PORT" --bind 0.0.0.0 &
SERVER_PID=$!

echo "=========================================="
echo "SIMULACION DNS FINALIZADA"
echo "Servicio disponible para monitoreo"
echo "=========================================="

wait "$SERVER_PID"
