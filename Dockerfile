FROM tomcat:9-jdk17-temurin

# Cài ant (nếu vẫn muốn biên dịch Java)
RUN apt-get update && apt-get install -y ant && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy toàn bộ source vào container
COPY . /app

# Compile Java source sang WEB-INF/classes
RUN mkdir -p /app/build/classes \
    && javac -cp "/usr/local/tomcat/lib/servlet-api.jar" \
       -d /app/build/classes $(find src/java -name "*.java")

# Deploy: copy JSP, web.xml và class vào ROOT
RUN mkdir -p /usr/local/tomcat/webapps/ROOT \
    && cp -r "Web Pages/"* /usr/local/tomcat/webapps/ROOT/ \
    && mkdir -p /usr/local/tomcat/webapps/ROOT/WEB-INF/classes \
    && cp -r build/classes/* /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/

EXPOSE 8080

CMD ["catalina.sh", "run"]
