### BUILD image
FROM maven:3-eclipse-temurin-17 AS builder
RUN mkdir -p /build
WORKDIR /build

# copiamos el pom.xml
COPY . .
# instalamos las dependencias
RUN mvn -B dependency:resolve dependency:resolve-plugins
#copiar el codigo fuente
COPY src /build/src
# construimos la aplicación
RUN mvn clean package -DskipTests

# Dockerfile para la aplicación Spring Boot (Java 17)
FROM openjdk:17
WORKDIR /app
#el nombre corto1 es el configurado en el pom.xml
COPY --from=builder /build/target/corto1.jar java-app.jar

EXPOSE 8080
ENTRYPOINT [ "java", "-jar", "java-app.jar" ]