# Build stage
FROM maven:3.8.6-eclipse-temurin-8-alpine as builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Runtime stage
FROM eclipse-temurin:8-jre-alpine
WORKDIR /app
COPY --from=builder /app/target/spring-boot-crud-example-2-0.0.1-SNAPSHOT.jar springboot-crud-k8s.jar
EXPOSE 9191
ENTRYPOINT ["java","-jar","springboot-crud-k8s.jar"]