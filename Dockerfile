FROM n8nio/n8n:latest

WORKDIR /data

# Put workflow in a folder
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
ENV N8N_IMPORT=/data/workflows

EXPOSE 5678
ENTRYPOINT ["sh", "-c", "which n8n && n8n start --tunnel"]
# Use the command exactly as the image expects
#CMD ["n8n", "start", "--tunnel"]
