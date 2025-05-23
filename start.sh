#!/bin/bash

# Apply environment variable to Nginx config
envsubst '\$PORT' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

# Start Nginx in the background
nginx

# Start Uvicorn, keeping it in the foreground to keep the container alive
uvicorn main:app --host 0.0.0.0 --port 8000