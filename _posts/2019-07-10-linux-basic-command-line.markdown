---
layout: post-featured
title:  "Linux basic command line"
date:   2019-07-10 13:38:27 +0700
categories: linux
author: mtSiniChi

image: https://www.outsystems.com/-/media/images/case-studies/via-verde-crm-increases-customer-adoption/via-verde-crm-increases-customer-adoption-hero.png
article_description: Collection of commands.
---

## Alias

- Add alias `alias jmeter=apache-jmeter-5.1.1/bin/jmeter` to `vim ~/.bashrc` or `vim ~/.zshrc`.
- Then run `source ~/.bashrc`.

## User

- Create user: `sudo useradd <user-name>`.
- Change pass: `sudo passwd <user-name>`.
- Login user: `su <user-name>`.
- Change owner and group of file/folder: `chown [-R] <user-name>:<group> [directory]/<file-name>`. Ex: `sudo chown -R  mtuser:www-data ./apache-activemq-5.15.0`.
- List all users: `cat /etc/passwd`.
- List all group: `cat /etc/group`.

## Git

- Discard change: `git checkout -- env.development.config.ini`.
- Add to .gitignore: `git rm --cached -r ./site/`.
- Store account git: `git config credential.helper store` then `git pull`.
- Verify that the remote URL: `git remote -v`.
- Change your remote's URL: `git remote set-url origin https://github.com/huynhminhtan/repo.git`.
- Branch all branch: `git branch -a`.

## Sort

- Sort by name full info: `ls -l`.
- Sort by last modified: `ls -t`, reverise: `ls -tlr`.
- Sort by file size: `ls -S`.

## Find

- Find by port: `sudo netstat -lpn | grep :8080`.
- Find by name: `sudo ps aux | grep 'firefox'`.

## Ping

- Ping connect by ip and port: `nc -vz localhost 80`.
- Ping connect by ip and port: `telnet localhost 80`.
- Journey package destination: `traceroute localhost 80`.

## Redis

- Login redis cli cluster: `redis-cli -c -p 7000`.
- Get all key: `KEYS *`.

## Maven

- Spring Boot run app: `mvn spring-boot:run`.
- Clean target folder and build: `mvn clean install`.

<br>

---

<br>

## Refers

- User
  - https://www.hostingadvice.com/how-to/change-file-ownershipgroups-linux/
  - http://xahlee.info/linux/linux_users_groups_admin.html
- Sort
  - https://www.lostsaloon.com/technology/how-to-sort-the-output-of-ls-in-linux/
- Alias
  - https://www.tecmint.com/create-alias-in-linux/
