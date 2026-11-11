
FROM alpine:latest

RUN apk add --no-cache python3 wget

WORKDIR /app

COPY entrypoint.sh /app/entrypoint.sh

RUN sed -i 's/\r$//' /app/entrypoint.sh && chmod +x /app/entrypoint.sh

EXPOSE 10000

ENTRYPOINT ["/bin/sh", "/app/entrypoint.sh"]
