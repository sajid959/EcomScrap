FROM n8nio/n8n:latest

# Optional: copy workflow if you want preloaded
COPY deal-hydra-workflow.json /root/.n8n/workflows/deal-hydra-workflow.json