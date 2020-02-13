---
layout: post-featured
title: "Cấu hình HTTPS/SSL cho server bằng Nginx và Certbot"
date:   2020-02-13 12:38:27 +0700 
categories: server
author: mtSiniChi

image: /assets/images/via-verde-crm-increases-customer-adoption-hero.png
article_description: Hướng dẫn cấu hình HTTPS/SSL cho server bằng Nginx và Certbot và trỏ tên miền đến server.
---

Bài toán được đưa ra, chúng ta sẽ cấu hình server Linux sử dụng HTTPS/SSL và trỏ tên miền *cbsys.ga* vào port *3000* đang chạy trên server.

## Hướng dẫn

- Cài Nginx:

```bash
$ sudo apt-get update
$ sudo apt-get install nginx
$ sudo nginx -v
$ sudo service nginx status
```

- Cài Cerbot

```bash
$ sudo add-apt-repository ppa:certbot/certbot
$ sudo apt-get update
$ sudo apt-get install python-certbot-nginx

$ apt-get install python3-pyasn1
$ certbot --version
```

- Enable tường lửa để cài đặt rồi tắt liền: `sudo ufw status`, `sudo ufw enable`, nếu không sẽ không truy cập được SSH
- Cấu hình DNS Domain, trỏ domain *cbsys.ga* sang host đang cài đặt Nginx với `Type:A, Name: cbsys.ga`
- Cài SSL với Nginx `sudo certbot --nginx -d cbsys.ga`, xem cấu hình khi cài đặt thành công ở */etc/nginx/sites-enabled/default*
- Sau đó tắt tường lửa, để truy cập lại được SSH nếu thoát ra `sudo ufw disable`
- Vào đường dẫn */etc/nginx/sites-enabled* tạo một file *cbsys.ga* để cấu hình reverse proxy thực hiện mapping tới port *3000*

```text
server {

    	listen 443 ssl;
	    listen [::]:443 ssl;

        ssl_certificate /etc/letsencrypt/live/cbsys.ga/fullchain.pem; # managed by Certbot
    	ssl_certificate_key /etc/letsencrypt/live/cbsys.ga/privkey.pem; # managed by Certbot
    	include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    	ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot

        server_name cbsys.ga;

        location / {

            proxy_set_header        Host $host;
                proxy_set_header        X-Real-IP $remote_addr;
                proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header        X-Forwarded-Proto $scheme;

                # Fix the “It appears that your reverse proxy set up is broken" error.
                proxy_pass          http://localhost:3000;
                proxy_read_timeout  90;

                proxy_redirect      http://localhost:3000 https://cbsys.ga;

        }

}
```

- Sau đó restart lại Nginx để thấy thay đổi: `sudo service nginx restart`

## Tham khảo

- https://www.linode.com/docs/web-servers/nginx/use-nginx-reverse-proxy/#configure-https-with-certbot
- https://www.digitalocean.com/community/tutorials/how-to-set-up-let-s-encrypt-with-nginx-server-blocks-on-ubuntu-16-04
- https://www.godaddy.com/garage/how-to-install-an-ssl-certificate-on-ubuntu-for-nginx/
- https://dzone.com/articles/how-to-install-lets-encrypt-with-nginx-on-ubuntu-1