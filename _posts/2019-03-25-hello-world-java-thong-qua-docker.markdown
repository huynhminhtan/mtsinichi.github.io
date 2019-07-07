---
layout: post
title:  "Chương Trình Hello World Bằng Java Thông Qua Docker"
date:   2019-03-25 16:04:35 +0700
categories: java docker
---

Bài viết sẽ hướng dẫn chạy chương trình Java bằng việc sử dụng Docker, từ cách viết Dockerfile, build ứng dụng Java và cuối cùng là chạy thực tế.

## Chuẩn bị đường với muối

Tạo ra cấu trúc thư mục như sau:

```bash
.
├── Dockerfile
├── HelloWorld.java
└── start.sh

0 directories, 3 files
```

Định nghĩa *Dockerfile*:

```Dockerfile
# FROM alpine:latest
FROM openjdk:8

# Thực thi câu lệnh khi built image
# RUN DEBIAN_FRONTEND=noninteractive

# RUN apk --update add openjdk8-jre

# Định nghĩa thư mục CMD trỏ tới
WORKDIR /src

# COPY . /evrun
COPY . .

RUN chmod a+x ./*

# ENTRYPOINT ["/evrun/start.sh"]
ENTRYPOINT ["sh","./start.sh"]

# Port cho container
# EXPOSE 80
```

Tạo tập tin *HelloWorld.java*:

```java
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello, World - mtSiniChi - yoll - hihi");
    }
}
```

Tập tin *start.sh* dùng để build chương trình container:

```bash
#!/bin/sh
echo "Workspace dir: " $PWD
# pwd
# ls
# cat HelloWorld.java
javac HelloWorld.java
java HelloWorld
# exec $@
```

## Bắt đầu kho thịt

Build container tên *java-hello*:

```bash
docker build -t java-hello .
```

Chạy container để xem kết quả:

```bash
docker run java-hello
```

## Ăn no lăn co ra ngủ

Kết quả:

```bash
$ docker run java-hello
Workspace dir:  /src
Hello, World - mtSiniChi - yoll - hihi
```

Tải source code: [docker-java-hello.zip][1]

[1]:{{ site.url }}/materials/docker-java-hello.
