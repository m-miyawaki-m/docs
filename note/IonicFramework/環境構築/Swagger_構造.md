## **📌 `swagger.yaml` の構文解説（OpenAPI 3.0）**
`swagger.yaml` は **OpenAPI 仕様（旧Swagger）** に基づいて記述される API 定義ファイルです。  
API のエンドポイント、リクエストパラメータ、レスポンス、認証方式などを明確に定義できます。

---

## **✅ `swagger.yaml` の基本構成**
```yaml
openapi: 3.0.0
info:
  title: Sample API
  version: 1.0.0
  description: "ユーザー管理API"

servers:
  - url: http://localhost:8080
    description: "ローカル開発環境"

paths:
  /users:
    get:
      summary: "ユーザー一覧の取得"
      description: "登録されているすべてのユーザーを取得する"
      responses:
        "200":
          description: "成功時のレスポンス"
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: "#/components/schemas/User"

components:
  schemas:
    User:
      type: object
      properties:
        id:
          type: integer
          example: 1
        name:
          type: string
          example: "John Doe"
        email:
          type: string
          example: "john@example.com"
```

---

## **✅ 各項目の詳細解説**
### **🔹 1️⃣ `openapi`（OpenAPI バージョン指定）**
```yaml
openapi: 3.0.0
```
- **`openapi:`** → 使用する OpenAPI のバージョンを指定（`3.0.0` 以上）。
- **OpenAPI 2.0（旧 Swagger）とは互換性がない** ため、`3.0.0` を推奨。

---

### **🔹 2️⃣ `info`（API 情報の定義）**
```yaml
info:
  title: Sample API
  version: 1.0.0
  description: "ユーザー管理API"
```
- **`title:`** → API の名称
- **`version:`** → API のバージョン
- **`description:`** → API の概要（HTMLタグも使用可能）

---

### **🔹 3️⃣ `servers`（サーバー情報）**
```yaml
servers:
  - url: http://localhost:8080
    description: "ローカル開発環境"
```
- **`servers:`** → API のホスト（ベースURL）を指定
- **`url:`** → 実際の API エンドポイントのベースURL
- **`description:`** → サーバーの説明（開発・ステージング・本番など）

📌 **複数環境を定義可能**
```yaml
servers:
  - url: http://localhost:8080
    description: "ローカル環境"
  - url: https://api.example.com
    description: "本番環境"
```

---

### **🔹 4️⃣ `paths`（エンドポイントの定義）**
```yaml
paths:
  /users:
    get:
      summary: "ユーザー一覧の取得"
      description: "登録されているすべてのユーザーを取得する"
      responses:
        "200":
          description: "成功時のレスポンス"
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: "#/components/schemas/User"
```
- **`paths:`** → API の各エンドポイントを定義
- **`/users:`** → `GET /users` のエンドポイント
- **`get:`** → `GET` メソッドの定義（`post:`, `put:`, `delete:` も可能）
- **`summary:`** → エンドポイントの短い説明
- **`description:`** → 詳細な説明（オプション）

📌 **レスポンス定義**
```yaml
responses:
  "200":
    description: "成功時のレスポンス"
    content:
      application/json:
        schema:
          type: array
          items:
            $ref: "#/components/schemas/User"
```
- **`responses:`** → レスポンスのステータスコードごとに定義
- **`"200":`** → HTTP ステータスコード
- **`content:`** → レスポンスのデータフォーマット
- **`application/json:`** → JSON 形式のレスポンスを指定
- **`schema:`** → レスポンスのデータ構造
- **`$ref:`** → `components/schemas/User` の定義を参照（後述）

---

### **🔹 5️⃣ `components/schemas`（データ構造の定義）**
```yaml
components:
  schemas:
    User:
      type: object
      properties:
        id:
          type: integer
          example: 1
        name:
          type: string
          example: "John Doe"
        email:
          type: string
          example: "john@example.com"
```
- **`components/schemas:`** → 共通のデータモデル（DTO）を定義
- **`User:`** → ユーザー情報のスキーマ
- **`type: object`** → オブジェクト型（JSON の `{}` に対応）
- **`properties:`** → 各プロパティ（`id`, `name`, `email`）を定義
- **`example:`** → サンプルデータ（Swagger UI で表示される）

📌 **ネストしたオブジェクト**
```yaml
components:
  schemas:
    Address:
      type: object
      properties:
        city:
          type: string
          example: "Tokyo"
        zip:
          type: string
          example: "100-0001"

    User:
      type: object
      properties:
        id:
          type: integer
          example: 1
        name:
          type: string
          example: "John Doe"
        address:
          $ref: "#/components/schemas/Address"
```
- `User` の `address` プロパティは `Address` のスキーマを参照。

---

### **🔹 6️⃣ `parameters`（リクエストパラメータの定義）**
```yaml
paths:
  /users/{id}:
    get:
      summary: "ユーザー詳細の取得"
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: integer
          example: 1
      responses:
        "200":
          description: "成功"
```
- **`parameters:`** → クエリパラメータやパスパラメータを定義
- **`name:`** → パラメータ名
- **`in:`** → パラメータの場所（`query` / `path` / `header` / `cookie`）
- **`required:`** → 必須かどうか
- **`schema:`** → データ型

📌 **クエリパラメータ（例: `GET /users?limit=10`）**
```yaml
parameters:
  - name: limit
    in: query
    required: false
    schema:
      type: integer
    example: 10
```

---

### **🔹 7️⃣ `security`（認証設定）**
```yaml
components:
  securitySchemes:
    BearerAuth:
      type: http
      scheme: bearer
      bearerFormat: JWT

security:
  - BearerAuth: []
```
- **`securitySchemes:`** → 認証の方式を定義（ここでは JWT）
- **`type: http`** → HTTP 認証を指定
- **`scheme: bearer`** → Bearer トークンを使用
- **`security:`** → API に適用

---

## **✅ まとめ**
| **項目** | **説明** |
|---------|--------|
| `openapi:` | OpenAPI のバージョンを指定 |
| `info:` | API の基本情報 |
| `servers:` | API のベースURLを定義 |
| `paths:` | 各エンドポイント（`/users` など）の定義 |
| `components/schemas:` | データモデルの定義（DTO） |
| `parameters:` | クエリパラメータやパスパラメータの定義 |
| `security:` | 認証設定（JWT, Basic 認証など） |

✅ **Swagger（OpenAPI）を利用すれば、API の仕様を一元管理し、フロント & バックエンドの開発をスムーズに進められる！** 🚀