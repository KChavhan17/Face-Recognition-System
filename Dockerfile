FROM python:3.10-slim

ENV DEBIAN_FRONTEND=noninteractive

# Install pre-compiled dlib and OpenCV dependencies directly from Debian repos
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-dlib \
    libgl1 \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .

# Install face-recognition without recompiling dlib
RUN pip install --no-cache-dir --no-deps face-recognition-models==0.3.0
RUN pip install --no-cache-dir --no-deps face-recognition==1.3.0
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV PORT=10000
EXPOSE 10000

CMD ["gunicorn", "--bind", "0.0.0.0:10000", "--workers", "1", "--threads", "2", "--timeout", "120", "app:app"]