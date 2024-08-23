# Use an official Maven image to build the project
FROM maven:3.8.8-openjdk-17-slim AS build
WORKDIR /app

# Copy the pom.xml and download dependencies
COPY pom.xml ./
RUN mvn dependency:go-offline -B

# Copy the source code and build the project
COPY src ./src
RUN mvn clean package -DskipTests

# Use a lightweight OpenJDK image to run the application
FROM openjdk:17-jdk-slim
WORKDIR /app

# Copy the built JAR from the previous stage
COPY --from=build /app/target/HRMS-0.0.1-SNAPSHOT.jar /app/HRMS.jar

# Expose the application port
EXPOSE 8080

# Command to run the application
CMD ["java", "-jar", "/app/HRMS.jar"]
