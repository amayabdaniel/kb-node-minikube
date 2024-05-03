# NodeJS Application Deployment with Kubernetes and GitHub Actions

## Overview
This repository contains configuration files and instructions for deploying a NodeJS application with Kubernetes and automating deployment using GitHub Actions. The service offers a key-value store API interface using Redis.

## Table of Contents
- [Prerequisites](#prerequisites)
- [Folder Structure](#folder-structure)
- [Deployment Steps](#deployment-steps)
- [CI/CD Pipeline with GitHub Actions](#cicd-pipeline-with-github-actions)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

## Prerequisites
Ensure the following tools are installed and accessible:
- Docker
- `kubectl`
- Access to a Kubernetes cluster (like Minikube or GKE)
- GitHub account for GitHub Actions

## Folder Structure
The repository is organized as follows:
- `Dockerfile`: Contains the docker build instructions for the NodeJS application.
- `app.js`: The main application file for the NodeJS service.
- `k8s/base`: Contains base Kubernetes manifests.
 - `kb-node-app`: Kubernetes manifests specific to the NodeJS application.
 - `deployment.yaml`: Deployment configuration for the NodeJS application.
 - `service.yaml`: Service definition for the NodeJS application.
 - `redis`: Kubernetes manifests specific to the Redis deployment.
 - `deployment.yaml`: Deployment configuration for Redis.
 - `service.yaml`: Service definition for Redis.
- `.github/workflows/ci.yaml`: Defines the GitHub Actions workflow for continuous integration and deployment.
- `package.json`: Defines the NodeJS application's dependencies.

## Deployment Steps

To get the application up and running on your Kubernetes cluster, follow these steps:

### Clone the Repository
To begin, clone this repository onto your local machine by running:
```bash
git clone https://github.com/amayabdaniel/kb-node-minikube.git
cd kb-node-minikube 
```
### Build the Docker Image

Build the Docker image for the NodeJS application using the provided `Dockerfile`:

```bash
docker build -t us-central1-docker.pkg.dev/novaferi/kb-node-v1/kb-nodeapp:e87065fca587b7f92bdc62c7f8539722a4585c7a .
```

### Push the Docker Image

Push the built image to your Docker Hub repository (or any other container registry you are using):

```bash
docker push us-central1-docker.pkg.dev/novaferi/kb-node-v1/kb-nodeapp:e87065fca587b7f92bdc62c7f8539722a4585c7a
```
### Set up Kubernetes Configuration

Before deploying to Kubernetes, ensure your `kubectl` context is set to the correct cluster where you want to deploy the application:

```bash
kubectl config use-context gke_novaferi_us-central1_kb-node-minikube-cluster
```
### Deploy to Kubernetes

Apply the Kubernetes manifests for both the application and Redis:

```bash
kubectl apply -f k8s/base/kb-node-app/deployment.yaml
kubectl apply -f k8s/base/kb-node-app/service.yaml
kubectl apply -f k8s/base/redis/deployment.yaml
kubectl apply -f k8s/base/redis/service.yaml
```
### Verify the Deployment

After applying the manifests, you can verify that the pods are up and running by executing:
```bash
kubectl get pods
```
You should see the pods for both the NodeJS application and Redis running without any errors.

### Notes

-   Ensure you update the image names in the `deployment.yaml` files to match the image you pushed to your registry.
-   Modify any service types or resource requests/limits as per your environment needs.
-   Ensure that the persistent volumes and claims for Redis are correctly set up if persistence is required.
-   Always review and confirm the configuration files before applying them.

## License
This project is open-sourced under the MIT License.

<img width="1262" alt="image" src="https://github.com/amayabdaniel/kb-node-minikube/assets/81663278/d4263a0b-c53f-44d6-ad2d-17a01582ab27">
<img width="1235" alt="image" src="https://github.com/amayabdaniel/kb-node-minikube/assets/81663278/2cd5298d-64fc-4f14-9801-138b0e15960a">
<img width="1037" alt="image" src="https://github.com/amayabdaniel/kb-node-minikube/assets/81663278/9c94c9e8-8114-451d-8953-2723645da960">

