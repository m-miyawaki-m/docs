# **Jenkins 100本ノック** 🚀  
Jenkins を活用した CI/CD の基礎から応用までを学ぶための 100 本ノックです。基本的なジョブ作成から、パイプライン、Jenkinsfile、Git 連携、Docker、デプロイ、プラグイン活用、セキュリティまで幅広くカバーします。  

---

## **1. Jenkins の基本操作**
1. **Jenkins をインストール**（Windows / Linux / Docker）
2. **Jenkins の管理画面にアクセス**
3. **初期設定と管理者ユーザーの作成**
4. **Jenkins のバージョン確認**
5. **プラグインのインストール**
6. **ジョブ（フリースタイルプロジェクト）を作成**
7. **ジョブを手動実行**
8. **ジョブの実行履歴を確認**
9. **ビルド時に環境変数を設定**
10. **Jenkins の管理ユーザーを追加**

---

## **2. フリースタイルジョブ**
11. **シェルスクリプト (`echo "Hello, Jenkins"`) を実行**
12. **Windows バッチコマンド (`echo Hello, Jenkins`) を実行**
13. **Python スクリプトを実行**
14. **Node.js スクリプトを実行**
15. **ジョブの成果物をアーカイブ**
16. **ジョブの成果物をワークスペースに保存**
17. **ジョブの実行後にスクリプトを実行**
18. **ジョブの実行ログを確認**
19. **ジョブの実行条件（ビルドトリガ）を設定**
20. **ジョブが失敗した場合の通知を設定**

---

## **3. Jenkins パイプライン**
21. **Jenkinsfile を作成**
22. **Jenkinsfile で `echo 'Hello, Pipeline'` を実行**
23. **ステージ (`stages`) を定義**
24. **パラレル実行 (`parallel`) を定義**
25. **エージェント (`agent any`) を設定**
26. **パイプラインの `environment` で環境変数を設定**
27. **`input` ステップを追加して手動承認**
28. **パイプラインの `post` ステージで後処理**
29. **エラー発生時の `catchError` を追加**
30. **`when` 条件を使い、特定のブランチで実行**

---

## **4. Git 連携**
31. **Jenkins に Git プラグインをインストール**
32. **Jenkins ジョブで GitHub リポジトリをクローン**
33. **Jenkins の SSH キーを GitHub に登録**
34. **GitHub Webhook を設定**
35. **特定のブランチの変更時にジョブを実行**
36. **特定のタグが付いたらジョブを実行**
37. **Git コマンドを実行 (`git log`)**
38. **Jenkinsfile で `checkout scm` を使用**
39. **Jenkinsfile で `git` ステップを使用**
40. **Git のコミット ID をビルド結果に表示**

---

## **5. ビルドの自動化**
41. **Jenkins で Maven ビルド**
42. **Jenkins で Gradle ビルド**
43. **Jenkins で npm ビルド**
44. **Jenkins で make コマンドを実行**
45. **Jenkins で `go build` を実行**
46. **ビルド成果物を `artifact` として保存**
47. **ビルド成果物を S3 にアップロード**
48. **Jenkinsfile で `sh 'mvn package'` を実行**
49. **Jenkinsfile で `node_modules` をキャッシュ**
50. **Jenkins のワークスペースをクリーンアップ**

---

## **6. Docker との連携**
51. **Jenkins に Docker プラグインをインストール**
52. **Jenkins のビルド環境を Docker コンテナで実行**
53. **Docker コンテナ内で `npm install` を実行**
54. **Docker イメージをビルド**
55. **Docker Hub にプッシュ**
56. **Docker Compose を使ってマルチコンテナ環境を構築**
57. **Jenkinsfile で `docker.build` を使用**
58. **Jenkinsfile で `docker.run` を使用**
59. **Docker コンテナ内でテストを実行**
60. **Docker Swarm や Kubernetes にデプロイ**

---

## **7. テストの自動化**
61. **Jenkins で `pytest` を実行**
62. **Jenkins で `unittest` を実行**
63. **Jenkins で `jest` を実行**
64. **Jenkins で `go test` を実行**
65. **Jenkins で `JUnit` のテストレポートを解析**
66. **Jenkins で `TestNG` のテストレポートを解析**
67. **カバレッジレポートを生成**
68. **テスト失敗時に Slack 通知**
69. **テスト結果を `artifact` として保存**
70. **テストが通った場合のみデプロイ**

---

## **8. デプロイの自動化**
71. **AWS にデプロイ (`aws s3 cp`)**
72. **Google Cloud Run にデプロイ**
73. **Heroku にデプロイ**
74. **Kubernetes にデプロイ**
75. **Terraform を実行**
76. **Ansible を実行**
77. **Jenkinsfile で `scp` を使ってデプロイ**
78. **Jenkinsfile で `rsync` を使ってデプロイ**
79. **Jenkins から EC2 インスタンスに SSH 接続**
80. **本番環境デプロイ前に手動承認を追加**

---

## **9. Jenkins の管理**
81. **Jenkins のジョブ履歴を削除**
82. **Jenkins のログを確認**
83. **Jenkins のメモリ使用量を監視**
84. **Jenkins のジョブを自動クリーンアップ**
85. **Jenkins のバックアップを取得**
86. **Jenkins のダッシュボードをカスタマイズ**
87. **Jenkins のスレーブノードを追加**
88. **Jenkins のスレーブノードにラベルを付与**
89. **Jenkins のスケールアウト**
90. **Jenkins のアップグレード**

---

## **10. セキュリティと最適化**
91. **Jenkins に HTTPS を設定**
92. **Jenkins の API トークンを発行**
93. **Jenkins で Role-based Access Control を設定**
94. **Jenkins のジョブに RBAC を適用**
95. **Jenkins のシークレットを安全に管理**
96. **Jenkins でジョブの並列実行を最適化**
97. **Jenkins の実行時間を短縮**
98. **Jenkins のジョブを自動キャンセル**
99. **Jenkins のプラグインを最新にする**
100. **Jenkins の運用ベストプラクティスを実践**

---

## **まとめ**
🔥 **この100本ノックを進めることでできること**
✅ **Jenkins の基本操作を習得**  
✅ **Jenkinsfile での CI/CD をマスター**  
✅ **GitHub / Docker / AWS との連携を実践**  
✅ **セキュリティと運用のベストプラクティスを学ぶ**  

🚀 **Jenkins を使いこなしたい方は、どの問題から試したいですか？** 🚀