FROM python:3.10-slim

# Install system runtime dependencies for OpenCV
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgl1 \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install pre-built dlib wheel directly (avoids compilation entirely)
RUN pip install --no-cache-dir \
    https://github.com/reagankm/dlib-python-wheels/releases/download/v19.24.2/dlib-19.24.2-cp310-cp310-linux_x86_64.whl

COPY requirements.txt .

# Install remaining requirements
RUN pip install --no-cache-dir --no-deps face-recognition==1.3.0 face-recognition-models==0.3.0
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV PORT=10000
EXPOSE 10000

CMD ["gunicorn", "--bind", "0.0.0.0:10000", "app:app"]