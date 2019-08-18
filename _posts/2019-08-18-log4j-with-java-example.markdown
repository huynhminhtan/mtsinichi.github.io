---
layout: post-featured
title:  "Implement Log4j2 with Java"
date:   2019-07-10 13:38:27 +0700
categories: linux
author: mtSiniChi

image: /assets/images/via-verde-crm-increases-customer-adoption-hero.png
article_description: Java implement Log4j2 quickly in project Maven.
---

Hiện thực Log4j2 trong project Maven, gói ghém chỉ qua 3 bước như bên dưới.

Step1: Thêm dependencies vào *pom.xml*:

```xml
<dependency>
    <groupId>org.apache.logging.log4j</groupId>
    <artifactId>log4j-api</artifactId>
    <version>2.6.1</version>
</dependency>
<dependency>
    <groupId>org.apache.logging.log4j</groupId>
    <artifactId>log4j-core</artifactId>
    <version>2.6.1</version>
</dependency>
```

Step2: Tạo tập tin cấu hình *resources/log4j2.xml*:

{% raw %}

```xml
<?xml version="1.0" encoding="UTF-8"?>
<Configuration name="systemConfiguration" schema="http://jakarta.apache.org/log4j2/">
    <Properties>
        <Property name="log-path">log</Property>
        <Property name="log-name">conv</Property>
    </Properties>
    <Appenders>
        <Console name="console-appender" target="STDOUT">
            <PatternLayout>
                <pattern>
                    <!--%highlight{[%-5level] %d{yyyy-MM-dd HH:mm:ss.SSS} [%t] %c{1} -
                     %msg%n}-->
                    <!--[%-5level] %d{yyyy-MM-dd HH:mm:ss.SSS} [%t] %c{1} - %msg%n-->
                    %highlight{%d{HH:mm:ss.SSS} %-5level %logger{36}.%M() @%L - %msg%n}
                    {FATAL=red, ERROR=red, WARN=yellow, INFO=black, DEBUG=green, 
                    TRACE=blue}
                </pattern>
            </PatternLayout>
        </Console>

        <RollingFile name="file-logger" fileName="${log-path}/${log-name}.log"
                     filePattern="${log-path}/${log-name}-%d{yyyy-MM-dd}.log">
            <PatternLayout>
                <pattern>[%-5level] %d{yyyy-MM-dd HH:mm:ss.SSS} 
                [%t] %c{1} - %msg%n</pattern>
            </PatternLayout>
            <Policies>
                <TimeBasedTriggeringPolicy interval="1" modulate="true"/>
            </Policies>
        </RollingFile>

    </Appenders>
    <Loggers>
        <Root level="INFO">
            <AppenderRef ref="console-appender" level="INFO"/>
            <AppenderRef ref="file-logger" level="INFO"/>
        </Root>
    </Loggers>
</Configuration>
```

{% endraw %}

Step3: Ghi log bằng code Java:

```java
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class Application {
    private static final Logger logger = LogManager.getLogger(Application.class);

    public static void main(String[] args){
        logger.info("Hello log quickly.");
        logger.warn("Hello log quickly again.");
    }
}
```

Thêm: Loggin Level

![logs-level][1]{:class="img-responsive"}

<br>

---

<br>

Refers

- https://stackoverflow.com/q/21979699/9488752 :: add color to log console
- https://stackoverflow.com/questions/21206993/very-simple-log4j2-xml-configuration-file-using-console-and-file-appender
- https://howtodoinjava.com/log4j2/log4j-2-xml-configuration-example/

[1]:{{ site.url }}/assets/images/logs.jpeg
