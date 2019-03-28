---
layout: post
title:  "Sử Dụng Network Trong Docker"
date:   2019-03-25 16:04:35 +0700
categories: java docker
---

Bài viết sẽ mô tả cách sử dụng network thông qua đó các container có thể giao tiếp được với nhau.

Mình sẽ lấy ví dụ, tạo một ứng dụng hiện thực việc thêm và lấy dữ liệu từ Redis, trong dự án có sử dụng VertX mục đích là thêm một dependency cho project nó bự bự ra ấy mà.

Mình đã có project Maven, để có thể chạy trên Docker cho toàn bộ từ source code cho đến Redis, ta sẽ tiến hành các bước sau:

- Build project Maven thành tập tin Fat Jar.
- Xây dựng Dockerfile dựa trên Fat Jar bước trước để tạo container thực thi phần source code.
- Viết *docker-compose.yml* để kết nối các container lại với nhau.

Trong bài này, mình chỉ đề cập đến phần Dockerfile và docker-compose có sử dụng docker network để các containers/ services tương tác qua lại.

# Tạo Dockerfile từ Fat Jar có sẵn

```dockerfile
# Dockerfile
FROM openjdk:8-jre-alpine

ENV VERTICLE_FILE maven.-1.0-SNAPSHOT.jar

# Set the location of the verticles
ENV VERTICLE_HOME /usr/verticles

EXPOSE 8080

# Copy your fat jar to the container
COPY ./target/$VERTICLE_FILE $VERTICLE_HOME/

# Launch the verticle
WORKDIR $VERTICLE_HOME
ENTRYPOINT ["sh", "-c"]
CMD ["exec java -jar $VERTICLE_FILE"]
```

# Viết Docker Compose để kết nối các container

## Không định nghĩa network

```yml
# docker-compose.yml
version: '3'
services:
  app:
    build: .
    ports:
      - "8080:8080"
    depends_on:
      - redis_db

  redis_db:
    image: "redis:alpine"
    ports:
      - "6381:6379"
```

Nếu không định nghĩa network, khi chạy lệnh `docker-compose up` Docker sẽ tự động tạo ra một network có tên là *[tên-thư-mục]_default*, để kiểm tra mình chạy lệnh `docker network ls`, vì project mình nằm trong thư mục có tên là *maven-docker-network* nên dòng thứ 5 một network mới có thêm *_default* được tạo ra:

```bash
➜ maven-docker-network:✗ docker network ls

NETWORK ID          NAME                           DRIVER              SCOPE
8941d3b2ef59        bridge                         bridge              local
3a5d1ba57867        composetest_default            bridge              local
727484192e4c        host                           host                local
062bd6240da9        kafka-net                      bridge              local
8b90584145d2        maven-docker-network_default   bridge              local
cfd4ef8c1000        none                           null                local
```

Sẽ tiến hành kiểm tra network này bằng lệnh `docker network inspect [NETWORK-ID]/[NAME]`:

```bash
➜ maven-docker-network:✗ docker network inspect 8b90584145d2
[
    {
        "Name": "maven-docker-network_default",
        "Id": "8b90584145d2ba53a842e26eb490ef49ab50cee63e970e884e152a735e90697c",
        "Created": "2019-03-27T13:23:58.554917217+07:00",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": null,
            "Config": [
                {
                    "Subnet": "172.20.0.0/16",
                    "Gateway": "172.20.0.1"
                }
            ]
        },
        "Internal": false,
        "Attachable": true,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {
            "8123500b8cbceb75c4849278418be2cddd5d5aca319401b893ff19071099efec": {
                "Name": "maven-docker-network_app_1",
                "EndpointID": "41377dc0811b2a2f55c745518267562d14dec2f58bc4c60722a1cd6a06c51218",
                "MacAddress": "02:42:ac:14:00:03",
                "IPv4Address": "172.20.0.3/16",
                "IPv6Address": ""
            },
            "cf38661571216d9f19d50473bf7e44a167be159ff198213801fe505c94a74701": {
                "Name": "maven-docker-network_redis_db_1",
                "EndpointID": "5502446b77efb64587f0618f0701d8a4f5e7ff7c0de07ed16da3e543a9d407f0",
                "MacAddress": "02:42:ac:14:00:02",
                "IPv4Address": "172.20.0.2/16",
                "IPv6Address": ""
            }
        },
        "Options": {},
        "Labels": {
            "com.docker.compose.network": "default",
            "com.docker.compose.project": "maven-docker-network",
            "com.docker.compose.version": "1.23.2"
        }
    }
]
```

Ở trên có 2 container *maven-docker-network_app_1* và *maven-docker-network_redis_db_1* nằm trong network này khi chạy `docker-compose up`.

