---
layout: post
title:  "Intellij Import Project Maven Thông Qua Command Line"
 
date:   2019-03-25 23:48:35 +0700
categories: intellij maven
---

Để tiếp kiệm thời gian, chỉ cần `cd` vào project có chứa file *pom.xml*, rồi chạy lệnh `idea pom.xml` sau đó Intellij tự động import project một cách nhanh nhất cho chúng ta.

Mặc định khi cài đặt, Intellij sẽ tự tạo command line laucher sử dụng được trong terminal. Nếu bị lỗi *idea: command not found*  thì mở một project bất kỳ chọn **Tool -> Create Command-line Launcher...** rồi nhập **"/usr/local/bin/idea" -> Okay**.

![intellij-import-project-maven-via-command][1]{:class="img-responsive"}

**Do máy mình đã thiết lặp Command-line Launcher rồi nên mới hiện hộp thông báo hỏi có muốn ghi đè hay không.*

[1]:{{ site.url }}/assets/images/intellij-import-project-maven-via-command.gif