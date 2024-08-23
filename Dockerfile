FROM maven:3.8.8-eclipse-temurin-17-slim AS build
WORKDIR /app

COPY pom.xml ./
RUN mvn dependency:go-offline -B

COPY src ./src
RUN mvn clean package -DskipTests

FROM eclipse-temurin:17-jdk-slim
WORKDIR /app

COPY --from=build /app/target/HRMS-0.0.1-SNAPSHOT.jar /app/HRMS.jar

EXPOSE 8080

CMD ["java", "-jar", "/app/HRMS.jar"]
