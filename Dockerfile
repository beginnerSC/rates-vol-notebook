FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    POETRY_VERSION=2.2.1 \
    POETRY_VIRTUALENVS_CREATE=false

WORKDIR /app

# Install Poetry in the container and use it to install project deps.
RUN pip install "poetry==${POETRY_VERSION}"

COPY pyproject.toml poetry.lock ./
RUN poetry install --no-interaction --no-ansi --no-root

COPY . .

# Render provides PORT at runtime. Keep a default for local docker runs.
ENV PORT=10000
EXPOSE 10000

CMD ["sh", "-c", "voila rates_vol_modeling_overview.ipynb --template=reveal --no-browser --Voila.ip=0.0.0.0 --Voila.port=${PORT}"]