Còn ở phần code, để có thể sử kết nối với Redis ta sẽ sử dụng chuỗi kết nối là *redis://redis_db:6379*, với *redis_db* là tên kết nối giống với tên của container định nghĩa ở *docker-compose.yml* và sử dụng CONTAINER_PORT mặc định của Redis là 6379.

```java
// OrderVerticle.java
package com.minhtan.core;

import io.vertx.core.AbstractVerticle;
import io.vertx.core.Vertx;
import org.redisson.Redisson;
import org.redisson.api.RList;
import org.redisson.api.RedissonClient;
import org.redisson.config.Config;

public class OrderVerticle extends AbstractVerticle {

    private static Vertx vertx = null;

    public static Vertx getInstanceVertX() {

        if (vertx == null) {
            vertx = Vertx.vertx();
            vertx.deployVerticle(new OrderVerticle());
        }

        return vertx;
    }

    public static void main(String[] args) {
        Vertx vertx = getInstanceVertX();
        vertx.deployVerticle(new OrderVerticle());

        Config config = new Config();
        // connect to Redis
        config.useSingleServer().setAddress("redis://redis_db:6379");
        RedissonClient redisson = Redisson.create(config);

        RList<String> list = redisson.getList("mylist");

        list.add("aaaaaaaaaa");
        System.out.println("Add 'aaaaaaaaaa' to Redis");
        list.add("bbbbbbbbbb");
        System.out.println("Add 'bbbbbbbbbb' to Redis");
        list.add("cccccccccc");
        System.out.println("Add 'cccccccccc' to Redis");

        System.out.println("Get list[0],[1],[2],[3] from Redis: ");
        System.out.println(list.get(0));
        System.out.println(list.get(1));
        System.out.println(list.get(2));
        System.out.println(list.get(3));
        System.out.println("Get done!");
    }
}
```

Mình có viết *auto.sh* để tổng hợp các script, kết quả cuối cùng:

```bash
➜ maven-docker-network:✗ ./auto.sh

redis_db_1  | 1:M 28 Mar 2019 02:31:48.307 * Ready to accept connections
app_1       | log4j:WARN No appenders could be found for logger (io.netty.util.internal.logging.InternalLoggerFactory).
app_1       | log4j:WARN Please initialize the log4j system properly.
app_1       | log4j:WARN See http://logging.apache.org/log4j/1.2/faq.html#noconfig for more info.
app_1       | Add 'aaaaaaaaaa' to Redis
app_1       | Add 'bbbbbbbbbb' to Redis
app_1       | Add 'cccccccccc' to Redis
app_1       | Get list[0],[1],[2],[3] from Redis:
app_1       | aaaaaaaaaa
app_1       | bbbbbbbbbb
app_1       | cccccccccc
app_1       | null
app_1       | Get done!
```

## Định nghĩa network

Mình có tạo ra một network tên là *app-net* khi thực thi các container *app* và *redis_db* sẽ được nằm trong network này.

```yml
version: '3'

networks:
  app-net:
    driver: bridge

services:
  app:
    build: .
    ports:
      - "8080:8080"
    depends_on:
      - redis_db
    networks:
      - app-net

  redis_db:
    image: "redis:alpine"
    ports:
      - "6381:6379"
    networks:
      - app-net
```

Tên của network thay vì có *_default* thì sẽ thay bằng *_app-net*:

```bash
➜  maven-docker-network:✗ docker network ls

NETWORK ID          NAME                           DRIVER              SCOPE
8941d3b2ef59        bridge                         bridge              local
3a5d1ba57867        composetest_default            bridge              local
727484192e4c        host                           host                local
062bd6240da9        kafka-net                      bridge              local
e5173c05ca34        maven-docker-network_app-net   bridge              local
8b90584145d2        maven-docker-network_default   bridge              local
cfd4ef8c1000        none                           null                local

```

Chuỗi kết nối đến Redis cũng không thay đổi, vẫn là *redis://redis_db:6379*.

# Tài nguyên

Tải source cho toàn bộ từ project Java Maven, Dockerfile và Docker Compose: [maven-docker-network.zip][1]

Chạy bằng lệnh `./auto.sh`, mình viết nó để chạy một lệnh cho tất cả các công việc:

```bash
# auto.sh
mvn clean
mvn package
docker rm $(docker ps -a -q)

# docker-compose build --no-cache
# docker-compose up --force-recreate
docker-compose build
docker-compose stop
docker-compose rm -f
docker-compose up
```

# Thanks a million for

- https://vsupalov.com/docker-compose-runs-old-containers/
- https://stackoverflow.com/questions/44705455/after-docker-compose-build-the-docker-compose-up-run-old-not-updated-containers

[1]:{{ site.url }}/materials/maven-docker-network.zip