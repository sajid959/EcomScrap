# Use official n8n image
FROM n8nio/n8n:latest

# Set working directory
WORKDIR /root/.n8n

# Copy workflow file
COPY deal-hydra-workflow.json /root/.n8n/workflows/deal-hydra-workflow.json

# Set default environment variables (override with .env)
ENV N8N_BASIC_AUTH_ACTIVE=true
ENV N8N_BASIC_AUTH_USER=admin
ENV N8N_BASIC_AUTH_PASSWORD=changeme
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678
ENV NODE_ENV=production
ENV EXECUTIONS_PROCESS=main
ENV GENERIC_TIMEZONE=Asia/Kolkata

# Expose port
EXPOSE 5678

# Run n8n
CMD ["n8n", "start", "--tunnel"]