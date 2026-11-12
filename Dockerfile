
FROM python:3.12-slim

WORKDIR /app

COPY .github/scripts/ /app/scripts/

RUN chmod +x /app/scripts/entrypoint.sh

ENTRYPOINT ["/bin/bash", "/app/scripts/entrypoint.sh"]
