シーケンス図のPlantUML記法について、文法・機能・使い分けを以下のように体系的に深掘りします。


---

【基本構文】

@startuml
participant User
participant Server

User -> Server: sendRequest()
Server --> User: response()
@enduml

->：同期呼び出し（待つ）

-->：非同期呼び出し（待たない）

participant：登場人物（エンティティ）



---

【1. エンティティの定義】

actor User
boundary Browser
control Controller
entity Database
participant API

' 表示名を変える
participant "Web Client\n(Browser)" as Web

actor：外部ユーザー（人やシステム）

control：制御ロジック（Controllerなど）

boundary：UI/外部との境界

entity：モデルやDBなどデータ保持



---

【2. メッセージのやり取り】

A -> B: メソッド名()
A --> B: 非同期呼び出し
A ->> B: リターン待ち
A -->> B: 非同期リターン

A -> B ++: ライフラインの開始
A -> B --: ライフラインの終了


---

【3. 応答・戻り値】

A -> B: request()
B --> A: result

戻り値は任意だが、書いた方が分かりやすい。


---

【4. ネスト・制御構文】

条件分岐（alt）

alt 成功
  A -> B: 処理成功
else 失敗
  A -> B: エラー処理
end

繰り返し（loop）

loop 3回繰り返す
  A -> B: doSomething()
end

条件（opt）

opt 条件付き処理
  A -> B: optionalCall()
end


---

【5. 注釈・グループ化】

注釈（コメント）

note right of A: これはAへの注釈
note over A,B: AとBに共通の注釈

グループ化（box）

box "Web Layer"
  participant Browser
  participant JS
end box


---

【6. ライフライン制御】

activate A
A -> B: call
deactivate A

ライフラインバー（細長い縦棒）を明示的に出したいときに使う。


---

【7. 非同期メッセージ】

Client ->> Server: 非同期処理
Server -->> Client: コールバック応答

->> や -->> を使うと非同期であることを明示できる。


---

【8. タイムラインにラベル】

== ログイン処理開始 ==
User -> App: login()
== 認証処理 ==
App -> DB: 認証確認

処理の区切り・フェーズを視覚的に表現できる。


---

【補足：エラー処理や注釈付き矢印】

A -> B: 処理要求
note right: 処理中にタイムアウトの可能性あり

A -[#red]> B: エラー時の処理


---

よくある実例（ログイン処理）

@startuml
actor User
participant "Web\nBrowser" as Browser
participant "Web\nServer" as Server
participant "DB" as Database

User -> Browser: 入力情報を送信
Browser -> Server: /loginリクエスト
Server -> Database: ユーザー認証
Database --> Server: 認証OK
Server --> Browser: 成功レスポンス
Browser --> User: ログイン完了通知
@enduml


---

必要であれば、トークンの取得、エラーリトライ、非同期バッチ処理などのシナリオも個別に解説できます。

何か具体的なシナリオで図を作りたいですか？

