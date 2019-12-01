---
layout: post-featured
title: "Cách trỏ domain vào port của trên server bằng Nginx"
date:   2019-12-01 12:38:27 +0700 
categories: webserver
author: mtSiniChi

image: /assets/images/via-verde-crm-increases-customer-adoption-hero.png
article_description: Bài viết sẽ hướng dẫn các bạn trỏ domain vào port đang chạy trên server bằng việc sử dụng Ngnix và cách cấu hình DNS domain.
---

## Tổng quan

Nếu bạn đã từng vọc vạch mua một domain và shared hosting để chạy demo một trang web, khi đó bạn có thể dễ dàng trỏ một domain vào hosting hoặc thêm nhiều domain (addon domain) vào hosting hoặc thêm tên miền con (sub domain) vào hosting đó. Và đương nhiên mỗi domain, sub domain, addon domain mà bạn thêm vào cũng dễ dàng chỉ định cho khớp với thư mục lưu trữ source code thực thi tương ứng. Có được điều này là do shared hosting bạn sử dụng đã tích hợp hệ thống quản trị *Control Panel Server* nổi tiếng với mấy cái tên quen thuộc Cpanel 11, Sentora, VistaCP.

Mà shared hosting lại có sự giới hạn riêng của nó, một khi chạm tới ngưỡng bạn bắt buộc chuyển sang chạy trên server, có thể xem như *một bầu trời to lớn dành cho một cao nhận vĩ đại*. Trên thực tế server sẽ chạy ở rất nhiều port mà mỗi port đại diện cho một service riêng, để giảm sự lằn nhằn nhớ số ip, port hoặc tạo sự dễ dàng một khi ip server thay đổi và cuối cùng phương án sử dụng domain là điều rất cần thiết. Tới lúc này, vấn đề thật sự được đặt ra là làm thế nào để trỏ domain, sub domain, addon domain vào các port tương ứng đang chạy trên server.

Bài viết sau sẽ hướng dẫn các bạn trỏ domain vào port đang chạy trên server bằng việc sử dụng Ngnix và cách cấu hình DNS domain.

## Các bước thực hiện

Lấy một ví dụ, chúng ta muốn thêm một domain *minhtan.me* vào server Ubuntu 16.4 có IP là *45.252.121.7*, và đây là kết quả chi tiết cho ví dụ trong bài viết này:

- Nhập *minhtan.me* trỏ đến *45.252.121.7:80*. (service Welcome)
- Nhập *dashboard.minhtan.me* trỏ đến *45.252.121.7:3000*. (service Grafana)
- Nhập *dev.minhtan.me* trỏ đến *45.252.121.7:9090*. (service Java web)

Các bước thực hiện như sau:

- Đầu tiên, cấu hình DNS cho domain với trường như bên dưới:

| Type 	| Name       	| Content      	|
|------	|------------	|--------------	|
| A    	| minhtan.me 	| 45.252.121.7 	|  
| A    	| dashboard  	| 45.252.121.7 	|
| A    	| dev        	| 45.252.121.7 	|

- Cài đặt Nginx.

```bash
$ sudo apt-get update
$ sudo apt-get install nginx
$ sudo nginx -v
```

- Cấu hình Nginx, tạo một tập tin cấu hình *domain.config* trong */etc/nginx/sites-available/domain.config* có nội dung như sau:

```text
# /etc/nginx/sites-available/domain.config
server {
    listen 80;
    server_name minhtan.me;

    location / {
        proxy_pass http://localhost;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}

server {
    listen 80;
    server_name dashboard.minhtan.me;

    location / {
        proxy_pass http://localhost:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}

server {
    listen 80;
    server_name dev.minhtan.me;

    location / {
        proxy_pass http://localhost:9090;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

- Thực hiện restart lại Nginx bằng câu lệnh:

```bash
$ sudo ln -s /etc/nginx/sites-available/domain.config /etc/nginx/sites-enabled/domain.config # link to sites-enabled/
$ sudo service nginx configtest # test config but dont kill current state
$ sudo service nginx restart
```

- Thưởng thức thành quả, vào *dashboard.minhtan.me* thấy ngay trang Grafana, vào *dev.minhtan.me* thấy website java đang chạy, cuối cùng vào *minhtan.me* thấy chữ **Welcome to mtSiniChi** to đùng hiện ra.

Mách nhỏ, bạn có thể sử dụng combo là *Vultr, NameCheap/Freenom, Cloudflare, Nginx*. Vậy là kể từ đây tha hồ cấu hình domain rồi. Happily!

## Tham khảo

- https://askubuntu.com/a/69751
- https://serverfault.com/a/187026
- https://www.digitalocean.com/community/questions/how-do-i-point-my-custom-domain-to-my-ip-port-41-111-20-36-8080
- http://nginx.org/en/docs/http/server_names.html
