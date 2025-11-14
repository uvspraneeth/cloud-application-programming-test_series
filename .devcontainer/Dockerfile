# syntax=docker/dockerfile:1

ARG VARIANT="20"
FROM mcr.microsoft.com/vscode/devcontainers/javascript-node:0-${VARIANT}

# Install system tools and CF CLI
USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl git sqlite3 wget ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Install Cloud Foundry CLI (Linux x64 binary)
RUN wget -q -O /tmp/cf-cli.tgz "https://packages.cloudfoundry.org/stable?release=linux64-binary&source=github" && \
    tar -xzf /tmp/cf-cli.tgz -C /tmp && \
    mv /tmp/cf /usr/local/bin/cf && \
    chmod +x /usr/local/bin/cf && \
    rm /tmp/cf-cli.tgz

# Install SAP CAP SDK globally
USER node
RUN npm install -g @sap/cds-dk

WORKDIR /home/node
