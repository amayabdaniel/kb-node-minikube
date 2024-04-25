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
git clone https://github.com/<your-username>/<repository-name>.git
cd <repository-name> 
```
### Build the Docker Image

Build the Docker image for the NodeJS application using the provided `Dockerfile`:

```bash
docker build -t <your-username>/<image-name>:<tag> .
```

Make sure to replace `<your-username>`, `<image-name>`, and `<tag>` with your Docker Hub username, the desired name for your image, and the tag respectively.

### Push the Docker Image

Push the built image to your Docker Hub repository (or any other container registry you are using):

```bash
docker push <your-username>/<image-name>:<tag>
```
### Set up Kubernetes Configuration

Before deploying to Kubernetes, ensure your `kubectl` context is set to the correct cluster where you want to deploy the application:

```bash
kubectl config use-context <your-cluster-context>
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





## Some questions:

### 1. What is the need for DevOps in a company?
    DevOps practices are crucial for companies because they bridge the gap between development and operations teams, fostering better communication and collaboration. This integration leads to faster deployment cycles, higher deployment frequency, and more dependable releases in alignment with business objectives.

### 2. Which are the top DevOps tools? Which tools have you worked on?
    - **Top DevOps Tools:** Some of the leading tools include Docker for containerization, Jenkins for automation, Kubernetes for orchestration, Ansible for configuration management, and Git for version control.
    - **My Experience:** I have worked extensively with Docker, Kubernetes, and Git in my previous projects, focusing on automating deployment processes and maintaining version control for various development stages.

#### 2.1 How do all these tools work together?
    These tools integrate to create a robust DevOps environment where:
        - **Git** manages source code.
        - **Docker** containers package the application and its environment.
        - **Jenkins** automates the pipeline from code commit to delivery.
        - **Kubernetes** manages and scales the containers.
        - **Ansible** ensures consistent environments across development to production.

### 3. What is the most important thing DevOps helps us achieve?
    The most important achievement through DevOps is the significant reduction in the development life cycle, leading to faster time to market. This is achieved by automating and optimizing processes, which also enhances product quality and reliability.

### 4. Explain your understanding and expertise on both the software development and technical operations sides of an organization you have worked with in the past.
    In my previous role, I was involved in full-stack development and operations, which included planning, coding, testing, deploying, and monitoring applications. My expertise includes setting up CI/CD pipelines, configuring cloud environments, and maintaining server health, which improved our deployment frequency and system stability.

### 5. What is Version control and what are the benefits of using it?
    Version control is the management of changes to code, documents, and other collections of information. Benefits include:
        - **Track Changes:** Maintains a history of changes and who made them.
        - **Collaboration:** Allows multiple people to work safely on the same project.
        - **Revert Options:** Offers the ability to revert to previous versions easily.

### 6. What are the KPIs that are used for gauging the success of a DevOps team?
    Key Performance Indicators (KPIs) for a DevOps team include deployment frequency, change lead time, change failure rate, and mean time to recovery (MTTR). These metrics help evaluate the team's efficiency, effectiveness, and alignment with business objectives.

### 7. How will you approach a project that needs to implement DevOps?
    I would start by assessing the current state of development and operations, then establish clear goals for automation, collaboration, and monitoring. Implementing toolchains for CI/CD, configuration management, and real-time monitoring would follow, alongside fostering a culture of continuous improvement.

### 8. What is meant by Continuous Integration and why do you need one for Dev & Testing?
    Continuous Integration (CI) is a practice where developers frequently integrate their code into a shared repository, usually multiple times a day. CI is essential for development and testing because it allows early detection of conflicts and bugs, ensuring that software is tested and reliable at every stage of development.

## The challenge:

### Questions related to the NodeJS and Redis application challenge:

#### 4.1 How does your database’s lifecycle differ from your application’s? How could it be done differently inside Kubernetes?
    The lifecycle of the Redis database is more persistent compared to the stateless NodeJS application. In Kubernetes, this can be managed by using StatefulSets for Redis to handle its state persistence and Deployments for the stateless NodeJS application to manage its lifecycle.

#### 4.2 Is your database persistent? If not, how could you accomplish it?
    Initially, the Redis deployment is not persistent. To achieve persistence, I would configure Redis with a PersistentVolumeClaim in Kubernetes to ensure data is not lost on pod restarts or failures.

#### 4.3 Is your application scalable? If not, how would you make it so?
    The NodeJS application is scalable horizontally in Kubernetes by adjusting the replica count in the Deployment configuration. This can be automated with Horizontal Pod Autoscalers (HPA) based on CPU or memory usage metrics.
