# Use Python 3.12.6 base image
FROM python:3.12-slim

# Install system dependencies (including Nginx)
RUN apt-get update && \
    apt-get install -y nginx && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy Python requirements
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy Nginx config
COPY nginx/nginx.conf /etc/nginx/nginx.conf

# Copy application code
COPY . .

# Start Nginx and FastAPI
CMD service nginx start && uvicorn app.main:app --host 0.0.0.0 --port 8000