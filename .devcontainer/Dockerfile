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
RUN wget -q -O - https://packages.cloudfoundry.org/debian/cli.cloudfoundry.org.key | apt-key add - && \
    echo "deb https://packages.cloudfoundry.org/debian stable main" | tee /etc/apt/sources.list.d/cloudfoundry-cli.list && \
    apt-get update && \
    apt-get install -y cf-cli

# Install SAP CAP SDK globally
USER node
RUN npm install -g @sap/cds-dk

WORKDIR /home/node
