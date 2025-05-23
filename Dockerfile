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

# Copy the startup script and make it executable
COPY start.sh .
RUN chmod +x start.sh

# Run the startup script as the container's primary command
CMD ["./start.sh"]