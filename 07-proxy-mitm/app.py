
from flask import Flask, Response
import os

app = Flask(__name__)

@app.route("/")
def demostracion():
    print("[MITM SIMULADO] Peticion recibida.")
    print("[AUDITORIA] Se registra una modificacion de respuesta.")

    contenido = """
    <!DOCTYPE html>
    <html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Laboratorio Proxy MITM</title>
    </head>
    <body>
        <h1>Laboratorio de Ciberseguridad</h1>
        <p>Estudiante: John Serna Hernandez</p>
        <p>Respuesta original de demostracion.</p>
        <hr>
        <h2>ALERTA: CONTENIDO MODIFICADO</h2>
        <p>Esta respuesta fue alterada por el proxy de demostracion.</p>
    </body>
    </html>
    """

    print("[MITM] Modificacion demostrativa realizada.")

    return Response(contenido, status=200, mimetype="text/html")

if __name__ == "__main__":
    puerto = int(os.environ.get("PORT", 10000))
    app.run(host="0.0.0.0", port=puerto)
