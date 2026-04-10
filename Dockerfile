# ─────────────────────────────────────────────
#  Saurabh Portfolio — Production Dockerfile
#  Base: nginx:alpine (lightweight ~5 MB)
# ─────────────────────────────────────────────

FROM nginx:alpine

# Remove default nginx placeholder page
RUN rm -rf /usr/share/nginx/html/*

# Copy custom nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy all portfolio files into the nginx web root
COPY . /usr/share/nginx/html/

# Expose HTTP port
EXPOSE 80

# Start nginx in foreground (required for Docker)
CMD ["nginx", "-g", "daemon off;"]
