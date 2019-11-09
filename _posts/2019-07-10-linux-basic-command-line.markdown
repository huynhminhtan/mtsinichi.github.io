---
layout: post-featured
title:  "Linux basic command line"
date:   2019-07-10 13:38:27 +0700
categories: linux
author: mtSiniChi

image: /assets/images/via-verde-crm-increases-customer-adoption-hero.png
article_description: Collection of commands.
---

## Alias

- Add alias: `alias jmeter=apache-jmeter-5.1.1/bin/jmeter` to `vim ~/.bashrc` or `vim ~/.zshrc` then run `source ~/.bashrc`.

## Path

- Add path: `echo 'export PATH="/usr/local/opt/ruby/bin:$PATH"' >> ~/.zshrc` then `source ~/.zshrc` or reopen terminal to take affect.

## User

- Create user: `sudo useradd <user-name>`.
- Change pass: `sudo passwd <user-name>`.
- Login user: `su <user-name>`.
- Change owner and group of file/folder: `chown [-R] <user-name>:<group> [directory]/<file-name>`. Ex: `sudo chown -R  mtuser:www-data ./apache-activemq-5.15.0`.
- List all users: `cat /etc/passwd`.
- List all group: `cat /etc/group`.

## Git

- Discard change: `git checkout -- env.development.config.ini`.
- Drop all local changes and commits: `git fetch origin` then `git reset --hard origin/master`.
- Add to .gitignore: `git rm --cached -r ./site/`.
- Store account git: `git config credential.helper store` then `git pull`.
- Where credential store: `vi ~/.git-credentials`.
- Verify that the remote URL: `git remote -v`.
- Change your remote's URL: `git remote set-url origin https://github.com/huynhminhtan/repo.git`.
- Show all branch: `git branch -a`.
- Edit config: `git config --edit`.

## Sort

- Sort by name full info: `ls -l`.
- Sort by last modified: `ls -t`, reverise: `ls -tlr`.
- Sort by file size: `ls -S`.

## Scp

- Upload file from local to server: `scp ~/assets/foodorder.json root@45.77.174.39:/root/foodorder.json` then press password.

## Find

- Find by port: `lsof -i :8080`.
- Find by port: `sudo netstat -lpn | grep :8080`.
- Find by name: `sudo ps aux | grep 'firefox'`.
- Find name file: `find . -iname "ApacheJMeter*"`.

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
- Set JAVA_HOME: execute command `export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64` and `export PATH=$PATH:$JAVA_HOME/bin`.

## SSH

- Create the RSA key: `ssh-keygen`.
- Show the RSA public key: `cat ~/.ssh/id_rsa.pub`.

## Cron

- Edit cron: `crontab -e`, content example: `* 2 * * * ~/script/up-report.sh >> ~/cronlog.log`.
- Restart cron: `/etc/init.d/cron restart`.

## Zip

- Compress: `zip -r filename.zip folder`.
- Extract:  `unzip filename.zip`.

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
- Maven
  - https://maven.apache.org/guides/introduction/introduction-to-the-lifecycle.html
- Git
  - https://rogerdudler.github.io/git-guide/
- Scp
  - https://kb.iweb.com/hc/en-us/articles/230241568-Copying-a-file-to-another-server-through-SSH