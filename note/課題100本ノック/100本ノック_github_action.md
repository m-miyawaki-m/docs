# **GitHub Actions 100本ノック**
GitHub Actions を活用して CI/CD を実装するための 100 本ノックを作成しました。基本的なワークフローの作成から、環境変数の活用、デプロイの自動化、Webhook 連携まで、段階的に学べるようになっています。

---

## **1. GitHub Actions の基本**
1. **GitHub Actions を有効化し、初めてのワークフローを作成**
2. `.github/workflows/hello-world.yml` を作成し、**"Hello, GitHub Actions!"** を出力
3. `on: push` で **特定のブランチに push されたら実行** するワークフローを作成
4. `on: pull_request` で **PR 作成時に実行** するワークフローを作成
5. `on: schedule` で **定期実行（毎日 12:00 JST）** するワークフローを作成
6. `on: workflow_dispatch` で **手動実行** できるワークフローを作成
7. **複数のトリガー (`push`, `pull_request`, `workflow_dispatch`) を組み合わせたワークフロー**
8. `name:` を設定し、**ワークフロー名をカスタマイズ**
9. `jobs:` を定義し、**複数のジョブを並列実行**
10. `needs:` を使って、**ジョブの依存関係を設定**

---

## **2. GitHub Actions で環境設定**
11. `runs-on: ubuntu-latest` で **Ubuntu 環境で実行**
12. `runs-on: windows-latest` で **Windows 環境で実行**
13. `runs-on: macos-latest` で **macOS 環境で実行**
14. `strategy.matrix` を使い **複数の OS で並列実行**
15. `env:` を設定し、**環境変数を使う**
16. `secrets.GITHUB_TOKEN` を使い、**リポジトリへの認証**
17. **カスタムシークレットを GitHub で設定し、ワークフローで使用**
18. `.env` ファイルを読み込んで環境変数を設定
19. **環境変数をジョブ間で共有**
20. **環境ごと (`dev`, `staging`, `prod`) に異なる設定を適用**

---

## **3. ワークフローでのスクリプト実行**
21. **シェルスクリプト (`bash`) を実行**
22. **PowerShell スクリプト (`pwsh`) を実行**
23. **Python スクリプトを実行**
24. **Node.js スクリプトを実行**
25. **Go スクリプトを実行**
26. **Docker コンテナ内でスクリプトを実行**
27. **スクリプトのエラーをキャッチして、ジョブを失敗させる**
28. **スクリプトの出力を次のステップで利用**
29. **ワークフローの中で `curl` を使って API にリクエスト**
30. **GitHub API を使ってワークフローの実行履歴を取得**

---

## **4. ビルドとテスト**
31. **Node.js アプリの `npm install` と `npm test` を実行**
32. **Python アプリの `pytest` を実行**
33. **Java プロジェクトの `maven test` を実行**
34. **Go プロジェクトの `go test` を実行**
35. **Docker コンテナ内でテストを実行**
36. **Lint チェック (`eslint`, `flake8`, `golangci-lint`) を実行**
37. **カバレッジレポートを生成**
38. **テスト結果を GitHub にアップロード**
39. **エラーが発生したら GitHub の Issue を作成**
40. **成功・失敗時に Slack に通知**

---

## **5. デプロイの自動化**
41. **GitHub Pages に HTML をデプロイ**
42. **AWS S3 にファイルをアップロード**
43. **AWS Lambda にデプロイ**
44. **Firebase Hosting にデプロイ**
45. **Google Cloud Run にデプロイ**
46. **Heroku にデプロイ**
47. **Netlify にデプロイ**
48. **Vercel にデプロイ**
49. **Docker Hub にイメージをプッシュ**
50. **Kubernetes クラスタにデプロイ**

---

## **6. GitHub Actions のアーティファクト**
51. **ビルド成果物 (`artifact`) をアップロード**
52. **アップロードしたアーティファクトをダウンロード**
53. **複数のジョブでアーティファクトを共有**
54. **S3 などの外部ストレージにアーティファクトを保存**
55. **CI/CD の途中経過をアーティファクトとして保存**
56. **アーティファクトの保持期間を設定**
57. **特定の条件でのみアーティファクトをアップロード**
58. **ジョブ間でファイルを受け渡し**
59. **特定のファイルのみをアーティファクトに含める**
60. **アーティファクトを GitHub Releases にアップロード**

---

## **7. 通知・アラート**
61. **Slack にワークフローの開始・完了を通知**
62. **Discord にワークフローの開始・完了を通知**
63. **Teams にワークフローの開始・完了を通知**
64. **Webhook でカスタム通知を送信**
65. **ワークフローの失敗時にメール通知**
66. **エラー発生時に GitHub Issue を自動作成**
67. **エラー発生時に GitHub Discussions へ投稿**
68. **ワークフローの成功時に GitHub PR にコメント**
69. **ワークフローの成功時に GitHub Actions のバッジを更新**
70. **実行時間が長すぎる場合に警告通知**

---

## **8. ワークフローの最適化**
71. **ジョブのキャッシュ (`actions/cache`) を活用**
72. **Docker イメージのビルドをキャッシュ**
73. **npm / pip の依存関係をキャッシュ**
74. **ワークフローの並列実行を最適化**
75. **リトライロジックを実装**
76. **ワークフローの実行時間を計測**
77. **PR の変更内容に応じて実行するジョブを最適化**
78. **スキップ可能なステップを追加**
79. **ワークフローの失敗時にリトライ**
80. **ワークフローを `path-filter` を使って最適化**

---

## **9. 高度な GitHub Actions**
81. **サードパーティの Actions (`checkout`, `setup-node`, `setup-python` など) を活用**
82. **独自の GitHub Actions を作成**
83. **Docker を使ったカスタム GitHub Actions を作成**
84. **Node.js で GitHub Actions を作成**
85. **GitHub Actions の Marketplace を活用**
86. **複数のリポジトリで共通のワークフローを使用**
87. **ワークフロー内で Git コマンドを実行**
88. **リポジトリのタグをトリガーに実行**
89. **ワークフローの実行条件を細かく設定**
90. **ワークフローの出力結果を次のジョブで利用**

---

## **10. GitHub Actions のセキュリティ**
91. **環境変数を `.env` ファイルから読み込む**
92. **シークレットの漏洩を防ぐ**
93. **特定のブランチのみ実行可能にする**
94. **特定のユーザーの PR のみ実行可能にする**
95. **ジョブの権限を制限**
96. **ワークフローの改ざん防止**
97. **ワークフローのログを監視**
98. **セキュリティスキャンを自動実行**
99. **GitHub Dependabot と連携**
100. **ワークフローの脆弱性対策**

---

🚀 どの問題から挑戦してみたいですか？ 🚀