# NodeJS Application Deployment with Kubernetes and GitHub Actions

## Overview
This repository contains the necessary configuration files and steps to deploy a simple NodeJS application using Kubernetes and GitHub Actions. The application exposes an API for inserting and reading key-value pairs, using Redis as the key/value storage.

## Table of Contents
- Prerequisites
- Folder Structure
- Deployment Steps
- CI/CD Pipeline with GitHub Actions
- Troubleshooting
- Contributing
- License

## Prerequisites
Before starting, ensure you have the following:
- Docker installed locally.
- `kubectl` installed for interacting with the Kubernetes cluster.
- Access to a Kubernetes cluster (e.g., Minikube, Google Kubernetes Engine).
- A GitHub account for setting up GitHub Actions.

## Folder Structure
Here is what the repository structure looks like:

markdown
Copy code
- `Dockerfile`: Instructions to build the Docker image for the NodeJS application.
- `app.js`: Main file of the NodeJS application.
- `deployment.yaml`: Kubernetes manifest for deploying both the application and Redis.
- `.github/workflows/ci.yaml`: GitHub Actions workflow file for CI/CD pipeline.
- `package.json`: NodeJS package configuration.

## Deployment Steps
To deploy the NodeJS application and Redis using Kubernetes, follow these steps:

1. **Build the Docker image:**
    ```bash
    docker build -t <image-name> .
    ```
2. **Push the Docker image:**
    ```bash
    docker push <image-name>
    ```
3. **Deploy to Kubernetes:**
    ```bash
    kubectl apply -f deployment.yaml
    ```

## CI/CD Pipeline with GitHub Actions
The CI/CD pipeline automates the building, pushing, and deployment processes using GitHub Actions:
- **Automated Image Build and Push:** The Docker image is built and pushed to the specified container registry.
- **Deployment:** The Kubernetes manifest is applied, updating the cluster with the latest image.

## Troubleshooting
Here are a few tips if you encounter issues:
- **Check Docker and Kubernetes Permissions:** Make sure your CI/CD pipeline has appropriate permissions to interact with Docker and Kubernetes.
- **Logs and Output:** Check the output logs of the GitHub Actions workflow for specific error messages.
- **Configuration Files:** Ensure all configurations in your Dockerfile and deployment.yaml are correct.

## Contributing
Contributions are welcome! If you encounter issues or have improvements, feel free to open an issue or submit a pull request.

## License
This project is open-sourced under the MIT License.



# SRE Technical Test Answers

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
