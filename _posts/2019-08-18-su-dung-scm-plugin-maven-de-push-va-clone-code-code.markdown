---
layout: post-featured
title:  "Sử dụng SCM plugin Maven push và clone souce code từ Git"
date:   2019-07-10 13:38:27 +0700
categories: linux
author: mtSiniChi

image: /assets/images/via-verde-crm-increases-customer-adoption-hero.png
article_description: Với tính tiện lợi, Maven SCM Plugin hỗ trợ kết nối, tương tác với nhiều loại SCM (source code management), cũng như cung cấp một số lệnh có thể thao tác nhanh thay vì sử dụng các lệnh git thông thường.
---

Tập tin *pom.xml* của Maven.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>org.springframework</groupId>
    <artifactId>gs-centralized-configuration</artifactId>
    <version>0.1.0</version>
    <packaging>pom</packaging>

    <scm>
        <connection>scm:git:https://github.com/mtsinichi/spring-cloud-configs.git</connection>
        <developerConnection>scm:git:https://github.com/mtsinichi/spring-cloud-configs.git</developerConnection>
        <url>https://github.com/mtsinichi/spring-cloud-configs</url>
    </scm>

    <modules>
        <module>order-management-service</module>
        <module>configuration-service</module>
        <module>user-management-service</module>
    </modules>

    <properties>
        <checkout.basedir>${basedir}/clone</checkout.basedir>
    </properties>

    <build>
        <plugins>

            <!-- git repository -->
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-scm-plugin</artifactId>
                <version>1.9.5</version>
                <configuration>
                    <checkoutDirectory>${basedir}/core</checkoutDirectory>
                    <connectionType>url</connectionType>
                    <basedir>${basedir}</basedir>
                    <workingDirectory>${basedir}</workingDirectory>
                </configuration>
                <executions>
                    <execution>
                        <id>git-pull-mvn</id>
                        <goals>
                            <goal>checkout</goal>
                        </goals>
                        <!--<phase>validate</phase>-->
                    </execution>

                    <execution>
                        <id>git-push-mvn</id>
                        <goals>
                            <goal>checkin</goal>
                        </goals>
                        <!--<phase>validate</phase>-->
                    </execution>
                </executions>
            </plugin>

        </plugins>
    </build>

</project>
```
