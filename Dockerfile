# Stage 1: Build Stage
ARG PYTHON_VERSION=3.8
FROM python:${PYTHON_VERSION} as builder

# Set the working directory
WORKDIR /app
COPY . .

# Stage 2: Run Stage
FROM python:${PYTHON_VERSION} as run

WORKDIR /app

ENV PYTHONUNBUFFERED=1

COPY --from=builder /app .

RUN pip install --upgrade pip && \
    pip install -r requirements.txt

EXPOSE 8080

# Run database migrations and start the Django application
ENTRYPOINT ["sh", "-c", "python -c \"import os, socket, time; host=os.getenv('HOST','mysql'); port=int(os.getenv('PORT','3306')); deadline=time.time()+60;\\n\\nwhile True:\\n  try:\\n    s=socket.create_connection((host,port), timeout=2); s.close(); break\\n  except OSError:\\n    if time.time()>deadline: raise\\n    time.sleep(1)\" && python manage.py migrate && python manage.py runserver 0.0.0.0:8080"]