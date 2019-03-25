---
layout: post
title:  "Tạo tập tin Fat Jar từ project Maven"
date:   2019-03-25 21:35:35 +0700
categories: java maven
---

*Bài viết sẽ hướng dẫn tạo ra tập tin Fat Jar từ project Maven bằng việc sử dụng [Maven Shade Plugin][1].*

# Fat Jar là gì

Fat Jar, Uber Jar, Shaded Jar chúng có tên khác nhau nhưng được xem là một. Là một tập tin nén Jar mà trong đó bao gồm tất cả các class file đã được compile, cộng thêm tất cả các dependencies có trong project.

Như vậy, toàn bộ mã nguồn chương trình sẽ được gói gọn trong một file Fat Jar và ta có thể thực thi nhanh chống thông qua command `java -jar name-file-fat-jar.jar`.

# Chuẩn bị mã nguồn

## Cấu trúc project

```text
.
├── pom.xml
└── src
    ├── main
    │   ├── java
    │   │   └── com
    │   │       └── minhtan
    │   │           └── core
    │   │               └── OrderVerticle.java
    │   └── resources
    └── test
        └── java

9 directories, 2 files
```

## File pom.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>test</groupId>
    <artifactId>maven.</artifactId>
    <version>1.0-SNAPSHOT</version>

    <!--<properties>-->
    <!--<jdk.version>1.7</jdk.version>-->
    <!--<jodatime.version>2.5</jodatime.version>-->
    <!--<junit.version>4.11</junit.version>-->
    <!--</properties>-->

    <build>
        <plugins>

            <!-- Set a compiler level -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <configuration>
                    <source>8</source>
                    <target>8</target>
                </configuration>
            </plugin>

            <!--<plugin>-->
            <!--<groupId>org.apache.maven.plugins</groupId>-->
            <!--<artifactId>maven-compiler-plugin</artifactId>-->
            <!--<version>2.3.2</version>-->
            <!--<configuration>-->
            <!--<source>${jdk.version}</source>-->
            <!--<target>${jdk.version}</target>-->
            <!--</configuration>-->
            <!--</plugin>-->


            <!-- Maven Shade Plugin -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-shade-plugin</artifactId>
                <version>2.3</version>
                <executions>
                    <!-- Run shade goal on package phase -->
                    <execution>
                        <phase>package</phase>
                        <goals>
                            <goal>shade</goal>
                        </goals>
                        <configuration>
                            <transformers>
                                <!-- add Main-Class to manifest file -->
                                <transformer
                                        implementation="org.apache.maven.plugins.shade.resource.ManifestResourceTransformer">
                                    <mainClass>com.minhtan.core.OrderVerticle</mainClass>
                                </transformer>
                            </transformers>
                        </configuration>
                    </execution>
                </executions>
            </plugin>

        </plugins>
    </build>

    <dependencies>
        <dependency>
            <groupId>io.vertx</groupId>
            <artifactId>vertx-web</artifactId>
            <version>3.5.0</version>
        </dependency>
    </dependencies>

</project>
```

## Tạo file demo OrderVerticle.java

Trong project này, mình sử dụng thư viện Vert.X để làm ví dụ để thử chạy có dependency, xem thử thi run project có bị lỗi gì không. Mã nguồn *OrderVerticle.java* như bên dưới:

```Java
package com.minhtan.core;

import io.vertx.core.AbstractVerticle;
import io.vertx.core.Vertx;

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

        System.out.println("He nhu u! : build to fat-jar with maven project ");
    }

}
```

# Tạo ra File Jar

Sử dụng command của Maven sẽ tự động tạo ra được file Jar, vào thư mục gốc của project bần build và chạy lệnh bên dưới:

```bash
mvn package

[INFO] Scanning for projects...
[INFO] ------------------------------------------------------------------------
[INFO] Building maven. 1.0-SNAPSHOT
[INFO] ------------------------------------------------------------------------
[INFO]
[INFO] --- maven-resources-plugin:2.6:resources (default-resources) @ maven. ---
[WARNING] Using platform encoding (UTF-8 actually) to copy filtered resources, i.e. build is platform dependent!
[INFO] Copying 0 resource
[INFO]
[INFO] --- maven-compiler-plugin:3.2:compile (default-compile) @ maven. ---
[INFO] Changes detected - recompiling the module!
...
```

Sau khi chạy thành công, có 2 tập tin được tạo ra trong thư mục *target/*:

- maven.-1.0-SNAPSHOT.jar: đây là file Jar chúng ta cần.
- original-maven.-1.0-SNAPSHOT.jar: không cần sử dụng.

# Thực thi file Jar

Hiển thị những class, những dependency có trong file Jar:

```bash
jar tf target/maven.-1.0-SNAPSHOT.jar

com/fasterxml/jackson/databind/util/ViewMatcher.class
META-INF/maven/com.fasterxml.jackson.core/jackson-annotations/
META-INF/maven/com.fasterxml.jackson.core/jackson-annotations/pom.properties
META-INF/maven/com.fasterxml.jackson.core/jackson-annotations/pom.xml
com/fasterxml/jackson/annotation/
com/fasterxml/jackson/annotation/JacksonAnnotation.class
com/fasterxml/jackson/annotation/SimpleObjectIdResolver.class
...
```

Chạy file Jar, cũng như chạy cả project:

```bash
java -jar target/maven.-1.0-SNAPSHOT.jar

> He nhu u! : build to fat-jar with maven project
```

Tải source code: [create-jar-maven.zip][2]

[1]:https://maven.apache.org/plugins/maven-shade-plugin/
[2]:{{ site.url }}/materials/create-jar-maven.zip

## Tham khảo

- https://www.tomitribe.com/blog/tomee-fat-jar-deployments/
- https://www.mkyong.com/maven/create-a-fat-jar-file-maven-shade-plugin/