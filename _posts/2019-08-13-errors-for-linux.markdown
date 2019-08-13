---
layout: post-featured
title: "Errors for Linux Ubuntu"
date:   2019-8-13 12:38:27 +0700 
categories: linux
author: mtSiniChi

image: https://www.outsystems.com/-/media/images/case-studies/via-verde-crm-increases-customer-adoption/via-verde-crm-increases-customer-adoption-hero.png
article_description: Collection of errors for Linux.
---

## Ubuntu Loop Loging

Ở màn hình đăng nhập, dù đã nhập đúng password nhưng không thể login vào "desktop", nó lặp lại ở màn hình login.

Giải quyết:

- Vào terminal từ màn hình login: `ctrl + alt + f1`.
- Login vào hệ thống.
- Thực hiện: `sudo mv ~/.Xauthority ~/.Xauthority.bak`.
- Thực hiện: `sudo service lightdm restart`.

Các triệu chứng và điều trị:

- https://www.youtube.com/watch?v=OG4deLa_vK8
- https://askubuntu.com/questions/223501/ubuntu-gets-stuck-in-a-login-loop
- https://www.maketecheasier.com/fix-ubuntu-login-loop/
