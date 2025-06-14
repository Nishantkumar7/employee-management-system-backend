# -------- Build Stage --------
FROM maven:3.9.6-eclipse-temurin-17 AS builder
WORKDIR /app
COPY . .
RUN chmod +x mvnw && ./mvnw clean package -DskipTests

# -------- Runtime Stage --------
FROM eclipse-temurin:17-jdk
WORKDIR /app
COPY --from=builder /app/target/employeemanager-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
