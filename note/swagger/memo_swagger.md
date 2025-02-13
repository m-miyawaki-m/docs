Swagger は **API の設計、ドキュメント化、テスト、自動生成を行うためのツールセット** で、現在は **OpenAPI** として標準化されています。

Swagger には以下のようなツールがあります：

1. **Swagger UI**  
   - OpenAPI 仕様に基づいて、ブラウザ上で API の動作確認ができるインターフェースを提供。

2. **Swagger Editor**  
   - OpenAPI 定義を YAML/JSON で記述しながら、リアルタイムでエラーチェックやプレビューができるエディタ。

3. **Swagger Codegen**  
   - OpenAPI 仕様から API クライアントやサーバースタブを自動生成するツール。

4. **OpenAPI 仕様（旧 Swagger 仕様）**  
   - API のエンドポイント、リクエスト、レスポンス、認証情報などを **YAML または JSON 形式** で記述する標準フォーマット。

## Swagger と OpenAPI の関係
もともとは **Swagger** という名称で開発されましたが、現在は **OpenAPI Initiative（OAI）** により **OpenAPI Specification（OAS）** という標準仕様として管理されています。Swagger は、その OpenAPI を活用するツール群の総称となっています。

## 利用シーン
- **API ドキュメントの作成と管理**
- **API 仕様に基づいたテストの実施**
- **API クライアントやサーバーコードの自動生成**
- **認証やエラーハンドリングの定義**
- **CI/CD パイプラインとの統合**

具体的な使い方については、あなたの管理している **「Swagger 100本ノック」** にも詳細があるので、それを元に学習を進めるとよいでしょう。


### **OpenAPIとは？**
**OpenAPI（オープンAPI）** とは、**REST API の仕様を標準化するためのフォーマット** で、API の設計、記述、可視化、テスト、コード生成などを統一的に管理できる仕様です。

かつては **Swagger Specification** と呼ばれていましたが、現在は **OpenAPI Specification（OAS）** として標準化されています。  
この仕様は **OpenAPI Initiative（OAI）** によって管理され、現在は **Linux Foundation** のプロジェクトの一部となっています。

---

## **OpenAPI の主な特徴**
1. **API 仕様を YAML / JSON で記述**
   - API のエンドポイント、リクエスト、レスポンス、認証方式などを **構造化されたフォーマット** で表現。
   - 例: `openapi.yaml`
   ```yaml
   openapi: 3.0.0
   info:
     title: Sample API
     version: 1.0.0
   paths:
     /users:
       get:
         summary: ユーザー一覧を取得
         responses:
           "200":
             description: 成功
   ```

2. **ツールとの連携**
   - **Swagger UI** でAPIドキュメントを自動生成し、ブラウザ上で確認・テスト可能。
   - **Swagger Editor** でリアルタイム編集が可能。
   - **Swagger Codegen** を使って **APIクライアントやサーバースタブのコードを自動生成** できる。

3. **バージョン管理**
   - **OpenAPI 2.0（旧 Swagger 仕様）**
   - **OpenAPI 3.0**
   - **OpenAPI 3.1（最新）**
   - OpenAPI 3.x では、`components` を利用したスキーマ管理などが強化され、再利用性が向上。

4. **プログラミング言語に依存しない**
   - Java / Python / JavaScript / TypeScript / Go など、さまざまな言語で利用可能。

5. **CI/CD との統合**
   - GitHub Actions などと組み合わせて、自動テストやバリデーションに活用可能。

---

## **Swagger との違い**
| **項目**       | **OpenAPI** | **Swagger** |
|--------------|------------|------------|
| 定義         | API の標準仕様 | OpenAPI を利用するツール群 |
| 管理団体     | OpenAPI Initiative (OAI) | SmartBear Software（Swagger の開発元） |
| 役割         | API のフォーマットを定義 | API の設計・テスト・コード生成ツール |

Swagger は **OpenAPI を活用するツール群** であり、**OpenAPI は API 仕様の標準フォーマット** です。

---

## **OpenAPI の利用シーン**
- **API の設計・管理**
  - 仕様を統一し、チーム間で API の認識を共有しやすくする。
