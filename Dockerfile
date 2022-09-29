FROM --platform=linux/arm64/v8 python:3.9-slim

RUN apt-get update && apt-get install -y curl wget bash tini pkg-config gcc make sqlite3
RUN wget https://github.com/mikefarah/yq/releases/download/v4.12.2/yq_linux_arm.tar.gz -O - |\
      tar xz && mv yq_linux_arm /usr/bin/yq
RUN curl -sSL https://install.python-poetry.org | python3 -
ENV PATH="/root/.local/bin:$PATH"

WORKDIR /app/
COPY lnbits-legend/ .

ENV LNBITS_PORT 5000
ENV LNBITS_HOST lnbits.embassy

RUN poetry config virtualenvs.create false
RUN poetry install --no-dev --no-root
RUN poetry run python build.py
RUN pip install pyln-client

RUN mkdir -p ./data
ADD .env.example ./.env
RUN chmod a+x ./.env
ADD docker_entrypoint.sh /usr/local/bin/docker_entrypoint.sh
ADD scripts/check-web.sh /usr/local/bin/check-web.sh
RUN chmod a+x /usr/local/bin/*.sh
