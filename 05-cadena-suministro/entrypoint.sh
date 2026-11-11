
#!/bin/sh

PORT="${PORT:-10000}"

echo "======================================"
echo "SIMULACION DE CADENA DE SUMINISTRO"
echo "Estudiante: John Serna Hernandez"
echo "======================================"

if [ -f "/app/dependency_demo.sh" ]; then
    echo "[ALERTA] Se detecto un componente no verificado."
    sh /app/dependency_demo.sh
else
    echo "[OK] No se encontraron componentes adicionales."
fi

echo "======================================"
echo "ANALISIS DE INTEGRIDAD FINALIZADO"
echo "======================================"

python3 -m http.server "$PORT" --bind 0.0.0.0
