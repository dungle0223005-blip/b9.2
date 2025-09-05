FROM tomcat:9-jdk17-temurin

RUN apt-get update && apt-get install -y ant && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . /app

# Quan trọng: build.xml phải ở /app và có src/java + Web Pages
RUN ant clean dist

RUN cp dist/*.war /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["catalina.sh", "run"]
