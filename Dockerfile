FROM python:3.10-slim

ENV DEBIAN_FRONTEND=noninteractive

# OpenCV runtime dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgl1 \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install pre-built dlib binary from PyPI (zero compilation)
RUN pip install --no-cache-dir dlib-bin

# Install face-recognition without pulling a source build
RUN pip install --no-cache-dir --no-deps face-recognition-models==0.3.0
RUN pip install --no-cache-dir --no-deps face-recognition==1.3.0

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV PORT=10000
EXPOSE 10000

CMD ["gunicorn", "--bind", "0.0.0.0:10000", "--workers", "1", "--threads", "2", "--timeout", "120", "app:app"]