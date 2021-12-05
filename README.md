# README

## 設計規劃

因為使用 Promotion 時會有「條件」＆ 「效果」，因此又另外拆出兩個 Table 來放 Rules & Action。讓 Promotion 的擴充性較為優量

也因為本題著重在 Calculator 的設計，因此沒有去設計「成功下訂的訂單」，而且將每一次的 Calculator 計算都視為一次購買，並且建立一比 PromotionUsage 來統計使用額度ˋ

## DB Schema 設計

https://dbdiagram.io/d/61aaeb6c8c901501c0e01cf9

## 名詞定義

| 英文 | 中文 |
| - | - |
| subtotal | 打折前金額 |
| discount | 折扣 |
| total | 打折後金額 |
| --- | --- |
| amount | 金額 |
| percentage | ％數 |
| count | 數量 |

## 使用說明

啟用 docker-compose 獲得一個免洗版 postgres

`docker-compose up -d`

安裝必要套件

`bundle install`

建立 DB

`rake db:create`

跑 migration

`rake db:migrate`

執行測試

`rspec`

## 備註

贈送禮物的測試 `spec/services/calculator_spec.rb:115`

receive 沒有照預期運作，暫時沒有找到原因。所以只能先讓測試金額通過