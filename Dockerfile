FROM python:3.12-slim

# Install Nginx and envsubst
RUN apt-get update && \
    apt-get install -y nginx-extras gettext-base && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy Nginx config template
COPY /nginx/nginx.conf.template /etc/nginx/nginx.conf.template

# Copy app code
COPY . .

# Substitute $PORT into Nginx config and start services
CMD envsubst '\$PORT' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf.template && \
    service nginx start && \
    uvicorn main:app --host 0.0.0.0 --port 8000