- **API ドキュメントの自動生成**
  - Swagger UI で可読性の高いドキュメントを自動生成。
- **API クライアントの自動生成**
  - OpenAPI Generator / Swagger Codegen を使って、クライアント SDK やサーバーコードを自動生成。
- **CI/CD パイプラインとの統合**
  - OpenAPI のバリデーションを GitHub Actions などで自動化。

---

## **まとめ**
- **OpenAPI は API の仕様を標準化するためのフォーマット（旧 Swagger 仕様）**
- **YAML / JSON で記述され、Swagger UI などのツールと連携可能**
- **API の設計・テスト・コード生成・ドキュメント管理を一元化できる**
- **プログラミング言語に依存せず、CI/CD との統合にも向いている**

「Swagger 100本ノック」にも **OpenAPI** に関する詳しい解説があるので、そちらを活用するとより実践的に学べます。

### **Swagger UIとは？**
**Swagger UI** は、**OpenAPI 仕様に基づいて、API のドキュメントを自動生成し、ブラウザ上で API の動作確認ができるツール** です。  
API のリクエストやレスポンスを可視化し、直接 API を実行できるインターフェースを提供します。

---

## **Swagger UI の特徴**
1. **ブラウザ上で API のドキュメントを確認**
   - OpenAPI 仕様（YAML / JSON）をもとに **視覚的に分かりやすい API ドキュメントを自動生成** できる。
   - 例えば、以下のような API 仕様が Swagger UI によって整ったドキュメントとして表示される：
     ```yaml
     openapi: 3.0.0
     info:
       title: Sample API
       version: 1.0.0
     paths:
       /users:
         get:
           summary: ユーザー一覧を取得
           responses:
             "200":
               description: 成功
     ```
   - Swagger UI ではこの情報が **Web ページ上の API リファレンス** として表示される。

2. **API をブラウザ上でテストできる**
   - Swagger UI から API に直接リクエストを送信し、レスポンスを確認できる。
   - `GET /users` などのエンドポイントを選択し、「**Try it out**」ボタンを押すだけで実行可能。

3. **YAML / JSON の OpenAPI 定義を自動解釈**
   - OpenAPI の YAML や JSON ファイルを読み込み、API の仕様を Web UI に変換。
   - `servers`, `paths`, `parameters`, `responses` などを自動で解析。

4. **多様な認証方式に対応**
   - Basic 認証, API Key, JWT (Bearer Token), OAuth2 などの認証が UI 上で設定可能。

5. **カスタマイズが可能**
   - Swagger UI のデザインや動作をカスタマイズできる（CSS, JavaScript で変更）。
   - 独自の API ドキュメントのスタイルに調整可能。

---

## **Swagger UI の動作イメージ**
Swagger UI を開いたときの画面のイメージ：
- API のエンドポイント（GET / POST / PUT / DELETE）
- パラメータ（Query, Path, Body, Header など）
- リクエスト / レスポンスのサンプル
- 「**Try it out**」ボタンで API を実行し、レスポンスを確認

👉 **API を実際に試しながら、開発・テストが可能！**

---

## **Swagger UI の導入方法**
### 1. **Swagger UI のスタンドアロン版を利用**
**公式の Swagger UI をダウンロード**
```sh
git clone https://github.com/swagger-api/swagger-ui.git
cd swagger-ui
npm install
npm run start
```
この方法でローカル環境に Swagger UI をセットアップできる。

### 2. **CDN で簡単に利用**
CDN を利用すると、以下のように HTML に埋め込むだけで Swagger UI を使える：
```html
<!DOCTYPE html>
<html lang="ja">
<head>
  <title>Swagger UI</title>
  <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/swagger-ui/4.14.0/swagger-ui.min.css">
</head>
<body>
  <div id="swagger-ui"></div>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/swagger-ui/4.14.0/swagger-ui-bundle.min.js"></script>
  <script>
    window.onload = function() {
      const ui = SwaggerUIBundle({
        url: "https://petstore.swagger.io/v2/swagger.json",
        dom_id: "#swagger-ui",
      });
    };
  </script>
</body>
</html>
```
上記の HTML を開くと、Swagger UI で API ドキュメントが表示される。

