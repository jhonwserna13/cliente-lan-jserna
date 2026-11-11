
#!/bin/sh

PORT="${PORT:-10000}"

echo "======================================"
echo "SIMULACION DE CREDENTIAL STUFFING"
echo "Estudiante: John Serna Hernandez"
echo "======================================"

USUARIOS="admin root user docente gestor"

echo "[INFO] Iniciando pruebas con datos ficticios..."

for usuario in $USUARIOS; do
    echo "[ALERTA] Intento de autenticacion simulado para usuario: $usuario"
    echo "[REGISTRO] Evento de seguridad generado."
done

echo "======================================"
echo "ANALISIS DE AUTENTICACION FINALIZADO"
echo "Se registraron 5 eventos simulados."
echo "======================================"

python3 -m http.server "$PORT" --bind 0.0.0.0
