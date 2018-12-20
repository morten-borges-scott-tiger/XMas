FROM anapsix/alpine-java:8
VOLUME /tmp
COPY target/Elf-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","/app.jar"]