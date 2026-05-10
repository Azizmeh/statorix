FROM apache/superset:6.0.0

USER root

RUN apt-get update && apt-get install -y \
    gcc \
    python3-dev \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

RUN /app/.venv/bin/python -m ensurepip --upgrade

RUN /app/.venv/bin/python -m pip install --no-cache-dir \
    psycopg2-binary \
    clickhouse-connect==0.7.19 \
    authlib==1.7.0

COPY superset_config.py /app/pythonpath/superset_config.py
COPY init.sh /app/init.sh
COPY statorix_logo.svg /app/superset/static/assets/images/statorix_logo.svg
COPY statorix_logo_dark.svg /app/superset/static/assets/images/statorix_logo_dark.svg
COPY statorix_icon.svg /app/superset/static/assets/images/statorix_icon.svg

RUN chmod +x /app/init.sh

USER superset

ENTRYPOINT ["/app/init.sh"]