# Start from official n8n image
FROM n8nio/n8n:latest

# Switch to root for installations
USER root
WORKDIR /home/node

# Install system dependencies for Chromium/Playwright
RUN apt-get update && apt-get install -y \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libx11-xcb1 \
    libnss3 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxfixes3 \
    libxrandr2 \
    libgbm1 \
    libasound2 \
    libpangocairo-1.0-0 \
    libpango-1.0-0 \
    libcups2 \
    libxss1 \
    libxtst6 \
    fonts-liberation \
    libgtk-3-0 \
    libdrm2 \
    xdg-utils \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Create custom nodes folder
RUN mkdir -p /home/node/.n8n/custom

# Install Browser node + Playwright into custom folder
RUN cd /home/node/.n8n/custom && npm init -y && \
    npm install n8n-nodes-browser playwright

# Reset permissions so n8n (node user) can read everything
RUN chown -R node:node /home/node/.n8n

# Switch back to node user
USER node
WORKDIR /data

# Copy workflow(s)
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

# Import workflows then start n8n
ENTRYPOINT ["sh", "-c", "n8n import:workflow --input=/data/workflows --separate --overwrite && n8n start --tunnel"]
