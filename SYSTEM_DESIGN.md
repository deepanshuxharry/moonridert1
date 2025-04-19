# System Design Document

## Overview

This document outlines the system design for the MoonriderT1 project, a Java-based application with CI/CD integration and containerized deployment.

## Architecture

- **Backend**: Java 17 application built with Maven.
- **Database**: MySQL for data persistence.
- **CI/CD**: Jenkins for continuous integration and deployment.
- **Containerization**: Docker for creating application images.
- **Orchestration**: Kubernetes for managing containerized applications.

## Components

### 1. Application
- Located in the `src` directory.
- Built using Maven (`pom.xml`).

### 2. Docker
- `Dockerfile` defines the steps to containerize the application.

### 3. Jenkins
- `Jenkinsfile` contains the pipeline configuration for building, testing, and deploying the application.

### 4. Kubernetes
- `app-deployment.yaml`: Deployment configuration for the application.
- `mysql-deployment.yaml`: Deployment configuration for the MySQL database.
- `mysql-configMap.yaml`: Configuration for MySQL settings.
- `mysql-secrets.yaml`: Secrets for MySQL credentials.
- `ingress.yaml`: Ingress configuration for routing external traffic.

### 5. Shell Scripts
- `install-jenkins-java-17.sh`: Installs Jenkins and Java 17.
- `configure-jenkins-user.sh`: Configures Jenkins user settings.

## Workflow

1. **Development**: Code is written in Java and managed with Maven.
2. **Containerization**: Application is containerized using Docker.
3. **CI/CD Pipeline**: Jenkins automates the build, test, and deployment processes.
4. **Deployment**: Kubernetes manages the deployment of the application and database.

## Design Considerations

- **Scalability**: Kubernetes allows for scaling the application based on demand.
- **Maintainability**: Modular design with separate configuration files for easy updates.
- **Security**: Use of secrets and config maps to manage sensitive information.
