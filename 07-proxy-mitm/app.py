from flask import Flask, Response
import os
from datetime import datetime

app = Flask(__name__)

ESTUDIANTE = "John Serna Hernandez"

@app.route("/")
def demostracion():

    hora = datetime.now().strftime("%d/%m/%Y - %H:%M:%S")

    app.logger.info("==========================================")
    app.logger.info("LABORATORIO: PROXY MITM")
    app.logger.info("Estudiante: %s", ESTUDIANTE)
    app.logger.info("[INFO] Iniciando simulacion controlada.")
    app.logger.info("[MITM SIMULADO] Peticion HTTP recibida.")
    app.logger.info("[AUDITORIA] Registrando respuesta original.")

    contenido_original = """
    <div class="response original">
        <span class="tag green">RESPUESTA ORIGINAL</span>
        <h3>Servidor de demostracion</h3>
        <p>Este es el contenido inicial enviado por el servidor.</p>
        <div class="status">✓ Integridad inicial conservada</div>
    </div>
    """

    app.logger.info("[MITM SIMULADO] Analizando contenido.")

    contenido_modificado = """
    <div class="response modified">
        <span class="tag red">ALERTA DE SEGURIDAD</span>
        <h3>Contenido modificado</h3>
        <p>Se simulo una alteracion de la respuesta HTML durante la demostracion.</p>
        <div class="status danger">⚠ Posible alteracion de integridad</div>
    </div>
    """

    contenido = f"""
    <!DOCTYPE html>
    <html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Laboratorio Proxy MITM</title>

        <style>
            * {{
                box-sizing: border-box;
            }}

            body {{
                margin: 0;
                padding: 35px 20px;
                background: #0f172a;
                color: #f1f5f9;
                font-family: Arial, sans-serif;
                line-height: 1.6;
            }}

            .container {{
                max-width: 1050px;
                margin: auto;
            }}

            header {{
                margin-bottom: 25px;
            }}

            h1 {{
                color: #38bdf8;
                font-size: 34px;
                margin-bottom: 5px;
            }}

            h2 {{
                color: #38bdf8;
                margin-top: 0;
            }}

            .subtitle {{
                color: #94a3b8;
                font-size: 17px;
            }}

            .card {{
                background: #1e293b;
                border: 1px solid #334155;
                border-radius: 15px;
                padding: 25px;
                margin-bottom: 22px;
                box-shadow: 0 8px 20px rgba(0,0,0,.15);
            }}

            .active {{
                color: #4ade80;
                font-weight: bold;
                font-size: 19px;
            }}

            .info {{
                color: #94a3b8;
                font-size: 14px;
            }}

            .grid {{
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 18px;
            }}

            .response {{
                background: #17243a;
                border: 1px solid #334155;
                border-radius: 12px;
                padding: 22px;
            }}

            .original {{
                border-top: 4px solid #4ade80;
            }}

            .modified {{
                border-top: 4px solid #f87171;
            }}

            .tag {{
                display: inline-block;
                padding: 5px 12px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: bold;
            }}

            .green {{
                color: #4ade80;
                background: #14532d;
            }}

            .red {{
                color: #f87171;
                background: #7f1d1d;
            }}

            .status {{
                color: #4ade80;
                font-weight: bold;
                margin-top: 15px;
            }}

            .danger {{
                color: #f87171;
            }}

            .warning {{
                color: #fbbf24;
                font-weight: bold;
            }}

            ul {{
                padding-left: 22px;
            }}

            li {{
                margin: 9px 0;
            }}

            .conclusion {{
                border-left: 4px solid #38bdf8;
            }}

            footer {{
                text-align: center;
                color: #94a3b8;
                padding: 20px;
                font-size: 13px;
            }}

            @media(max-width: 600px) {{
                h1 {{
                    font-size: 27px;
                }}

                .card {{
                    padding: 18px;
                }}
            }}
        </style>
    </head>

    <body>
    <main class="container">

        <header>
            <h1>Laboratorio de Ciberseguridad</h1>
            <h2>Unidad 7 - Proxy MITM</h2>
            <p class="subtitle">
                Simulacion de interceptacion y modificacion de respuestas HTTP
            </p>
            <p><strong>Estudiante:</strong> {ESTUDIANTE}</p>
            <p class="info"><strong>Fecha:</strong> {hora}</p>
        </header>

        <section class="card">
            <h2>Estado del laboratorio</h2>
            <div class="active">● SERVICIO ACTIVO</div>
            <p>Entorno disponible para pruebas controladas de seguridad.</p>
            <p class="info">
                Demostracion academica con contenido ficticio.
            </p>
        </section>

        <section class="card">
            <h2>¿Que es un ataque MITM?</h2>
            <p>
                Un ataque Man-in-the-Middle ocurre cuando un tercero
                consigue posicionarse entre dos partes que se comunican,
                pudiendo observar o alterar la informacion transmitida.
            </p>
        </section>

        <section class="card">
            <h2>Simulacion de respuestas HTTP</h2>
            <p>Comparacion entre el contenido original y la modificacion demostrativa.</p>

            <div class="grid">
                {contenido_original}
                {contenido_modificado}
            </div>
        </section>

        <section class="card">
            <h2>Analisis de seguridad</h2>
            <p class="warning">
                ⚠ RIESGO DE ALTERACION DE INFORMACION IDENTIFICADO
            </p>
            <p>
                La demostracion permite comprender como una respuesta
                puede ser modificada y por que es importante proteger
                la integridad de las comunicaciones.
            </p>
            <p class="status">
                ✓ Registro de auditoria generado.
            </p>
            <p class="status">
                ✓ No se intercepto trafico real.
            </p>
        </section>

        <section class="card">
            <h2>Medidas de proteccion</h2>
            <ul>
                <li>Utilizar conexiones HTTPS.</li>
                <li>Validar los certificados digitales.</li>
                <li>Evitar redes publicas no confiables.</li>
                <li>Implementar mecanismos de cifrado.</li>
                <li>Verificar la integridad de las comunicaciones.</li>
            </ul>
        </section>

        <section class="card conclusion">
            <h2>Conclusion</h2>
            <p>
                La simulacion demuestra la importancia de proteger
                las comunicaciones digitales frente a posibles
                modificaciones no autorizadas. El uso de HTTPS,
                certificados validos y mecanismos de integridad
                contribuye a mantener la confidencialidad y seguridad
                de la informacion.
            </p>
            <div class="active">SIMULACION COMPLETADA</div>
        </section>

        <footer>
            Laboratorio academico de ciberseguridad |
            John Serna Hernandez | Unidad 7
        </footer>

    </main>
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

