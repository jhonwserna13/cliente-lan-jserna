
FROM alpine:latest

RUN apk add --no-cache python3

WORKDIR /app

RUN printf '#!/bin/sh\necho "[DEMO] Componente de prueba ejecutado."\n' > /app/dependency_demo.sh \
    && chmod +x /app/dependency_demo.sh

COPY entrypoint.sh /app/entrypoint.sh

RUN chmod +x /app/entrypoint.sh

EXPOSE 10000

ENTRYPOINT ["/app/entrypoint.sh"]
