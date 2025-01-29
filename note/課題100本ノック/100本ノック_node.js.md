# **Node.js 100本ノック** 🚀  
Node.js の基礎から応用までを実践的に学ぶための 100 本ノックです。  
基本的な JavaScript の実行から、API 開発、データベース連携、CI/CD、自動化スクリプト作成まで、幅広く Node.js を活用できるスキルを習得できます。  

---

## **1. Node.js の基本**
1. **Node.js をインストール (`nvm` 推奨)**
2. **`node -v` と `npm -v` でバージョン確認**
3. **`console.log("Hello, Node.js!")` を実行**
4. **`process.argv` を使ってコマンドライン引数を取得**
5. **`fs.writeFileSync()` でファイルを書き込み**
6. **`fs.readFileSync()` でファイルを読み込む**
7. **`setTimeout()` と `setInterval()` を使う**
8. **`os` モジュールで CPU 情報を取得**
9. **`path` モジュールでファイルパスを操作**
10. **`crypto` モジュールでハッシュ (`SHA256`) を作成**

---

## **2. npm & パッケージ管理**
11. **`npm init -y` で `package.json` を作成**
12. **`npm install lodash` で外部パッケージをインストール**
13. **`lodash.get()` を使ってオブジェクトの値を取得**
14. **`npm uninstall lodash` でパッケージを削除**
15. **`npm list` でインストール済みパッケージを確認**
16. **`npm outdated` で古いパッケージをチェック**
17. **`npm update` でパッケージを最新化**
18. **`npx cowsay "Hello, Node.js!"` を実行**
19. **`package.json` の `scripts` をカスタマイズ**
20. **`npm run <script名>` でスクリプトを実行**

---

## **3. 非同期処理**
21. **`fs.readFile()` を使った非同期ファイル読み込み**
22. **`util.promisify()` でコールバックを Promise に変換**
23. **`async/await` を使って `fs.readFile()` をラップ**
24. **`Promise.all()` で複数の非同期処理を並列実行**
25. **`Promise.race()` で最速のレスポンスを取得**
26. **非同期処理のエラーハンドリング (`try/catch`)**
27. **`fetch()` を使って外部 API を取得**
28. **`axios` を使って HTTP リクエストを実行**
29. **非同期の関数を `setTimeout()` で遅延実行**
30. **イベントリスナー (`EventEmitter`) を実装**

---

## **4. HTTP サーバーの作成**
31. **`http.createServer()` でシンプルなサーバーを作成**
32. **`express` をインストール**
33. **`express` で簡単な API (`GET /hello`) を作成**
34. **クエリパラメータ (`req.query`) を取得**
35. **ルートパラメータ (`req.params`) を取得**
36. **`POST` リクエストの `body` を受け取る**
37. **JSON レスポンスを返す API を作成**
38. **404 ページ (`res.status(404).send("Not Found")`) を作成**
39. **ミドルウェア (`app.use()`) を作成**
40. **CORS を許可 (`cors` パッケージを使用)**

---

## **5. データベース連携**
41. **`sqlite3` を使って SQLite に接続**
42. **`mysql2` を使って MySQL に接続**
43. **`pg` を使って PostgreSQL に接続**
44. **`mongodb` を使って MongoDB に接続**
45. **`mongoose` で MongoDB のモデルを作成**
46. **`Sequelize` を使って ORM を導入**
47. **SQL の `INSERT` を実行**
48. **SQL の `SELECT` を実行**
49. **SQL の `UPDATE` を実行**
50. **SQL の `DELETE` を実行**

---

## **6. 認証 & セキュリティ**
51. **`bcrypt` でパスワードをハッシュ化**
52. **`jsonwebtoken` (`JWT`) でトークンを生成**
53. **JWT の検証 (`verify()`)**
54. **OAuth2 (Google 認証) を実装**
55. **環境変数 (`dotenv`) を管理**
56. **CORS (`cors`) を設定**
57. **CSRF 対策 (`csurf`) を導入**
58. **`helmet` を使って HTTP ヘッダーを強化**
59. **SQL インジェクション対策 (`parameterized queries`)**
60. **XSS 対策 (`sanitize-html`) を導入**

---

## **7. CLI ツール作成**
61. **コマンドライン引数 (`process.argv`) を解析**
62. **標準入力 (`readline`) を受け取る**
63. **`chalk` を使ってカラフルな出力**
64. **`commander` を使って CLI コマンドを作成**
65. **`inquirer` でインタラクティブな CLI を作成**
66. **環境変数を読み込む CLI を作成**
67. **API を叩く CLI ツールを作成**
68. **ファイルを読み書きする CLI を作成**
69. **シンプルなタスク管理 CLI を作成**
70. **Git のコミットログを取得する CLI を作成**

---

## **8. WebSocket & リアルタイム通信**
71. **`ws` を使って WebSocket サーバーを作成**
72. **WebSocket クライアントを作成**
73. **Socket.io を使ってチャットアプリを作成**
74. **リアルタイムデータを WebSocket で配信**
75. **ユーザーごとに WebSocket 接続を管理**
76. **WebSocket のエラーハンドリング**
77. **WebSocket で JWT 認証**
78. **Redis Pub/Sub を使った WebSocket**
79. **リアルタイム投票アプリを作成**
80. **リアルタイム通知システムを構築**

---

## **9. テスト & CI/CD**
81. **`jest` でユニットテストを作成**
82. **`mocha` & `chai` でテストを作成**
83. **API のテスト (`supertest`)**
84. **テストのカバレッジ (`jest --coverage`) を計測**
85. **GitHub Actions で Node.js の CI を設定**
86. **Jenkins で `npm test` を実行**
87. **CircleCI で `npm run build` を実行**
88. **GitLab CI で Node.js プロジェクトをデプロイ**
89. **Docker で Node.js アプリをコンテナ化**
90. **Kubernetes で Node.js アプリをデプロイ**

---

## **10. Node.js 応用**
91. **GraphQL API (`apollo-server`) を作成**
92. **gRPC (`grpc-node`) を実装**
93. **Electron でデスクトップアプリを作成**
94. **Web Scraping (`puppeteer`) を実装**
95. **PDF 生成 (`pdfkit`) を実装**
96. **FFmpeg を使って動画変換**
97. **Redis キャッシュを実装**
98. **RabbitMQ でメッセージキューを実装**
99. **スマートコントラクト (`web3.js`) を実装**
100. **Node.js で AI モデル (`tensorflow.js`) を実装**

---

🚀 **どの問題から挑戦してみたいですか？** 🚀