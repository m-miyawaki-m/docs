## 目次案

### 基本
- 001: OpenAPIとは？
- 002: Swagger UIとは？
- 003: Swagger Editorの使い方
- 004: Swagger Codegenの使い方
- 005: OpenAPI 2.0と3.0の違い
- 006: YAMLとJSONのどちらを使うべきか？

### 基本的なAPI定義
- 007: シンプルなGETエンドポイントの定義
- 008: パスパラメータの定義（/users/{id}）
- 009: クエリパラメータの定義（/search?keyword=xxx）
- 010: POSTリクエストの定義
- 011: PUTリクエストの定義
- 012: DELETEリクエストの定義
- 013: ヘッダー情報の定義（Authorizationヘッダーなど）
- 014: リクエストボディの定義（JSON）

### レスポンスの定義
- 015: シンプルなレスポンスの定義
- 016: ステータスコードの定義（200, 400, 500）
- 017: カスタムエラーメッセージの定義
- 018: application/json 以外のレスポンス形式（text/plain）

### Schema（データ構造）
- 019: object 型の定義
- 020: array 型の定義
- 021: oneOf, anyOf, allOf の使い分け
- 022: enum の定義
- 023: 文字列のフォーマット（date-time, uuid）

### 認証・認可
- 024: Basic認証の定義
- 025: JWT（Bearer Token）認証の定義
- 026: OAuth2認証の定義
- 027: API Key 認証の定義

### 詳細設定
- 028: servers の定義
- 029: externalDocs の活用
- 030: tags の活用

### 拡張機能
- 031: x- プレフィックスを使ったカスタム拡張

### ツールとの連携
- 032: Swagger UI のカスタマイズ
- 033: Spring Boot + Springdoc OpenAPI でのSwagger設定
- 034: Express + Swagger JSDoc でのAPI定義
- 035: FastAPI でのSwagger自動生成
- 036: Node.js の swagger-jsdoc を使ったドキュメント生成

### CI/CDとの統合
- 037: GitHub Actions で OpenAPI のバリデーションを行う
- 038: OpenAPI Generator を使って API クライアントを自動生成する