---
layout: post-featured
title:  "Sử dụng Post Processer trong Jmeter"
date:   2019-07-10 13:38:27 +0700
categories: linux
author: mtSiniChi

image: /assets/images/via-verde-crm-increases-customer-adoption-hero.png
article_description: Sử dụng JSON extractor của Post Processor để lưu data respone của api thực thi trước, để phục vụ cho các api thực thi sau nếu cần.
---

Jmeter Post processor giúp lấy những dữ liệu sau khi thực thi xong một api trong testcript, lưu dữ liệu trả về vào biến, rồi có thể dùng biến đó cung cấp dữ liệu cho những lần thực thi api sau.

Thêm bằng cách, **click chuột phải vào api cần tạo Post processor -> Add -> Post processors -> JSON Extractor**.

![json-extractor-jmeter][1]{:class="img-responsive"}

Ví dụ, có 1 api trả về json:

```json
{
    "zptransid": 190820006451952,
    "ordersid": "ODOO",
    "isOk": false,
}
```

Lấy ra giá trị của thuộc tính *zptransid* với cú pháp `$.zptransid` từ JSON trả về lưu vào biến `zptransID` và sau đó sử dụng `${zptransID}` để lấy ra giá trị vừa lưu.

Trong đó:

- Variable names: đặt tên cho biến để lưu trữ dữ liệu. Ví dụ: `zptransID`
- JSON Path expressions: cú pháp rúc trích giá trị từ JSON data trả về giống như cách lấy xPath. Ví dụ: `$.zptransid`
- Match No. (0 for Random): khi cú pháp rúc trích có nhiều giá trị, thì chỉ ra thứ tự của giá trị cần lấy là bao nhiêu. Giá trị là 1 sẽ lấy đầu tiên.
- Compute concatenation var (suffix_ALL): tiền tố biến (không quan tâm).
- Default value: giá trị mặc định khi không kiếm được trong JSON data.

Tham khảo:

- https://www.redline13.com/blog/2018/09/jmeter-extract-and-re-use-as-variable/
- https://goessner.net/articles/JsonPath/
- https://stackoverflow.com/a/44755425/9488752
- https://loadium.com/blog/jmeter-post-processors/
- https://medium.com/@loadium/jmeter-post-processors-667139a69dd

[1]:{{ site.url }}/assets/images/json-extractor-jmeter.png