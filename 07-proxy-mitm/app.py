
from flask import Flask, Response
import os
from datetime import datetime

app = Flask(__name__)

ESTUDIANTE = "John Serna Hernandez"

@app.route("/")
def demostracion():

    hora = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    app.logger.info("==========================================")
    app.logger.info("LABORATORIO: PROXY MITM")
    app.logger.info("Estudiante: %s", ESTUDIANTE)
    app.logger.info("[MITM SIMULADO] Peticion HTTP recibida.")
    app.logger.info("[AUDITORIA] Registrando respuesta original.")

    contenido_original = """
    <h2>Respuesta original</h2>
    <p>Contenido inicial del servidor de demostracion.</p>
    """

    app.logger.info("[MITM SIMULADO] Analizando contenido de respuesta.")

    contenido_modificado = """
    <hr>
    <h2 style="color:red;">ALERTA: CONTENIDO MODIFICADO</h2>
    <p>Se simulo una modificacion de la respuesta HTML.</p>
    <p>Esta demostracion representa un riesgo de seguridad MITM.</p>
    """

    contenido = f"""
    <!DOCTYPE html>
    <html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Laboratorio Proxy MITM</title>
    </head>
    <body>
        <h1>Laboratorio de Ciberseguridad</h1>
        <h3>Unidad 2 - Seguridad en redes y aplicaciones web</h3>
        <p><strong>Estudiante:</strong> {ESTUDIANTE}</p>
        <p><strong>Fecha:</strong> {hora}</p>

        {contenido_original}

        {contenido_modificado}

        <hr>
        <h3>Analisis de seguridad</h3>
        <p>La demostracion permite identificar el riesgo
        de modificar respuestas durante una comunicacion.</p>
        <p><strong>Medidas preventivas:</strong></p>
        <ul>
            <li>Utilizar HTTPS.</li>
            <li>Validar los certificados digitales.</li>
            <li>Proteger la integridad de las comunicaciones.</li>
        </ul>
        <p>Simulacion controlada. No se intercepto trafico real.</p>
    </body>
    </html>
    """

    app.logger.warning(
        "[ALERTA MITM] Modificacion HTML demostrativa registrada."
    )
    app.logger.info("[AUDITORIA] Respuesta HTTP preparada: 200")
    app.logger.info("[ANALISIS] No se intercepto trafico externo.")
    app.logger.info("SIMULACION MITM FINALIZADA")
    app.logger.info("==========================================")

    return Response(
        contenido,
        status=200,
        mimetype="text/html",
        headers={"X-Lab-Simulation": "MITM-Demo"}
    )


if __name__ == "__main__":
    puerto = int(os.environ.get("PORT", 10000))
    app.run(host="0.0.0.0", port=puerto)