### 3. **Spring Boot で利用**
Spring Boot + Springdoc OpenAPI を使う場合、以下の依存関係を追加する：
```xml
<dependency>
  <groupId>org.springdoc</groupId>
  <artifactId>springdoc-openapi-starter-webmvc-ui</artifactId>
  <version>2.0.2</version>
</dependency>
```
アプリを起動すると、以下の URL で Swagger UI にアクセスできる：
```
http://localhost:8080/swagger-ui.html
```

---

## **Swagger UI のメリット**
✅ **API 仕様を自動ドキュメント化**（手作業不要）  
✅ **開発者 / テスターが API を視覚的に理解しやすい**  
✅ **ブラウザ上で API を簡単にテスト可能**（Postman 不要）  
✅ **認証情報（JWT, API Key）を設定して実行可能**  
✅ **CDN / npm / Spring Boot など、導入方法が豊富**  

---

## **Swagger UI のまとめ**
| **項目**            | **内容** |
|------------------|------------|
| **用途**         | API のドキュメント生成、動作確認 |
| **フォーマット**  | OpenAPI 仕様（YAML / JSON） |
| **機能**         | API 仕様の可視化、API 実行、リクエストテスト |
| **導入方法**     | CDN, npm, Spring Boot など |
| **メリット**     | ドキュメントの自動生成・ブラウザ上で API テスト可能 |

---7

Swagger UI は、**API の仕様を見やすく整理し、簡単にテストできる強力なツール** です。  
「Swagger 100本ノック」にも **Swagger UI の詳細な使い方** が含まれているので、そちらを活用するとより実践的に学べます。

### **Swagger UI をオフライン環境に持ち込む方法**
オフライン環境で Swagger UI を利用するには、**必要なファイルを事前にダウンロード** し、オフライン環境へ持ち込む方法が有効です。  
以下の 3 つの方法を紹介します。

---

## **方法 1: Swagger UI のスタンドアロン版をオフライン環境にコピー**
Swagger UI は **HTML / JavaScript / CSS ファイルのみで動作** するため、事前にファイルをダウンロードし、オフライン環境で動作させることが可能です。

### **手順**
1. **オンライン環境で Swagger UI のリポジトリをクローン**
   ```sh
   git clone https://github.com/swagger-api/swagger-ui.git
   cd swagger-ui
   ```
2. **ビルドしてスタティックファイルを生成**
   ```sh
   npm install
   npm run build
   ```
   - `dist/` フォルダに Swagger UI のスタティックファイルが生成される。

3. **オフライン環境にコピー**
   - `swagger-ui/dist/` フォルダを USB メモリなどでオフライン環境に持ち込む。
   - 例えば、オフライン環境の `/var/www/swagger-ui/` に配置。

4. **ローカルの Web サーバーで公開**
   - オフライン環境で簡単な HTTP サーバーを立ち上げ、Swagger UI を提供する：
     ```sh
     cd /var/www/swagger-ui
     python3 -m http.server 8000
     ```
   - **アクセス URL:** `http://localhost:8000/`

---

## **方法 2: Swagger UI の ZIP ファイルをダウンロードしてオフライン利用**
Swagger UI のリリースページから ZIP ファイルをダウンロードし、オフライン環境にコピーする方法。

