# **Postman 100本ノック** 🚀  
Postman を活用して API テスト・自動化・負荷テスト・CI/CD まで幅広く学べる 100 本ノックです。API の基礎から、Postman スクリプトの活用、Newman（CLI の自動化）、Jenkins/GitHub Actions での統合まで、実践的なスキルを習得できます。

---

## **1. Postman の基本**
1. **Postman をインストール**
2. **Postman の GUI で `GET https://jsonplaceholder.typicode.com/posts/1` を実行**
3. **レスポンスの JSON を確認**
4. **リクエストの「Headers」タブを確認**
5. **リクエストの「Params」タブを確認**
6. **リクエストの「Body」タブを確認**
7. **レスポンスの `Status Code` を確認**
8. **レスポンスの時間 (`Response Time`) を確認**
9. **Postman の「History」機能で過去のリクエストを確認**
10. **リクエストを「Collections」に保存**

---

## **2. `GET` リクエストの応用**
11. **`GET` リクエストに `?userId=1` のクエリパラメータを追加**
12. **ヘッダーに `Accept: application/json` を追加**
13. **`GET` リクエストの `Auth` タブで Basic 認証を設定**
14. **`GET` リクエストの `Auth` タブで Bearer Token を設定**
15. **`GET` リクエストの `Auth` タブで API Key を設定**
16. **環境変数を使って `baseUrl` を設定**
17. **Postman の「Examples」機能でリクエストのサンプルレスポンスを保存**
18. **Postman の `Pre-request Script` でリクエスト前に変数を設定**
19. **Postman の `Tests` でレスポンスの `status` を `200` であることをチェック**
20. **Postman の `Tests` で JSON レスポンスのキーをチェック**

---

## **3. `POST` リクエストの活用**
21. **`POST` リクエストで JSON データを送信**
22. **`POST` リクエストの `form-data` でファイルをアップロード**
23. **`POST` リクエストの `x-www-form-urlencoded` を使用**
24. **`POST` リクエストで環境変数を使って動的なデータを送信**
25. **`POST` リクエストの `Tests` でレスポンスの `id` を取得**
26. **`POST` のレスポンスを環境変数に保存**
27. **`POST` リクエストのレスポンスを `Collection Runner` で検証**
28. **API の `Content-Type` が `application/json` であることをチェック**
29. **JSON レスポンスの値が `expect` と一致するか確認**
30. **レスポンス時間が `500ms` 以下であることをテスト**

---

## **4. `PUT`・`DELETE` リクエスト**
31. **`PUT` リクエストでデータを更新**
32. **`PUT` リクエストの `Tests` でデータが更新されていることを確認**
33. **`DELETE` リクエストでデータを削除**
34. **`DELETE` のレスポンス `204 No Content` をテスト**
35. **`DELETE` 後に `GET` でデータが存在しないことを確認**
36. **`PATCH` リクエストで部分更新**
37. **`PUT` リクエストで `application/xml` を送信**
38. **`PUT` リクエストで `multipart/form-data` を送信**
39. **`DELETE` のレスポンスを `Tests` で `undefined` であることを確認**
40. **`PUT`/`DELETE` のリクエストヘッダーを `Pre-request Script` で変更**

---

## **5. Postman の環境変数**
41. **「環境」を作成し、`baseUrl` を登録**
42. **`{{baseUrl}}/users/1` のように環境変数を使用**
43. **グローバル変数を設定**
44. **スクリプト内で環境変数を取得**
45. **スクリプトで環境変数を更新**
46. **環境変数を `pm.environment.set()` で変更**
47. **`pm.globals.set()` でグローバル変数を更新**
48. **環境変数の `JSON.stringify()` を活用**
49. **スクリプトで現在の環境をログに表示**
50. **環境変数の値を `Tests` でチェック**

---

## **6. Postman のテスト自動化**
51. **レスポンスコード `200` をチェック**
52. **レスポンスの JSON のキーが `title` を含むかチェック**
53. **レスポンスの `status` が `success` であることを確認**
54. **レスポンスの配列の長さをチェック**
55. **複数の API を `Collection Runner` で一括実行**
56. **スクリプトで API のレスポンス時間を記録**
57. **カスタム関数を `Pre-request Script` に作成**
58. **スクリプトで動的なトークンを `Authorization` に設定**
59. **スクリプトで `Math.random()` を使ってランダムデータを送信**
60. **スクリプトで `Date.now()` を使って現在時刻を送信**

---

## **7. Newman（Postman の CLI）**
61. **`npm install -g newman` で Newman をインストール**
62. **Newman で `collection.json` を実行**
63. **`--environment` で環境を指定**
64. **`--iteration-count` で 10 回 API を実行**
65. **Newman の JSON レポートを出力**
66. **Newman の HTML レポートを作成**
67. **Newman のテスト結果を Slack に送信**
68. **Newman を GitHub Actions で実行**
69. **Newman を Jenkins で実行**
70. **Newman のエラーハンドリングを実装**

---

## **8. API の負荷テスト**
71. **Newman で 1000 回 API を実行**
72. **レスポンスタイムが 1 秒を超えたリクエストを記録**
73. **並列リクエストを実行**
74. **API のレスポンス率を計測**
75. **ログイン API の負荷テスト**
76. **サーバーのステータスコードを解析**
77. **エラーが多発した場合の通知**
78. **`pm.expect().to.be.within(100, 500)` で範囲テスト**
79. **API のスロットリングを検証**
80. **API のエラーハンドリングをテスト**

---

## **9. CI/CD との統合**
81. **Newman を GitHub Actions で実行**
82. **Newman を GitLab CI で実行**
83. **Newman を Jenkins で実行**
84. **Newman の結果を CI/CD で保存**
85. **API の自動デプロイ後にテスト**
86. **エラー発生時に GitHub Issue を作成**
87. **エラー発生時に Slack 通知**
88. **テストレポートを保存**
89. **CI/CD のワークフローを作成**
90. **API の可用性モニタリング**

---

🚀 **どの問題から挑戦してみたいですか？** 🚀