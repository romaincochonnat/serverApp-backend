# Étape 1 : Construire l'application avec Maven
FROM openjdk:19-jdk AS build
WORKDIR /app

# Copier les fichiers nécessaires pour la compilation
COPY pom.xml .
COPY src src
COPY mvnw .
COPY .mvn .mvn

# Donner la permission d'exécution au wrapper Maven
RUN chmod +x ./mvnw
RUN ./mvnw clean package -DskipTests

# Étape 2 : Créer l'image finale pour l'application Spring Boot
FROM openjdk:19-jdk
WORKDIR /app

# Copier le fichier JAR généré depuis l'étape de build
COPY --from=build /app/target/*.jar app.jar

# Exécuter l'application
ENTRYPOINT ["java", "-jar", "/app/app.jar"]

# Exposer le port
EXPOSE 8080