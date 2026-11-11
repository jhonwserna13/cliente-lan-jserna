
from http.server import HTTPServer, BaseHTTPRequestHandler
from html import escape
import os


class CustomHandler(BaseHTTPRequestHandler):

    def generar_html(self):
        estudiante = escape(
            os.getenv("ESTUDIANTE_NOMBRE", "John Serna Hernandez")
        )

        html_content = f"""<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Servidor Web DMZ</title>
    <style>
        body {{
            font-family: Arial, sans-serif;
            margin: 40px;
            background-color: #f4f4f9;
        }}
        .container {{
            background: white;
            padding: 25px;
            border-radius: 8px;
        }}
        h1 {{ color: #2c3e50; }}
        .status {{
            color: #27ae60;
            font-weight: bold;
        }}
    </style>
</head>
<body>
    <div class="container">
        <h1>Servidor Objetivo DMZ</h1>
        <p>Estado del servicio:
        <span class="status">ONLINE / ACTIVO</span></p>
        <hr>
        <p><strong>Laboratorio de Ciberseguridad:</strong>
        {estudiante}</p>
        <p>Este nodo actúa como objetivo central
        para las pruebas controladas de seguridad
        y análisis de logs.</p>
    </div>
</body>
</html>"""

        return html_content

    def do_GET(self):
        html_content = self.generar_html()

        self.send_response(200)
        self.send_header("Content-Type", "text/html; charset=utf-8")
        self.send_header("Content-Length", str(len(html_content.encode("utf-8"))))
        self.end_headers()

        self.wfile.write(html_content.encode("utf-8"))

    def do_HEAD(self):
        html_content = self.generar_html()

        self.send_response(200)
        self.send_header("Content-Type", "text/html; charset=utf-8")
        self.send_header("Content-Length", str(len(html_content.encode("utf-8"))))
        self.end_headers()


if __name__ == "__main__":
    port = int(os.environ.get("PORT", "10000"))

    server = HTTPServer(("0.0.0.0", port), CustomHandler)

    print(f"Servidor DMZ activo en el puerto {port}")

    server.serve_forever()
