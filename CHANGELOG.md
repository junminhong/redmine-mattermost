**v2.0.5 (2021/05/27)**
* chore:
    1. 更新mattermost訊息內容
* fix:
    1. 修正mattermost bot token不同，導致訊息無法發送

**v2.0.4 (2021/04/28)**
* fix:
    1. 修正並移除不必要的通知訊息內容
    2. 修正get user total count error
    3. 同時修正有些人會收不到訊息的問題

**v2.0.3 (2021/04/28)**
* fix:
    1. 修正新增議題通知判斷條件

**v2.0.2 (2021/04/23)**
* feat:
    1. 新增除錯小尖兵在外面抓蟲蟲
* fix:
    1. 修正更新通知訊息內容
    2. 修正要通知誰的判斷依據

**v2.0.1 (2021/04/21)**
* feat:
    1. 新增http handler
* fix:
    1. 修正是否通知誰的判斷依據
* chore:
    1. 新增例外處理
    2. 優化程式碼

**v2.0.0 (2021/04/20)**
* fix:
    1. 修正mattermost url更新
    2. 修正許多判斷方式
* chore:
    1. 更新版號為v2.0.0
    2. 更新設定版面欄位設計
    3. 重構插件架構
    4. 優化整體插件效能
    5. 移除不必要的程式碼
    6. 更新readme文件

**v1.2.0 (2021/01/21)**
* feat:
    1. 新增watcher也會通知
* fix:
    1. 修正assign判斷，改用多國語系
    2. 修正view form html id
* chore:
    1. 更新版號為v1.2.0
    2. 更新設定表單內mattermost密碼input type為password
    3. 稍微優化插件架構

**v1.1.0 (未知)**
* fix:
    1. 修正指派者為空會出現壅塞狀況
* chore:
    1. 更新版號為v1.1.0    

**v1.0.1 (2020/10/22)**
* chore:
    1. 更新版號為v1.0.1
    2. clean config data
    3. remove license

**v1.0.0 (2020/10/22)**
* feat:
    1. 新增CHANGELOG文件
* chore:
    1. 更新版號為v1.0.0

**v0.1.0 (2020/10/19)**
* feat:
    1. 新增自定義Mattermost網址和bot帳號密碼
    2. 可即時根據issues異動通知被指派者
    3. 新增README文件
* chore:
    1. clean code