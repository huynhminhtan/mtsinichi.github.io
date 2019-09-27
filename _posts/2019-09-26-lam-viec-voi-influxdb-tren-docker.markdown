---
layout: post-featured
title: "Làm việc với InfluxDB trên Docker"
date:   2019-09-26 12:38:27 +0700 
categories: docker
author: mtSiniChi

image: https://www.outsystems.com/-/media/images/case-studies/via-verde-crm-increases-customer-adoption/via-verde-crm-increases-customer-adoption-hero.png
article_description: Làm việc nhanh với InfluxDB.
---

## Cài đặt

Chạy container, nếu chưa có sẽ tự pull trên hub.

```bash
docker run -p 8086:8086 --name=influxdb-master influxdb
```

Truy cập vào terminal trong docker.

```bash
docker exec --user root -it influxdb-master bash
```

Thao tác với InfluxDB.

```bash

# Verify
influxd

# Access CLI
influx

# Create database
create database mydb

# Show databases
show databases

# Using database
use mydb

# Show tables
show meaturements

# Insert CLI
insert cpu_load_short,host=server01,region=us-west value=0.7

# Insert HTTP
curl -i -XPOST 'http://localhost:8086/write?db=mydb1' --data-binary 'cpu_load_short,host=server01,region=us-west value=0.64 1434055562000000001'
curl -i -XPOST 'http://localhost:8086/write?db=mydb1' --data-binary 'cpu_load_short,host=server01,region=us-west value=0.46 1434055562000000002'
curl -i -XPOST 'http://localhost:8086/write?db=mydb1' --data-binary 'cpu_load_short,host=server01,region=us-west value=11i'

# Select
select * from cpu_load_short
select * from cpu_load_short where value > 1
select * from cpu_load_short group by region
```

Tham khảo:

- https://docs.influxdata.com/influxdb/v1.7/query_language/data_exploration/
- https://hub.docker.com/_/influxdb
