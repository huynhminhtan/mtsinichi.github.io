---
layout: post-featured
title:  "Sử dụng SCM plugin Maven push và clone souce code từ Git"
date:   2019-07-10 13:38:27 +0700
categories: linux
author: mtSiniChi

image: /assets/images/via-verde-crm-increases-customer-adoption-hero.png
article_description: Với tính tiện lợi, Maven SCM Plugin hỗ trợ kết nối, tương tác với nhiều loại SCM (source code management), cũng như cung cấp một số lệnh có thể thao tác nhanh thay vì sử dụng các lệnh git thông thường.
---

Với tính tiện lợi, [Maven SCM Plugin][2] hỗ trợ kết nối, tương tác với nhiều loại SCM (source code management), cũng như cung cấp một số lệnh có thể thao tác nhanh thay vì sử dụng các lệnh git thông thường. Maven SCM Plugin hỗ trợ nhiều lệnh và nhiều mục đích, có 2 loại goals thường hay sử dụng như:

- checkin: commit các thay đổi lên repository.
- checkout: clone source code trên repository.

Chúng ta sẽ đi qua hiện thực từng goal. Chỉ thao tác với tập tin *pom.xml* mà không cần sửa đổi tập tin nào khác.

## SCM:checkin

Thực hiện tổng hợp các lệnh git add, git commit, git push lên repository. Thêm 1 plugin trong *pom.xml* của project Maven. Trong tag `<configuration>` có thuộc tính `<connectionType>` dùng để khai báo địa chỉ repository Git. Xem thêm các thuộc tính của goal *scm:checkin* tại [Optional Parameters scm:checkin][3].

Chạy lệnh Maven: `mvn scm:checkin -Dmessage="message commit source code"`.

```xml
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-scm-plugin</artifactId>
    <version>1.9.5</version>
    <configuration>
        <connectionType>url</connectionType>
        <basedir>${basedir}</basedir>
        <workingDirectory>${basedir}</workingDirectory>
    </configuration>
    <executions>
        <execution>
            <id>git-push-mvn</id>
            <goals>
                <goal>checkin</goal>
            </goals>
            <!--<phase>validate</phase>-->
        </execution>
    </executions>
</plugin>
```

## SCM:checkout

Thực hiện công việc clone (không phải pull) souce code trên repository về. Trong tag `<configuration>` có thuộc tính `<checkoutDirectory>` dùng để chỉ định thư mục sẽ lưu trữ source code được clone từ repository về, nếu không khai báo mặc định sẽ lưu trong *target/checkout/*. Xem thêm các thuộc tính của goal *scm:checkout* tại [Optional Parameters scm:checkout][4].

Chạy lệnh Maven: `mvn scm:checkout`.

```xml
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-scm-plugin</artifactId>
    <version>1.9.5</version>
    <configuration>
        <checkoutDirectory>${basedir}/core</checkoutDirectory>
        <connectionType>url</connectionType>
        <basedir>${basedir}</basedir>
    </configuration>
    <executions>
        <execution>
            <id>git-pull-mvn</id>
            <goals>
                <goal>checkout</goal>
            </goals>
            <!--<phase>validate</phase>-->
        </execution>
    </executions>
</plugin>
```

## Source code

Xem toàn bộ *pom.xml* ví dụ tại [pom.xml]({{ site.baseurl }}{% link _posts/2019-08-18-su-dung-scm-plugin-maven-de-push-va-clone-code-code.markdown %})

<br>

---

<br>

Tham khảo

- https://maven.apache.org/scm/maven-scm-plugin/plugin-info.html
- https://stackoverflow.com/a/10147826/9488752

[2]:https://maven.apache.org/scm/maven-scm-plugin/index.html
[3]:https://maven.apache.org/scm/maven-scm-plugin/checkin-mojo.html
[4]:https://maven.apache.org/scm/maven-scm-plugin/checkout-mojo.html
