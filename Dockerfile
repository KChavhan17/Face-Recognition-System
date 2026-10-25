FROM python:3.10-slim

# Install system runtime libraries and wget
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgl1 \
    libglib2.0-0 \
    wget \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Download and install pre-built dlib wheel directly
RUN wget -q https://github.com/reagankm/dlib-python-wheels/releases/download/v19.24.2/dlib-19.24.2-cp310-cp310-linux_x86_64.whl \
    && pip install --no-cache-dir dlib-19.24.2-cp310-cp310-linux_x86_64.whl \
    && rm dlib-19.24.2-cp310-cp310-linux_x86_64.whl

# Install face-recognition without triggering a dlib build
RUN pip install --no-cache-dir --no-deps face-recognition==1.3.0 face-recognition-models==0.3.0

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV PORT=10000
EXPOSE 10000

CMD ["gunicorn", "--bind", "0.0.0.0:10000", "app:app"]