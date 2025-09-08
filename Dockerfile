# Use official n8n image
FROM n8nio/n8n:latest

# Set working directory
WORKDIR /data

# Copy workflow file into a folder (n8n expects a folder for --import)
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

# Expose n8n port
EXPOSE 5678

# Start n8n with tunnel enabled
CMD ["n8n", "start", "--tunnel"]
