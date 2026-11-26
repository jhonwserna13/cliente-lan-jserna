
from flask import Flask, jsonify, render_template_string
from datetime import datetime
from collections import deque
from urllib.request import Request, urlopen
from urllib.error import URLError, HTTPError
import os
import threading
import time

app = Flask(__name__)

ESTUDIANTE = "John Serna Hernandez"

# Servidor objetivo de nuestro laboratorio
TARGET_URL = os.environ.get(
    "TARGET_URL",
    "https://modulo-00-servidor-dmz-jserna.onrender.com/"
)

eventos = deque(maxlen=100)
contador = 0
bloqueo = threading.Lock()
simulacion_activa = False

HTML = """
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Laboratorio DoS - Unidad 2</title>
<style>
body {
    font-family: Arial;
    background: #101827;
    color: #e5e7eb;
    margin: 0;
    padding: 30px;
}
main {
    max-width: 900px;
    margin: auto;
}
.card {
    background: #1e293b;
    padding: 22px;
    border-radius: 12px;
    margin: 18px 0;
}
h1, h2 { color: #38bdf8; }
.stat {
    font-size: 32px;
    font-weight: bold;
    color: #4ade80;
}
button {
    background: #0284c7;
    color: white;
    border: 0;
    padding: 12px 18px;
    border-radius: 7px;
    cursor: pointer;
}
button:disabled {
    background: #64748b;
    cursor: not-allowed;
}
li { margin: 9px 0; }
small { color: #94a3b8; }
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

<p>Solicitudes exitosas:
<span class="stat" id="total">{{ total }}</span>
</p>

<button id="boton" onclick="prueba()">
Generar 5 solicitudes controladas
</button>

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

<p>
Un ataque DoS busca afectar la disponibilidad de un servicio
mediante un volumen excesivo de solicitudes o recursos consumidos.
</p>

<p><strong>Medidas preventivas:</strong></p>

<ul>
<li>Limitar la frecuencia de solicitudes.</li>
<li>Implementar monitoreo del tráfico.</li>
<li>Configurar firewalls y filtros.</li>
<li>Utilizar mecanismos de protección contra tráfico anómalo.</li>
</ul>
</div>

<p>
<small>
Simulación educativa controlada. Solo se realizan cinco
solicitudes secuenciales al servidor DMZ del laboratorio.
</small>
</p>

</main>

<script>
async function prueba() {
    const boton = document.getElementById("boton");
    const resultado = document.getElementById("resultado");

    boton.disabled = true;
    resultado.textContent = "Ejecutando cinco solicitudes hacia la DMZ...";

    try {
        const respuesta = await fetch("/simular", {
            method: "POST"
        });

        const data = await respuesta.json();

        document.getElementById("total").textContent = data.total;

        const lista = document.getElementById("logs");
        lista.replaceChildren();

        data.eventos.forEach(evento => {
            const li = document.createElement("li");
            li.textContent = evento;
            lista.appendChild(li);
        });

        resultado.textContent = data.mensaje;

    } catch (error) {
        resultado.textContent = "Error al ejecutar la simulación.";
    } finally {
        boton.disabled = false;
    }
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
    global contador, simulacion_activa

    with bloqueo:
        if simulacion_activa:
            return jsonify({
                "mensaje": "Ya existe una simulación en ejecución.",
                "total": contador,
                "eventos": list(eventos)
            }), 409

        simulacion_activa = True

    exitosas = 0

    try:
        app.logger.info("====================================")
        app.logger.info("[SIMULACION DOS] INICIANDO")
        app.logger.info(f"[OBJETIVO DMZ] {TARGET_URL}")
        app.logger.info("[INFO] Cinco solicitudes controladas.")

        for i in range(1, 6):

            try:
                solicitud = Request(
                    TARGET_URL,
                    headers={
                        "User-Agent": "Laboratorio-Ciberseguridad-John"
                    }
                )

                with urlopen(solicitud, timeout=70) as respuesta:
                    codigo = respuesta.status

                hora = datetime.now().strftime("%H:%M:%S")

                with bloqueo:
                    contador += 1
                    exitosas += 1

                    eventos.append(
                        f"[{hora}] Solicitud {i}: DMZ respondió HTTP {codigo}"
                    )

                app.logger.info(
                    f"[EXITO] Solicitud {i}/5 - HTTP {codigo}"
                )

            except Exception as error:

                hora = datetime.now().strftime("%H:%M:%S")

                with bloqueo:
                    eventos.append(
                        f"[{hora}] Solicitud {i}: Error de conexión"
                    )

                app.logger.error(
                    f"[ERROR] Solicitud {i}/5: {error}"
                )

            if i < 5:
                time.sleep(1)

        with bloqueo:
            total = contador
            historial = list(eventos)

        mensaje = (
            f"Simulación finalizada: {exitosas} de 5 "
            "solicitudes recibidas correctamente por la DMZ."
        )

        app.logger.info("[SIMULACION DOS] FINALIZADA")
        app.logger.info(f"[RESULTADO] {exitosas}/5 solicitudes exitosas")
        app.logger.info("====================================")

        return jsonify({
            "total": total,
            "eventos": historial,
            "mensaje": mensaje
        })

    finally:
        with bloqueo:
            simulacion_activa = False


if __name__ == "__main__":
    puerto = int(os.environ.get("PORT", 10000))

    app.run(
        host="0.0.0.0",
        port=puerto,
        debug=False
    )

