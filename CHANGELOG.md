# Changelog

All notable changes to this project are documented in this file.



### Overview

This release refactors and extends the original [Java-Techie Spring Boot CRUD Example](https://github.com/Java-Techie-jt/spring-boot-crud-example) into a production-ready, containerized application with CI/CD and Kubernetes support.

### Changed
- Refactored package structure and naming to align with the new project (`moonridert1`) context.
- Reorganized project folders for better modularity.

### Added
- `Dockerfile` for containerization.
- `Jenkinsfile` for CI/CD automation.
- Kubernetes manifests for deploying the app and MySQL database (`Deployment`, `Service`, `Ingress`, `ConfigMap`, `Secrets`).
- `SYSTEM_DESIGN.md` for architectural overview.
- Shell scripts for Jenkins and Java setup.


