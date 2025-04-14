
## Prerequisites

Before you begin, ensure you have the following installed:

- **Java 17** (or a compatible version)
- **Maven** (for building the project)
- **MySQL** (for the database)
- **Docker & Docker Compose** (optional, for containerization)
- **Jenkins** (optional, for CI/CD pipeline)

## Project Structure

The project includes the following key components:

- `src/main/java`: Contains the Java source code.
- `pom.xml`: Maven configuration file with project dependencies.
- `Dockerfile`: Defines the Docker image for the application.
- `Jenkinsfile`: Specifies the Jenkins pipeline configuration.
- `mysql-deployment.yaml`: Kubernetes deployment configuration for MySQL.
- `app-deployment.yaml`: Kubernetes deployment configuration for the application.

## Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/deepanshuxharry/spring-boot-crud.git
cd spring-boot-crud
```

### 2. Configure the Database

Ensure MySQL is running and create a database:

```sql
CREATE DATABASE productdb;
```


Update the `application.properties` file with your MySQL credentials:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/productdb
spring.datasource.username=your_username
spring.datasource.password=your_password
spring.jpa.hibernate.ddl-auto=update
```

### 3. Build the Application

```bash
mvn clean install
```

### 4. Run the Application

```bash
mvn spring-boot:run
```


The application will start on [http://localhost:8080](http://localhost:8080).

## API Endpoints

The application exposes the following RESTful endpoints:

- **Create Product**

  ```bash
  curl -X POST http://localhost:8080/app/v1/addProduct \
       -H "Content-Type: application/json" \
       -d '{"id":1,"name":"Laptop","quantity":2,"price":80000}'
  ```

- **Retrieve All Products**

  ```bash
  curl http://localhost:8080/app/v1/products
  ```

- **Retrieve Product by ID**

  ```bash
  curl http://localhost:8080/app/v1/product/1
  ```

- **Update Product**

  ```bash
  curl -X PUT http://localhost:8080/app/v1/updateProduct/1 \
       -H "Content-Type: application/json" \
       -d '{"name":"Laptop Pro","quantity":3,"price":90000}'
  ```

- **Delete Product**

  ```bash
  curl -X DELETE http://localhost:8080/app/v1/deleteProduct/1
  ```

## Docker Setup (Optional)

To containerize the application using Docker:

### 1. Build the Docker Image

```bash
docker build -t spring-boot-crud .
```

### 2. Run the Docker Container

```bash
docker run -p 8080:8080 spring-boot-crud
```

## Kubernetes Deployment (Optional)

The project includes Kubernetes manifests for deploying the application and MySQL:

### 1. Deploy MySQL

```bash
kubectl apply -f mysql-deployment.yaml
```

### 2. Deploy the Application

```bash
kubectl apply -f app-deployment.yaml
```


Ensure your Kubernetes cluster is running and configured properly.

## Jenkins Integration (Optional)

For CI/CD integration with Jenkins:

### 1. Install Jenkins Plugins

```bash
wget http://localhost:8080/jnlpJars/jenkins-cli.jar
java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin docker-plugin
```

### 2. Configure Jenkins Pipeline

Use the provided `Jenkinsfile` to set up your Jenkins pipeline.
