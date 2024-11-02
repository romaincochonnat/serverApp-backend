# Étape 1 : Utiliser une image Maven pour construire le projet
FROM maven:3.8.6-openjdk-17 AS build

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers pom.xml et src pour le build
COPY pom.xml .
COPY src ./src

# Construire l’application
RUN mvn clean install -DskipTests

# Étape 2 : Utiliser une image JDK pour exécuter l'application
FROM openjdk:17-jdk-slim

# Définir le répertoire de travail
WORKDIR /app

# Copier le fichier JAR construit depuis l’étape de build
COPY --from=build /app/target/*.jar app.jar

# Exposer le port 8080 (ou autre si nécessaire)
EXPOSE 8080

# Démarrer l’application
ENTRYPOINT ["java", "-jar", "app.jar"]
