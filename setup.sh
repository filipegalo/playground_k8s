#!/bin/bash

function install() {
    # Install Helm plugins
    helm plugin install https://github.com/databus23/helm-diff
    helm plugin install https://github.com/aslafy-z/helm-git 
    helm plugin install https://github.com/jkroepke/helm-secrets

    # Start and configure Minikube
    minikube start --cni=calico
    minikube addons enable ingress
    minikube addons enable ingress-dns
    minikube addons enable metrics-server

    # Configure DNS resolution
    echo "nameserver $(minikube ip)" | sudo tee -a /etc/resolver/minikube.local
    echo "search_order 1" | sudo tee -a /etc/resolver/minikube.local
    echo "timeout 5" | sudo tee -a /etc/resolver/minikube.local

    # Flush DNS cache on macOS
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sudo dscacheutil -flushcache
        sudo killall -HUP mDNSResponder
    fi

    # Add worker node
    minikube node add

    # Label worker node
    kubectl label node minikube-m02 node-role.kubernetes.io/apps=true
}

function cleanup() {
    # Delete Minikube cluster
    minikube delete
    
    # Remove DNS resolver configuration
    sudo rm -f /etc/resolver/minikube.local
}

case "$1" in
    "install")
        install
        ;;
    "cleanup")
        cleanup
        ;;
    *)
        echo "Usage: $0 {install|cleanup}"
        exit 1
        ;;
esac