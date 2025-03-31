#!/bin/bash
set -e

# Define variables
IMAGE_NAME="jenkins/inbound-agent"
TAG="helm"
DOCKERFILE_PATH="jenkins-agent.Dockerfile"

# Print information
echo "Building Docker image: ${IMAGE_NAME}:${TAG}"
echo "Using Dockerfile: ${DOCKERFILE_PATH}"

# Build the Docker image with platform flag for macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
  echo "Detected macOS, building with platform linux/amd64..."
  docker build --platform=linux/amd64 -t ${IMAGE_NAME}:${TAG} -f ${DOCKERFILE_PATH} .
else
  docker build -t ${IMAGE_NAME}:${TAG} -f ${DOCKERFILE_PATH} .
fi

# Check if Minikube is running
if ! minikube status &>/dev/null; then
  echo "Error: Minikube is not running. Please start Minikube first."
  exit 1
fi

# Load the image into Minikube
echo "Loading image into Minikube..."
minikube image load ${IMAGE_NAME}:${TAG}

echo "Image successfully built and loaded into Minikube!"
echo "You can use this image in your Kubernetes deployments as: ${IMAGE_NAME}:${TAG}"
