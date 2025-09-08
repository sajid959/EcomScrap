FROM n8nio/n8n:latest

WORKDIR /data

# Copy workflows into folder
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

# Import workflows on startup, then launch n8n
ENTRYPOINT ["sh", "-c", "n8n import:workflow --input=/data/workflows --separate --overwrite && n8n start --tunnel"]
