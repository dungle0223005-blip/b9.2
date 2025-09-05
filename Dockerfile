# Base image: Tomcat 9 + JDK 17
FROM tomcat:9-jdk17-temurin

# Install ant
RUN apt-get update && apt-get install -y ant && rm -rf /var/lib/apt/lists/*

# Workdir trong container
WORKDIR /app

# Copy toàn bộ source project vào container
COPY . /app

# Build WAR bằng Ant
RUN ant clean dist

# Copy WAR sang thư mục deploy của Tomcat
RUN cp dist/*.war /usr/local/tomcat/webapps/

# Expose cổng Tomcat
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
