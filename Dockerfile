# Start from official n8n image (Alpine-based)
FROM n8nio/n8n:latest

# Switch to root
USER root
WORKDIR /home/node

# Install system dependencies for Chromium/Playwright on Alpine
RUN apk add --no-cache \
    udev \
    ttf-freefont \
    chromium \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    dumb-init \
    wget \
    bash \
    libc6-compat \
    libstdc++ \
    xvfb \
    && rm -rf /var/cache/apk/*

# Create custom nodes folder
RUN mkdir -p /home/node/.n8n/custom

# Install Browser node + Playwright
RUN cd /home/node/.n8n/custom && npm init -y && \
    npm install n8n-nodes-browser playwright

# Fix permissions
RUN chown -R node:node /home/node/.n8n

# Back to node user
USER node
WORKDIR /data

# Copy workflows
COPY workflow.json /data/workflows/workflow.json

# Environment variables
ENV N8N_BASIC_AUTH_ACTIVE=true
ENV N8N_BASIC_AUTH_USER=admin
ENV N8N_BASIC_AUTH_PASSWORD=changeme
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678
ENV NODE_ENV=production
ENV EXECUTIONS_PROCESS=main
ENV GENERIC_TIMEZONE=Asia/Kolkata
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true

EXPOSE 5678

# Import workflows & start
ENTRYPOINT ["sh", "-c", "n8n import:workflow --input=/data/workflows --separate --overwrite && n8n start --tunnel"]
