FROM maven:3.9.5-eclipse-temurin-17 AS build
WORKDIR /app
COPY pom.xml .
COPY common ./common
COPY rest-api ./rest-api
COPY soap-api ./soap-api
COPY graphql-api ./graphql-api
COPY grpc-api ./grpc-api
COPY main-application ./main-application
RUN mvn clean package -DskipTests

FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=build /app/main-application/target/*.jar app.jar
EXPOSE 8080 9090
ENTRYPOINT ["java", "-jar", "app.jar"]
