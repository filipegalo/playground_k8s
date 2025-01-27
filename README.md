# Kubernetes Playground


This repository is designed to help you experiment with **Kubernetes** locally using **Minikube**. Whether you're just getting started or need a testing ground for your Kubernetes skills, this is the perfect environment for learning and experimenting without the need for cloud infrastructure.

## Features
- 🖥️ **Local Kubernetes Cluster**: Powered by Minikube.
- 🛠️ **Simple Setup**: Start experimenting quickly with minimal configuration.
- 🧪 **Safe Environment**: Play around with Kubernetes concepts risk-free.

## Prerequisites
Before you start, make sure you have the following installed on your machine:

- **Minikube**
- **kubectl**

## Getting Started

1. Clone this repository.
2. Run `minikube start` to start the Kubernetes cluster.
3. Run `kubectl get nodes` to check if the cluster is running.

## Helmfile

1. Install Helmfile: `brew install helmfile`
2. Run `./setup.sh` to install the necessary plugins and enable the ingress addon.
3. Go to the `helmfile` directory.
4. Run `helmfile apply` to install the applications.

## License

This project is licensed under the **DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE**. 
See the [LICENSE](LICENSE) file for more details.
