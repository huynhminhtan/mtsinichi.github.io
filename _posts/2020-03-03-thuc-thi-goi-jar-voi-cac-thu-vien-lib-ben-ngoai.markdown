---
layout: post-featured
title: "Thực thi gói jar với các thư viện lib bên ngoài"
date:   2020-03-03 12:38:27 +0700 
categories: server
author: mtSiniChi

image: /assets/images/via-verde-crm-increases-customer-adoption-hero.png
article_description: Trình IDEA giúp chúng ta rất nhiều khi muốn chạy project Maven hoặc Spring Boot trong quá trình phát triển, nhưng thực tế khi deploy lên môi trường server hay docker project khi đó phải thực thi câu lệnh command line mà không thông qua trình biên dịch. Bài viết sẽ hướng dẫn thực thi tập tin jar bằng command line thông qua 2 cách.
---

Trình IDEA giúp chúng ta rất nhiều khi muốn chạy project Maven hoặc Spring Boot trong quá trình phát triển, nhưng thực tế khi deploy lên môi trường server hay docker project khi đó phải thực thi câu lệnh command line mà không thông qua trình biên dịch. Bài viết sẽ hướng dẫn thực thi tập tin jar bằng command line thông qua 2 cách.

Các bạn có thể xem thêm cách tạo ra file Jar ở bài [Tạo Tập Tin Fat Jar Từ Project Maven]({% link _posts/2019-03-25-tao-file-fat-jar-tu-project-maven.markdown %})

## Câu lệnh

Có 2 cách chạy gói jar:

- Gói jar có cả các thư viện: `java -Dappenv=local -jar xyz.jar`
- Gói jar với thư viện bên ngoài: `java -cp "./xyz.jar:lib/*" -Dappenv=local vn.com.a.b.Main`

## Xem thêm

Gói jar bao gồm các thư viện trong Spring Boot sẽ sử dụng `spring-boot-maven-plugin`:

```xml
...
 <build>
        <resources>
            <resource>
                <directory>conf</directory> <!-- (option) file config -->
            </resource>
        </resources>

        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
                <executions>
                    <execution>
                        <goals>
                            <goal>repackage</goal>
                        </goals>
                        <configuration>
                            <classifier>spring-boot</classifier>
                            <mainClass>${start-class}</mainClass>
                        </configuration>
                    </execution>
                </executions>
            </plugin>
        </plugins>
    </build>
```

Gói jar không bao gồm các thư viện trong nó, mà có thư viện jar nằm trong thư mục *build* sẽ sử dụng thư viện `maven-dependency-plugin`:

```xml
...
<build>
        <resources>
            <resource>
                <directory>conf</directory> <!-- (option) file config -->
            </resource>
        </resources>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-surefire-plugin</artifactId>
                <version>2.22.1</version>
            </plugin>

            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-jar-plugin</artifactId>
                <version>3.0.2</version>
                <configuration>
                    <archive>
                        <manifest>
                            <mainClass>vn.com.a.b.Main</mainClass>
                        </manifest>
                    </archive>
                    <outputDirectory>${project.build.directory}/dist</outputDirectory>
                </configuration>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-dependency-plugin</artifactId>
                <version>3.0.2</version>
                <executions>
                    <execution>
                        <phase>package</phase>
                        <goals>
                            <goal>copy-dependencies</goal>
                        </goals>
                        <configuration>
                            <outputDirectory>${project.build.directory}/dist/lib</outputDirectory>
                        </configuration>
                    </execution>
                </executions>
            </plugin>
        </plugins>
    </build>
```

## Tham khảo

- https://stackoverflow.com/a/1275467