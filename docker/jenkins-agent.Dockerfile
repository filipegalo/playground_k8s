FROM jenkins/inbound-agent:alpine AS builder

USER root

# Install prerequisites (curl, bash, git)
RUN apk add --no-cache curl bash git

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl

# Install Helm
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 && \
    chmod 700 get_helm.sh && \
    ./get_helm.sh && \
    rm get_helm.sh

# Install Helmfile
ENV HELMFILE_VERSION=0.171.0    
RUN curl -fsSL "https://github.com/helmfile/helmfile/releases/download/v${HELMFILE_VERSION}/helmfile_${HELMFILE_VERSION}_linux_amd64.tar.gz" | tar -xz -C /usr/local/bin && \
    chmod +x /usr/local/bin/helmfile

USER jenkins

# Install Helm plugins
RUN helm plugin install https://github.com/databus23/helm-diff && \
    helm plugin install https://github.com/aslafy-z/helm-git && \
    helm plugin install https://github.com/jkroepke/helm-secrets
