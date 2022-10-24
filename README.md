- /debtors/1 => response.csv ('ФИО', 'Дата рождения', 'Код региона')
- /fsin/1    => json: [{ fio: '', dt: '' }, {}]
- /inn/1234567890   => json:
```json

```
- /arbitr/1234567890 => json:
```json
[
  {
    "link": "https://kad.arbitr.ru/Card/12752b95-df28-4f70-8bc3-725cc60827f0",
    "num": "А41-62108/2014",
    "judge": "Гринева А. В.",
    "title": "АС Московской области",
    "name": "Ип Витвицкий Дмитрий Владимирович",
    "dt": "08.10.2014"
  }
]
```
- /nalog/1234567890 => json:
```json
{
  "captchaRequired": false,
  "ip": {
    "hasMore": false,
    "page": 1,
    "pageSize": 10,
    "data": [
      {
        "yearcode": 2020,
        "periodcode": 12,
        "ogrn": "333",
        "inn": "555",
        "okved2": "62.01",
        "okved2name": "Разработка компьютерного программного обеспечения",
        "namec": "ВЛАДИМИР",
        "token": "aaa"
      },
      {
        "yearcode": 2020,
        "periodcode": 12,
        "ogrn": "333",
        "inn": "555",
        "okved2": "47.52.7",
        "okved2name": "Торговля розничная строительными материалами",
        "namec": "ВЛАДИМИР",
        "token": "aaa"
      }
    ],
    "rowCount": 2
  }
}
```

```
 curl 'https://service.nalog.ru/inn-new-proc.do' \
   -H 'Cookie: _ym_uid=1634105627353283064; _ym_d=1658730889; JSESSIONID=78E7C5174965F76DE40A10C0565F3591; uniI18nLang=RUS; _ym_isad=1; _ym_visorc=b; upd_inn=24F29968FD73E6788483CACCDA928DEC3B6EE73E26F7C18FA80B66B4BC10C748' \
   -H 'X-Requested-With: XMLHttpRequest' \
   --data-raw 'c=find&captcha=&captchaToken=&fam=%D0%92%D0%B8%D1%82%D0%B2%D0%B8%D1%86%D0%BA%D0%B8%D0%B9&nam=%D0%94%D0%BC%D0%B8%D1%82%D1%80%D0%B8%D0%B9&opt_otch=1&bdate=26.08.1983&doctype=21&docno=49+07+851823&docdt=18.03.2008'
```

```
 curl 'https://service.nalog.ru/inn-new-proc.json' \
   -H 'Accept: application/json' \
   -H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' \
   -H 'Cookie: _ym_uid=1634105627353283064; _ym_d=1658730889; JSESSIONID=78E7C5174965F76DE40A10C0565F3591; uniI18nLang=RUS; _ym_isad=1; _ym_visorc=b; upd_inn=24F29968FD73E6788483CACCDA928DEC3B6EE73E26F7C18FA80B66B4BC10C748' \
   -d 'c=get&requestId=C04B4ACCF1EE5B2C5A6C71E0C8122352D0DFC96E1B6AE671C645C0BEC0B01A82C049F6540E8335BC1408F7A74C33CE4C0EC426882F8E478056E1C6D54D5049A59E79B3D8565FF0AF4D084AAFEAA2AA3C'
```
