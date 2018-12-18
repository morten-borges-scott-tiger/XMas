FROM anapsix/alpine-java:8
VOLUME /tmp
COPY target/Elf-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]