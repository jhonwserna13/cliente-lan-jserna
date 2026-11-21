
from flask import Flask, jsonify, render_template_string
from datetime import datetime
from collections import deque
import os
import threading

app = Flask(__name__)

ESTUDIANTE = "John Serna Hernandez"
eventos = deque(maxlen=100)
contador = 0
bloqueo = threading.Lock()

HTML = """
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Laboratorio DoS - Unidad 2</title>
<style>
body {font-family:Arial;background:#101827;color:#e5e7eb;margin:0;padding:30px}
main {max-width:900px;margin:auto}
.card {background:#1e293b;padding:22px;border-radius:12px;margin:18px 0}
h1,h2 {color:#38bdf8}
.stat {font-size:32px;font-weight:bold;color:#4ade80}
button {background:#0284c7;color:white;border:0;padding:12px 18px;border-radius:7px;cursor:pointer}
button:hover {background:#0369a1}
li {margin:9px 0}
small {color:#94a3b8}
</style>
</head>
<body>
<main>
<h1>Laboratorio de Ciberseguridad</h1>
<h2>Unidad 2 - Ataques de denegación de servicio (DoS)</h2>
<p>Estudiante: <strong>{{ estudiante }}</strong></p>

<div class="card">
<h2>Estado del laboratorio</h2>
<p class="stat">SERVICIO ACTIVO</p>
<p>Servidor disponible para pruebas controladas.</p>
</div>

<div class="card">
<h2>Monitoreo HTTP</h2>
<p>Solicitudes recibidas: <span class="stat" id="total">{{ total }}</span></p>
<button onclick="prueba()">Generar 5 solicitudes locales</button>
<p id="resultado">Esperando prueba controlada.</p>
</div>

<div class="card">
<h2>Registro de eventos</h2>
<ul id="logs">
{% for evento in eventos %}
<li>{{ evento }}</li>
{% endfor %}
</ul>
</div>

<div class="card">
<h2>Análisis de seguridad</h2>
<p>Un ataque DoS busca afectar la disponibilidad de un servicio
mediante un volumen excesivo de solicitudes o recursos consumidos.</p>
<p><strong>Medidas preventivas:</strong></p>
<ul>
<li>Limitar la frecuencia de solicitudes.</li>
<li>Implementar monitoreo del tráfico.</li>
<li>Configurar firewalls y filtros.</li>
<li>Utilizar mecanismos de protección contra tráfico anómalo.</li>
</ul>
</div>

<p><small>Simulación educativa local. No se genera tráfico contra terceros.</small></p>
</main>

<script>
async function prueba() {
 const resultado = document.getElementById("resultado");
 resultado.textContent = "Ejecutando prueba controlada...";
 const r = await fetch("/simular", {method:"POST"});
 const data = await r.json();
 document.getElementById("total").textContent = data.total;
 document.getElementById("logs").innerHTML =
 data.eventos.map(e => "<li>"+e+"</li>").join("");
 resultado.textContent = data.mensaje;
}
</script>
</body>
</html>
"""

@app.route("/")
def inicio():
    with bloqueo:
        total = contador
        historial = list(eventos)

    return render_template_string(
        HTML,
        estudiante=ESTUDIANTE,
        total=total,
        eventos=historial
    )

@app.route("/simular", methods=["POST"])
def simular():
    global contador

    with bloqueo:
        for i in range(5):
            contador += 1
            hora = datetime.now().strftime("%H:%M:%S")
            eventos.append(
                f"[{hora}] Solicitud HTTP local #{contador} registrada"
            )

        total = contador
        historial = list(eventos)

    app.logger.info(
        "[SIMULACION DOS] Cinco solicitudes locales registradas."
    )

    return jsonify({
        "total": total,
        "eventos": historial,
        "mensaje": "Prueba controlada finalizada correctamente."
    })

if __name__ == "__main__":
    puerto = int(os.environ.get("PORT", 10000))
    app.run(host="0.0.0.0", port=puerto)