### **手順**
1. **オンライン環境で ZIP をダウンロード**
   - [Swagger UI Releases](https://github.com/swagger-api/swagger-ui/releases) にアクセスし、最新の `swagger-ui.zip` をダウンロード。
   
2. **オフライン環境へコピー**
   - USB メモリやネットワーク経由で ZIP をオフライン環境へコピー。

3. **ZIP を解凍し、ローカルで開く**
   - ZIP を解凍し、`dist/index.html` をブラウザで開くと Swagger UI が動作。

4. **OpenAPI の JSON / YAML を読み込む**
   - `swagger-ui/dist/swagger-initializer.js` を編集し、オフライン用の API 定義を指定：
     ```js
     window.onload = function() {
       const ui = SwaggerUIBundle({
         url: "openapi.yaml",  // オフライン用の OpenAPI ファイル
         dom_id: "#swagger-ui",
       });
     };
     ```

---

## **方法 3: Spring Boot + Springdoc OpenAPI をオフライン環境にデプロイ**
Spring Boot を利用して Swagger UI を提供する場合、オフライン環境用に必要なファイルを準備する。

### **手順**
1. **オンライン環境で必要な Maven 依存関係をダウンロード**
   - オンライン環境で `maven-dependency-plugin` を使って JAR を取得：
     ```sh
     mvn dependency:go-offline
     ```
   - 必要な JAR ファイルを USB メモリにコピー。

2. **オフライン環境に Maven のリポジトリを持ち込む**
   - `~/.m2/repository/` ディレクトリごとコピー。

3. **Spring Boot アプリに Swagger UI を組み込む**
   - `pom.xml` に以下を追加：
     ```xml
     <dependency>
       <groupId>org.springdoc</groupId>
       <artifactId>springdoc-openapi-starter-webmvc-ui</artifactId>
       <version>2.0.2</version>
     </dependency>
     ```

4. **Swagger UI のエンドポイントをオフラインで利用**
   - Spring Boot アプリを起動後、`http://localhost:8080/swagger-ui.html` でアクセス。

---

## **まとめ**
| **方法** | **概要** | **メリット** | **デメリット** |
|---------|---------|-------------|-------------|
| **方法 1: スタンドアロン版** | `swagger-ui/dist/` をオフライン環境へコピー | 軽量で簡単 | カスタマイズが必要 |
| **方法 2: ZIP ファイルの利用** | 公式リリースの `swagger-ui.zip` をダウンロード | 設定不要で簡単 | OpenAPI ファイルの手動設定が必要 |
| **方法 3: Spring Boot で提供** | Spring Boot + Springdoc OpenAPI を利用 | API との統合が容易 | Java 環境が必要 |

オフライン環境に合わせて最適な方法を選ぶとよいでしょう。  
「Swagger 100本ノック」にも導入方法が含まれているかもしれないので、そちらも参考にできます。

### **オフライン環境に `npm` を持ち込む方法**
オフライン環境で `npm` を利用するには、**事前に必要なファイルをオンライン環境で準備し、オフライン環境へコピー** する必要があります。  
以下の方法で、オフライン環境に `npm` を持ち込みましょう。

---

## **✅ 方法 1: Node.js + npm のオフラインインストール**
### **手順**
1. **オンライン環境で Node.js + npm をダウンロード**
   - [公式サイト](https://nodejs.org/en/download/) からオフライン環境に適した **オフラインインストール可能なバイナリ** を取得。
   - 例:
     - Windows: `node-v18.16.0-win-x64.zip`
     - Linux: `node-v18.16.0-linux-x64.tar.xz`

2. **オフライン環境にファイルをコピー**
   - USB メモリやネットワーク経由で `.zip` / `.tar.xz` をコピー。

3. **オフライン環境で Node.js + npm を解凍**
   - **Windows の場合**
     - ZIP を解凍後、`node.exe` と `npm.cmd` が利用可能。
     - `PATH` に追加して `cmd` で動作確認：
       ```sh
       node -v
       npm -v
       ```

   - **Linux の場合**
     ```sh
     tar -xJf node-v18.16.0-linux-x64.tar.xz -C /usr/local/
     export PATH=/usr/local/node-v18.16.0-linux-x64/bin:$PATH
     node -v
     npm -v
     ```

✅ **この方法なら `npm install` もオフラインで実行可能！**

---

## **✅ 方法 2: `nvm`（Node Version Manager）を使ってオフライン環境へ導入**
`nvm`（Node Version Manager）を利用すると、オフライン環境でも `npm` を簡単に管理できる。

### **手順**
1. **オンライン環境で `nvm` をダウンロード**
   - **Windows:** [nvm-windows](https://github.com/coreybutler/nvm-windows/releases) から `.zip` を取得。
   - **Linux/macOS:** `nvm` を事前にインストール。
     ```sh
     curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
     ```

2. **Node.js のバージョンを事前に取得**
   ```sh
   nvm install 18.16.0
   ```

3. **`~/.nvm/` ディレクトリをオフライン環境へコピー**
   ```sh
   tar -cvzf nvm.tar.gz ~/.nvm
   ```
   - USB などでオフライン環境にコピー。

4. **オフライン環境で `nvm` を展開**
   ```sh
   tar -xvzf nvm.tar.gz -C ~/
   source ~/.bashrc
   nvm use 18.16.0
   node -v
   npm -v
   ```

✅ **`nvm` を使えばオフラインでも Node.js のバージョン管理が可能！**

---

## **✅ 方法 3: npm のオフラインインストーラを作成**
npm 自体をオフライン環境に持ち込む方法。

### **手順**
1. **オンライン環境で npm をダウンロード**
   ```sh
   npm pack npm
   ```
   - これで `npm-x.x.x.tgz` （例: `npm-9.6.4.tgz`）が作成される。

2. **オフライン環境にコピー**
   - USB メモリで `.tgz` ファイルを移動。

3. **オフライン環境で npm をインストール**
   ```sh
   npm install -g ./npm-9.6.4.tgz
   npm -v
   ```

✅ **npm のオフラインインストールが可能！**

---

## **✅ 方法 4: `npm cache` をオフライン環境へコピー**
オンライン環境で事前に `npm` のキャッシュをダウンロードし、オフライン環境にコピーする。

### **手順**
1. **オンライン環境で npm のキャッシュを保存**
   ```sh
   npm install express --cache /path/to/cache
   ```
   - `/path/to/cache/` に npm のキャッシュが作成される。

2. **キャッシュフォルダをオフライン環境にコピー**
   - USB で `/path/to/cache/` をオフライン環境へ移動。

3. **オフライン環境で npm を実行**
   ```sh
   npm install --cache /path/to/cache --offline
   ```

✅ **事前に必要なパッケージをキャッシュしておけば、オフラインでも npm install が可能！**

---

## **まとめ**
| **方法** | **概要** | **メリット** | **デメリット** |
|---------|---------|-------------|-------------|
| **方法 1: Node.js バイナリを直接コピー** | 公式の `.zip` / `.tar.xz` をダウンロードしてコピー | 一番簡単で確実 | バージョン管理が手動 |
| **方法 2: `nvm` を利用** | `nvm` を使って事前に Node.js を取得し、オフラインで利用 | バージョン管理が楽 | `nvm` のインストールが必要 |
| **方法 3: npm 自体を `.tgz` でコピー** | `npm pack` で npm をオフライン用に保存 | `npm` のバージョンを変更できる | `npm install -g` の実行が必要 |
| **方法 4: `npm cache` をコピー** | 事前にキャッシュを保存してオフラインで利用 | 事前に必要なパッケージを用意できる | キャッシュが壊れる可能性 |

✅ **手軽に導入するなら方法 1（Node.js バイナリコピー）が最適！**  
✅ **バージョン管理もしたいなら方法 2（nvm）が便利！**  
✅ **npm のバージョンを固定したいなら方法 3！**  
✅ **複数の npm パッケージを事前に用意するなら方法 4！**

オフライン環境の状況に合わせて適切な方法を選んでください！

### **Swagger Editor の使い方**
Swagger Editor は、**OpenAPI 仕様（YAML / JSON）を記述し、リアルタイムで API の定義を確認できるエディタ** です。  
ブラウザ上で動作し、エラーの検出、プレビュー、コードの自動生成などの機能を備えています。

---

## **1. Swagger Editor の利用方法**
### **✅ 方法 1: オンライン版を使う（最も簡単）**
- **公式サイト:** [https://editor.swagger.io/](https://editor.swagger.io/) にアクセスするだけ。
- YAML / JSON を記述すると、リアルタイムでプレビューされる。

### **✅ 方法 2: オフライン環境で利用する**
オフライン環境に持ち込むには、Swagger Editor をローカルにインストールする方法がある。

#### **📌 手順**
1. **オンライン環境で Swagger Editor をダウンロード**
   ```sh
   git clone https://github.com/swagger-api/swagger-editor.git
   cd swagger-editor
   npm install
   npm run build
   ```
   - `dist/` フォルダが生成される。

2. **オフライン環境に `dist/` フォルダをコピー**
   - USB メモリなどでオフライン環境に移動。

3. **オフライン環境で Swagger Editor を開く**
   - `dist/index.html` をブラウザで開くだけで Swagger Editor を利用可能。

✅ **これでオフラインでも Swagger Editor を使える！**

---

## **2. Swagger Editor の基本的な操作**
### **📌 画面構成**
Swagger Editor は、**左側が YAML / JSON のエディタ、右側がプレビュー** になっている。

### **📌 基本の操作**
| 操作 | 方法 |
|------|------|
| OpenAPI 定義を書く | 左側のエディタに YAML / JSON を記述 |
| エラーチェック | リアルタイムでエラーが表示される |
| API ドキュメントを確認 | 右側に自動でレンダリングされる |
| コードの自動生成 | `Generate Client` または `Generate Server` |
| YAML / JSON 切り替え | `Convert to YAML` または `Convert to JSON` |

---

## **3. OpenAPI を記述する**
Swagger Editor では、以下のような OpenAPI 定義を書いて API を設計できる。

### **📌 サンプル**
```yaml
openapi: 3.0.0
info:
  title: サンプル API
  description: これは Swagger Editor のサンプルです。
  version: 1.0.0

servers:
  - url: https://api.example.com

paths:
  /users:
    get:
      summary: ユーザー一覧を取得
      responses:
        "200":
          description: 成功
          content:
            application/json:
              schema:
                type: array
                items:
                  type: object
                  properties:
                    id:
                      type: integer
                      example: 1
                    name:
                      type: string
                      example: "田中 太郎"
```

✅ **YAML を記述すると、右側に API のプレビューが表示される！**

---

## **4. コードの自動生成**
Swagger Editor では、**API クライアントやサーバースタブのコードを自動生成** できる。

### **📌 手順**
1. 右上の **「Generate Server」または「Generate Client」** をクリック
2. 言語を選択（Java, Python, Node.js, Spring, Go など）
3. ZIP ファイルがダウンロードされる

✅ **これで API の開発を効率化できる！**

---

## **5. JSON と YAML の相互変換**
Swagger Editor では、**YAML ⇄ JSON の変換が可能**。

### **📌 変換手順**
1. `File` → `Convert to YAML` / `Convert to JSON`
2. 自動で変換される

✅ **JSON フォーマットでの作業も簡単！**

---

## **6. OpenAPI のバリデーション**
Swagger Editor は **構文エラーをリアルタイムで検出** し、修正を促してくれる。

### **📌 例: エラーの表示**
```yaml
paths:
  /users:
    get:
      responses:
        "200":
          description: 成功
          content:
            application/json:
              schema:
                type: array
                items:
                  properties:  # ← ここに `type: object` が抜けている
                    id:
                      type: integer
```
✅ **エラーがあれば左側に警告が表示され、すぐに修正可能！**

---

## **7. Swagger Editor のメリット**
| **メリット** | **説明** |
|------------|------------|
| **ブラウザ上で動作** | インストール不要（オフラインでも可） |
| **リアルタイムプレビュー** | OpenAPI の変更がすぐに確認可能 |
| **エラーチェック機能** | 構文ミスをすぐに修正できる |
| **コード自動生成** | API クライアント / サーバースタブを生成 |
| **YAML ⇄ JSON 変換** | YAML / JSON どちらでも記述可能 |

---

## **8. まとめ**
✅ **Swagger Editor は OpenAPI 定義を記述・プレビューできるエディタ**  
✅ **オンライン版（公式サイト）とオフライン版（ローカルで実行）がある**  
✅ **エラーチェック、コード生成、フォーマット変換などの機能を備えている**  
✅ **オフライン環境なら `swagger-editor` の `dist/` を持ち込めばOK！**

オフライン環境でも利用できるように準備すれば、API 設計がスムーズになります！