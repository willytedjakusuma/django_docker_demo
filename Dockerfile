FROM python:3.13.4-slim

# dontwritebytecode and unbuffered output
# https://docs.python.org/3/using/cmdline.html#envvar-PYTHONDONTWRITEBYTECODE
# https://docs.python.org/3/using/cmdline.html#envvar-PYTHONUNBUFFERED

ENV PYTHONDONTWRITEBYTECODE=1 \ 
    PYTHONUNBUFFERED=1

WORKDIR /app

RUN apt-get update && apt-get install -y curl

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/
# copy uv and uvx executables from the uv image

COPY django_docker/requirements.txt .
RUN uv pip install -r requirements.txt --system

COPY django_docker/ .
EXPOSE 8000

CMD ["./entrypoint.sh"]
