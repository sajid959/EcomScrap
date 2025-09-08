# Start from official n8n image
FROM n8nio/n8n:latest

# Set working directory
WORKDIR /data

# Copy your workflow(s) into container
COPY workflow.json /data/workflows/workflow.json

# Install extra n8n nodes (Browser, etc.)
USER root
RUN npm install -g n8n-nodes-browser
USER node

# Environment variables (override in Render dashboard for secrets)
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

# Import workflow(s) on startup, then launch n8n
ENTRYPOINT ["sh", "-c", "n8n import:workflow --input=/data/workflows --separate --overwrite && n8n start --tunnel"]
