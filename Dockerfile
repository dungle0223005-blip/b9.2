# Stage 1: Build with Ant
FROM openjdk:17-jdk-slim AS build

# Cài Ant
RUN apt-get update && apt-get install -y ant && rm -rf /var/lib/apt/lists/*

# Copy source code vào container
WORKDIR /app
COPY . .

# Build WAR
RUN ant clean dist-war

# Stage 2: Runtime with Tomcat
FROM tomcat:9.0-jdk17

# Xóa ứng dụng mặc định của Tomcat (ROOT)
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR từ stage build sang Tomcat
COPY --from=build /app/dist/ch09_ex2_cart.war /usr/local/tomcat/webapps/ROOT.war

# Expose port
EXPOSE 8080

# Chạy Tomcat
CMD ["catalina.sh", "run"]
