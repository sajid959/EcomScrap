# Start from official n8n Alpine image
FROM n8nio/n8n:latest

USER root
WORKDIR /home/node

# Install dependencies for HTTP nodes
RUN apk add --no-cache \
    bash \
    curl \
    jq \
    libc6-compat \
    libstdc++ \
    && rm -rf /var/cache/apk/*

# Fix permissions
RUN chown -R node:node /home/node

# Switch back to node
USER node
WORKDIR /data

# Copy workflow into container
COPY workflow.json /data/workflows/workflow.json

# Environment variables (set in Render)
ENV N8N_BASIC_AUTH_ACTIVE=true
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678
ENV NODE_ENV=production
ENV EXECUTIONS_PROCESS=main
ENV GENERIC_TIMEZONE=Asia/Kolkata
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true

EXPOSE 5678

# Import workflow & start n8n
ENTRYPOINT ["sh", "-c", "n8n import:workflow --input=/data/workflows --separate --overwrite && n8n start --tunnel"]
