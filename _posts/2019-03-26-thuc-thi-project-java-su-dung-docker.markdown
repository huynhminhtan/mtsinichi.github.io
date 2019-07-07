---
layout: post
title:  "Thực Thi Project Java Sử Dụng Docker"
date:   2019-03-26 00:25:35 +0700
categories: java docker
author: mtSiniChi
---

Để thực thi project Java thông qua Docker có nhiều cách, trong đó sử dụng file Fat Jar là một cách đơn giản.

Từ project ban đầu, các bạn phải tạo ra file Fat Jar, xem thêm cách tạo ra file Jar: [Tạo Tập Tin Fat Jar Từ Project Maven]({% link _posts/2019-03-25-tao-file-fat-jar-tu-project-maven.markdown %})

# Cấu trúc thư mục

```text
.
├── dependency-reduced-pom.xml
├── deploymavendocker.iml
├── Dockerfile
├── pom.xml
├── src
│   ├── main
│   │   ├── java
│   │   │   └── com
│   │   │       └── minhtan
│   │   │           └── core
│   │   │               └── OrderVerticle.java
│   │   └── resources
│   └── test
│       └── java
└── target
    ├── classes
    │   └── com
    │       └── minhtan
    │           └── core
    │               └── OrderVerticle.class
    ├── generated-sources
    │   └── annotations
    ├── maven.-1.0-SNAPSHOT.jar
    ├── maven-archiver
    │   └── pom.properties
    ├── maven-status
    │   └── maven-compiler-plugin
    │       ├── compile
    │       │   └── default-compile
    │       │       ├── createdFiles.lst
    │       │       └── inputFiles.lst
    │       └── testCompile
    │           └── default-testCompile
    │               └── inputFiles.lst
    └── original-maven.-1.0-SNAPSHOT.jar

23 directories, 12 files
```

# Xây dựng Dockerfile

```dockerfile
FROM openjdk:8-jre-alpine

# Set file Jar need execute
ENV VERTICLE_FILE maven.-1.0-SNAPSHOT.jar

# Set the location of the verticles
ENV VERTICLE_HOME /usr/verticles

EXPOSE 8080

# Copy your fat jar to the container
COPY target/$VERTICLE_FILE $VERTICLE_HOME/

# Launch the verticle
WORKDIR $VERTICLE_HOME
ENTRYPOINT ["sh", "-c"]
CMD ["exec java -jar $VERTICLE_FILE"]
```

# Build và Run container

Build với tên *sample/deploy-java-fat*:

```bash
docker build -t sample/deploy-java-fat .
```

Run container, chiêm ngưỡng thành quả:

```bash
docker run -t -i -p 8080:8080 sample/deploy-java-fat
```

# Source code

Tải source code: [deploy-maven-vertx-docker.zip][1]

# Tham khảo

https://vertx.io/docs/vertx-docker/#_deploying_a_fat_jar

[1]:{{ site.url }}/materials/deploy-maven-vertx-docker.zip