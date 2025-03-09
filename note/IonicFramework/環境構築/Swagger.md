## **📌 Swagger 導入前後のアーキテクチャ構造（新旧対比）**

### **✅ 目的**
- **Swagger を導入することで API の仕様を統一し、開発・テスト・ドキュメント管理を効率化**
- **現在の jQuery + Ajax ベースの API 連携を Swagger を活用した構成に移行**
- **Ionic（React）と連携し、モダンなフロントエンドアーキテクチャに刷新**

---

## **🔹 新旧アーキテクチャの比較**
| **項目** | **旧アーキテクチャ（Swagger 未導入）** | **新アーキテクチャ（Swagger 導入後）** |
|----------|--------------------------------|--------------------------------|
| **API ドキュメント管理** | 手動（Excel / Confluence / メモ） | **Swagger UI / Swagger Editor** |
| **API 仕様の統一** | フロントとバックエンドで認識ズレが発生しやすい | **OpenAPI 仕様で統一し、一元管理** |
| **API 連携方法** | jQuery `$.ajax` を直接記述 | **`axios` + `Swagger Codegen` で API クライアント自動生成** |
| **フロントエンド** | jQuery + 手動 API 記述 | **Ionic（React）+ 自動生成 API クライアント** |
| **バックエンド（API）** | Spring Boot + MyBatis（API 手動実装） | **Swagger OpenAPI + Springdoc で API 自動ドキュメント化** |
| **API テスト** | Postman 手動テスト | **Postman + Swagger Mock API** |
| **API の変更管理** | 変更時にフロント・バック間で調整が必要 | **Swagger で変更を即時反映** |

---

## **✅ 旧アーキテクチャ（Swagger 未導入）**
**📌 課題:**  
- **API 仕様が明文化されておらず、フロントとバックの認識ズレが発生**
- **API 変更時に手作業でドキュメントを更新しなければならない**
- **API クライアント（フロント側の `$.ajax` コード）を手動で記述**
- **バックエンドの API 仕様変更がフロント側に即時反映されない**

### **🔹 旧アーキテクチャ（手作業で API 連携）**
```
[フロントエンド (jQuery)]      [バックエンド (Spring Boot + MyBatis)]
       ↓                            ↓
-------------------------------------------------
| jQuery $.ajax                    | 手動 API 実装（Spring Boot Controller）
| API 仕様は手動管理 (Excel)        | API 設計書を手動作成
| API 変更時は手動で修正            | API 変更時に手動で連絡
-------------------------------------------------
       ↓                            ↓
   フロント変更が手作業            バック変更も手作業
```

---

## **✅ 新アーキテクチャ（Swagger 導入後）**
**📌 改善点:**  
✅ **Swagger を利用し、API 仕様を OpenAPI 形式で統一**  
✅ **API 仕様の変更を Swagger で即時反映し、フロントとバックの連携がスムーズに**  
✅ **`Swagger Codegen` を活用し、API クライアントを自動生成（手動記述不要）**  
✅ **`Springdoc OpenAPI` を利用し、API のドキュメントを自動生成**

### **🔹 新アーキテクチャ（Swagger を活用した API 連携）**
```
[フロントエンド (Ionic + React)]      [バックエンド (Spring Boot + MyBatis)]
        ↓                                    ↓
---------------------------------------------------------------
| API クライアントは自動生成 (Swagger Codegen)       | Springdoc OpenAPI で API ドキュメント自動生成
| `axios` で API 通信を統一                         | API 仕様は `swagger.yaml` に統一
| API 変更時は `swagger.yaml` から自動更新         | API 変更時は `swagger.yaml` を更新
---------------------------------------------------------------
        ↓                                    ↓
  フロントは `axios` で統一                バックは Swagger に従い実装
```

---

## **✅ 新アーキテクチャの導入手順**
### **🔹 ① API 仕様を Swagger で定義**
1. **`swagger.yaml` を作成**
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
           '200':
             description: ユーザーリスト
             content:
               application/json:
                 schema:
                   type: array
                   items:
                     type: object
                     properties:
                       id:
                         type: integer
                       name:
                         type: string
   ```
2. **Swagger UI で確認**
   - `http://localhost:8080/swagger-ui.html` にアクセス

---

### **🔹 ② API クライアントを Swagger Codegen で自動生成**
1. **Swagger Codegen をインストール**
   ```sh
   wget https://repo1.maven.org/maven2/io/swagger/codegen/v3/swagger-codegen-cli/3.0.29/swagger-codegen-cli-3.0.29.jar
   ```
2. **API クライアントを生成（React 用）**
   ```sh
   java -jar swagger-codegen-cli-3.0.29.jar generate -i swagger.yaml -l javascript -o api-client
   ```
3. **フロントエンドに API クライアントを追加**
   ```sh
   npm install ./api-client
   ```

---

### **🔹 ③ バックエンドの Spring Boot に Swagger を統合**
1. **Springdoc OpenAPI を導入**
   ```xml
   <dependency>
       <groupId>org.springdoc</groupId>
       <artifactId>springdoc-openapi-starter-webmvc-ui</artifactId>
       <version>2.0.2</version>
   </dependency>
   ```
2. **Spring Boot アプリを起動**
   - `http://localhost:8080/swagger-ui.html` で API ドキュメントを確認

---

## **✅ 新アーキテクチャのメリット**
| **項目** | **旧アーキテクチャ** | **新アーキテクチャ（Swagger）** |
|----------|------------------|----------------------------|
| **API 仕様管理** | 手作業（Excel / Confluence） | **Swagger で統一** |
| **API クライアントの作成** | jQuery `$.ajax` を手書き | **Swagger Codegen で自動生成** |
| **API 変更時の対応** | 手動修正 & 連絡が必要 | **Swagger を更新すれば自動反映** |
| **テスト方法** | Postman で手動テスト | **Postman + Swagger Mock API** |
| **開発スピード** | フロント & バックの調整が必要 | **自動化により短縮** |

---

## **🚀 まとめ**
✅ **Swagger 導入により、API 仕様を統一し、開発スピードを向上！**  
✅ **フロントエンドの API クライアントを Swagger Codegen で自動生成し、手作業を削減！**  
✅ **Swagger UI で API 仕様を即時確認し、ドキュメント更新の手間を削減！**  
✅ **Springdoc OpenAPI により、バックエンドの API ドキュメントも自動化！**  

**👉 Swagger を導入すれば、API の管理・開発がスムーズになり、フロント & バックの連携が強化される！** 🚀

### **✅ React から呼び出す API クライアントの生成が必要か？**
**結論:**  
👉 **単純に `axios` を使うだけでなく、API クライアントを生成するほうが望ましい！**  
👉 **Swagger Codegen または OpenAPI Generator を利用し、React から API を簡単に呼び出せるようにする！**  
👉 **これにより、API 変更時の修正コストを削減し、型安全な通信が可能になる！**

---

## **🔹 なぜ API クライアントを自動生成するのか？**
**従来の `axios` を直接使う方法の課題**
1. **手動で API のリクエスト・レスポンスを管理しなければならない**  
   - `axios.get("/users")` のように URL を手書きすると、API 変更時にすべて修正する必要がある。
   
2. **レスポンスの型情報がなく、バグが発生しやすい**  
   - `axios` の戻り値を適切に型付けしないと、データ構造が変わったときにエラーが発生。

3. **API の仕様変更時にフロントエンドの修正が手間**  
   - バックエンドのエンドポイントやパラメータが変更されると、手動で修正しなければならない。

**API クライアントを自動生成するメリット**
✅ **Swagger（OpenAPI）を基に、自動的に TypeScript 型付きの API クライアントを生成できる！**  
✅ **API の変更があった場合、自動生成するだけでフロント側を更新できる！**  
✅ **フロントエンドのコードが統一され、可読性・保守性が向上！**  

---

## **🔹 API クライアントの生成方法**
### **1️⃣ Swagger Codegen を利用して API クライアントを生成**
Swagger Codegen を利用すると、OpenAPI（Swagger）仕様の `swagger.yaml` から React 用の API クライアントを自動生成できる。

### **📌 手順**
1. **Swagger Codegen をダウンロード**
   ```sh
   wget https://repo1.maven.org/maven2/io/swagger/codegen/v3/swagger-codegen-cli/3.0.29/swagger-codegen-cli-3.0.29.jar
   ```
2. **API クライアントを生成（JavaScript / TypeScript）**
   ```sh
   java -jar swagger-codegen-cli-3.0.29.jar generate \
     -i swagger.yaml \
     -l typescript-fetch \
     -o ./generated-client
   ```
   - `-l typescript-fetch` → TypeScript + Fetch API で生成
   - `-o ./generated-client` → 出力先を `generated-client` ディレクトリに設定

3. **生成された API クライアントをインストール**
   ```sh
   cd generated-client
   npm install
   ```
4. **React コンポーネントで利用**
   ```tsx
   import { UserApi } from "./generated-client";

   const api = new UserApi();
   api.getUsers().then(users => console.log(users));
   ```

---

### **2️⃣ OpenAPI Generator を利用する（Swagger Codegen の代替）**
OpenAPI Generator は Swagger Codegen のフォーク版で、より多くの言語に対応している。

### **📌 手順**
1. **OpenAPI Generator CLI をインストール**
   ```sh
   npm install -g @openapitools/openapi-generator-cli
   ```
2. **API クライアントを生成**
   ```sh
   openapi-generator-cli generate \
     -i swagger.yaml \
     -g typescript-axios \
     -o ./generated-client
   ```
   - `-g typescript-axios` → `axios` を使った TypeScript の API クライアントを生成

3. **生成された API クライアントをインストール**
   ```sh
   cd generated-client
   npm install
   ```
4. **React から API クライアントを利用**
   ```tsx
   import { DefaultApi } from "./generated-client";

   const api = new DefaultApi();
   api.getUsers().then(response => console.log(response.data));
   ```

---

## **🔹 直接 `axios` を使う場合との比較**
| **項目** | **手動 `axios` 実装** | **Swagger Codegen / OpenAPI Generator** |
|----------|--------------------|--------------------------------|
| **API 仕様の変更対応** | 手動修正が必要 | `swagger.yaml` を更新して再生成 |
| **型安全性** | `any` になりやすい | **TypeScript 型が自動生成される** |
| **開発の手間** | 手書きで `axios.get()` を記述 | **クライアントの関数を自動生成** |
| **メンテナンス** | API 変更時に手動修正が多い | **自動生成のため修正不要** |

✅ **OpenAPI Generator を使えば `axios` ベースの API クライアントが自動生成され、開発が楽になる！**  
✅ **手書きの API 通信コードを削減し、保守性を向上できる！**  

---

## **🚀 まとめ**
✅ **単純に `axios` を使うのではなく、Swagger（OpenAPI）を活用して API クライアントを自動生成するのが望ましい！**  
✅ **`Swagger Codegen` または `OpenAPI Generator` を利用すれば、型安全な API クライアントを生成可能！**  
✅ **API 仕様の変更があった場合、自動生成すればフロントのコード修正が最小限で済む！**  
✅ **フロントエンドの API 通信を統一し、開発効率・メンテナンス性を向上！**  

**👉 `axios` を手動で記述するのではなく、Swagger Codegen で自動生成するのがベスト！** 🚀

### **✅ フロントエンドだけ Swagger を利用するべきか？**
**結論:**  
**❌ フロントエンドだけで Swagger を利用すると、バックエンドとの連携が不完全になり、メリットが半減する。**  
**✅ バックエンド（Java + Spring Boot）にも Swagger（OpenAPI）を統合し、API ドキュメントを自動生成するべき。**

---

## **🔹 フロントだけ Swagger を利用した場合の問題点**
| **項目** | **フロントだけ Swagger 利用** | **フロント & バックエンドで Swagger 利用** |
|----------|----------------|----------------|
| **API ドキュメントの正確性** | バックエンドの実装と `swagger.yaml` のズレが発生する可能性 | **バックエンドから自動生成するため、ドキュメントのズレが発生しない** |
| **API 変更時の対応** | 手動で `swagger.yaml` を修正する必要がある | **コードベースから OpenAPI を自動生成できる** |
| **API クライアントの自動生成** | OpenAPI 仕様が手動管理のため、フロントでの修正が頻繁に発生 | **API 変更時に OpenAPI から自動生成できる** |
| **開発スピード** | API 変更時にフロントとバックで調整が必要 | **自動生成により、API 変更が即座にフロントへ反映** |
| **バックエンド側のメリット** | なし | **API テストやデバッグが容易になる** |

✅ **バックエンドで Swagger（OpenAPI）を利用すれば、API の定義をコードベースから自動生成できるため、フロントとバックの仕様ズレを防ぐ！**  
✅ **フロントエンドは、その OpenAPI 仕様を元に `Swagger Codegen` で API クライアントを自動生成できる！**  

---

## **✅ フロント & バックエンド両方で Swagger を利用するべき理由**
1. **API のドキュメントをバックエンドで自動生成**
   - `Springdoc OpenAPI` を利用すれば、Spring Boot の API から **自動で OpenAPI 仕様を生成** できる。
   - API の修正があった場合、Swagger のドキュメントが **自動更新される**。

2. **フロントエンドの API クライアントを自動生成**
   - バックエンドが提供する `swagger.yaml` を元に、フロントエンドの `axios` クライアントを自動生成できる。
   - **API の変更が即座にフロントへ反映され、手作業が不要になる。**

3. **API 仕様のズレを防ぐ**
   - フロントだけで `swagger.yaml` を管理すると、バックエンドとの仕様のズレが発生する可能性が高い。
   - バックエンド側で **`swagger.yaml` を自動生成** し、それをフロントで利用すれば、仕様が統一される。

---

## **✅ フロント & バックエンド両方で Swagger を利用する構成**
### **📌 アーキテクチャ構成**
```
[フロントエンド (Ionic + React)]
    ↓
---------------------------------------------------------------
| Swagger Codegen で API クライアントを自動生成               |
| axios を使って API を呼び出し (`axios.get('/users')`)      |
| OpenAPI 仕様に基づいた TypeScript 型定義が自動生成        |
---------------------------------------------------------------
    ↓
[バックエンド (Spring Boot + MyBatis)]
    ↓
---------------------------------------------------------------
| Springdoc OpenAPI で API 定義を自動生成 (`swagger.yaml`) |
| API 仕様変更時に Swagger UI で確認                        |
| `http://localhost:8080/swagger-ui.html` で API を可視化  |
---------------------------------------------------------------
```

---

## **✅ 実装手順**
### **🔹 1️⃣ バックエンド（Spring Boot）で Swagger を導入**
1. **Springdoc OpenAPI の導入**
   - `pom.xml` に以下の依存関係を追加
   ```xml
   <dependency>
       <groupId>org.springdoc</groupId>
       <artifactId>springdoc-openapi-starter-webmvc-ui</artifactId>
       <version>2.0.2</version>
   </dependency>
   ```
2. **API 定義を自動生成**
   ```java
   @RestController
   @RequestMapping("/users")
   @Tag(name = "ユーザー管理")
   public class UserController {

       @Operation(summary = "ユーザー一覧を取得")
       @GetMapping
       public List<User> getUsers() {
           return userService.getUsers();
       }
   }
   ```
3. **Swagger UI で API を確認**
   - `http://localhost:8080/swagger-ui.html` にアクセスすると API ドキュメントが確認できる。

---

### **🔹 2️⃣ フロントエンド（Ionic + React）で API クライアントを自動生成**
1. **バックエンドの `swagger.yaml` を取得**
   ```sh
   curl -o swagger.yaml http://localhost:8080/v3/api-docs
   ```
2. **Swagger Codegen を使って API クライアントを自動生成**
   ```sh
   java -jar swagger-codegen-cli-3.0.29.jar generate \
     -i swagger.yaml \
     -l typescript-axios \
     -o ./generated-client
   ```
3. **React プロジェクトに API クライアントを組み込む**
   ```tsx
   import { DefaultApi } from "./generated-client";

   const api = new DefaultApi();
   api.getUsers().then(response => console.log(response.data));
   ```
✅ **これで、バックエンドの API 変更が即座にフロントへ反映される！**

---

## **✅ まとめ**
| **フロントだけ Swagger** | **フロント & バックエンド Swagger** |
|----------------|----------------------------|
| 手動で `swagger.yaml` を管理 | **バックエンドから自動生成** |
| API 変更時に手作業で修正 | **OpenAPI 仕様が即座に反映** |
| 仕様ズレが発生しやすい | **フロントとバックの統一が保たれる** |
| フロントの `axios` 記述が手作業 | **API クライアントを自動生成** |

✅ **フロントエンドだけで Swagger を利用するのではなく、バックエンドにも導入し、API 仕様を統一するべき！**  
✅ **Swagger を活用すれば、API のドキュメント生成、クライアントの自動生成、テストの効率化が可能！**  
✅ **Spring Boot + Springdoc OpenAPI で `swagger.yaml` を自動生成し、それを React 側で利用するのがベストプラクティス！**

**👉 Swagger をフロントだけでなくバックエンドにも統合し、API 連携を効率化しよう！** 🚀


### **✅ Springdoc OpenAPI を導入すれば自動生成できるが、API 解析は必要！**
**結論:**  
👉 **Springdoc OpenAPI を導入すれば API ドキュメントを自動生成できるが、それだけでは不十分。**  
👉 **既存のプロジェクトの API 仕様を正しく把握しないと、Swagger に反映されない or 間違った仕様が生成される可能性がある。**  
👉 **特に、MyBatis + Spring Boot の既存 API では、Swagger だけで把握できない部分があるため、事前の API 解析が必要。**

---

## **🔹 Springdoc OpenAPI だけでは不十分な理由**
| **問題点** | **理由** | **対策** |
|----------|---------|---------|
| **適切な API の説明が自動生成されない** | OpenAPI の `@Operation` や `@Schema` を記述しないと、意図したドキュメントが作られない | **エンドポイントごとにアノテーションを追加する必要がある** |
| **DTO の構造が正しく取得できないことがある** | `@RestController` の戻り値が `ResponseEntity` だと、Swagger が型を解釈できない場合がある | **DTO に `@Schema` を追加して型情報を明示** |
| **認証やリクエストパラメータが正しく反映されない** | `@RequestParam` や `@RequestBody` の説明が省略されることがある | **`@Parameter` や `@RequestBody` の記述を追加** |
| **MyBatis の SQL 定義が Swagger に含まれない** | `Mapper.xml` の SQL は Swagger には自動反映されない | **手動で SQL の内容を整理し、API に適用する** |

---

## **✅ Springdoc OpenAPI の導入手順**
**Springdoc OpenAPI を導入し、既存 API から自動でドキュメントを生成する方法。**

### **📌 1️⃣ 依存関係の追加**
1. **`pom.xml` に `Springdoc OpenAPI` を追加**
   ```xml
   <dependency>
       <groupId>org.springdoc</groupId>
       <artifactId>springdoc-openapi-starter-webmvc-ui</artifactId>
       <version>2.0.2</version>
   </dependency>
   ```
2. **アプリを再起動**
   - `http://localhost:8080/swagger-ui.html` にアクセスすると、API ドキュメントが自動生成される。

---

### **📌 2️⃣ API にアノテーションを追加**
**🔍 自動生成だけでは情報が不足するため、以下のアノテーションを追加する。**

#### **✔ API の説明を追加**
```java
@RestController
@RequestMapping("/users")
@Tag(name = "ユーザー管理", description = "ユーザー情報の取得・登録・更新を管理するAPI")
public class UserController {

    @Operation(summary = "ユーザー一覧を取得", description = "登録されている全ユーザーを取得します。")
    @GetMapping
    public List<UserDto> getUsers() {
        return userService.getUsers();
    }
}
```

#### **✔ DTO に型情報を追加**
```java
@Data
@Schema(description = "ユーザー情報のDTO")
public class UserDto {
    @Schema(description = "ユーザーID", example = "1")
    private Long id;

    @Schema(description = "ユーザー名", example = "John Doe")
    private String name;

    @Schema(description = "メールアドレス", example = "john@example.com")
    private String email;
}
```

#### **✔ パラメータの説明を追加**
```java
@Operation(summary = "特定のユーザー情報を取得")
@GetMapping("/{id}")
public UserDto getUser(
    @Parameter(description = "取得するユーザーのID", example = "1")
    @PathVariable Long id
) {
    return userService.getUserById(id);
}
```

---

### **📌 3️⃣ 認証情報の追加**
**JWT 認証を使用している場合、Swagger UI で認証を設定する必要がある。**

#### **✔ SecurityConfig に OpenAPI のセキュリティ設定を追加**
```java
@SecurityScheme(
    name = "bearerAuth",
    scheme = "bearer",
    type = SecuritySchemeType.HTTP,
    in = SecuritySchemeIn.HEADER
)
public class OpenApiConfig {}
```

#### **✔ API に認証情報を適用**
```java
@Operation(summary = "ユーザー情報の取得", security = {@SecurityRequirement(name = "bearerAuth")})
@GetMapping("/{id}")
public UserDto getUser(@PathVariable Long id) {
    return userService.getUserById(id);
}
```

✅ **Swagger UI で「Authorize」ボタンをクリックすると、JWT を入力して認証できるようになる！**

---

## **✅ 既存 API の解析を行うべき理由**
### **🔹 Springdoc OpenAPI だけでは見落としが発生する可能性がある**
| **解析項目** | **Springdoc で自動取得できるか？** | **手動で補足すべき項目** |
|-------------|----------------|----------------|
| **エンドポイント一覧** | ✅ 自動取得できる | - |
| **リクエストパラメータ** | 🔶 省略される可能性あり | `@Parameter` を手動追加 |
| **レスポンスの型情報** | 🔶 `ResponseEntity` だと不明 | `@Schema` を DTO に追加 |
| **認証（JWT など）** | ❌ 取得できない | `@SecurityScheme` を追加 |
| **MyBatis の SQL クエリ** | ❌ 取得できない | `Mapper.xml` を手動でドキュメント化 |

✅ **Springdoc OpenAPI を導入するだけでは、自動生成されない情報が多いため、API 解析が必要！**  

---

## **✅ まとめ**
### **❌ API 解析なしで Springdoc OpenAPI を導入すると？**
1. **Swagger に表示される情報が不完全になり、フロントとバックの連携ミスが発生する**
2. **リクエストパラメータやレスポンスの型情報が不足し、開発時に混乱が生じる**
3. **認証（JWT など）が Swagger に反映されず、API テストができなくなる**
4. **MyBatis の SQL 定義が Swagger に含まれず、データ取得の仕組みが不明になる**

### **✅ API 解析を行って Springdoc OpenAPI を適用すれば？**
1. **エンドポイント、リクエスト、レスポンスが正しく Swagger に反映される**
2. **フロントエンド（React）が `Swagger Codegen` を使って API クライアントを自動生成できる**
3. **認証が Swagger UI でテスト可能になり、開発がスムーズに進む**
4. **MyBatis の SQL 定義もドキュメント化され、API の内部構造が明確になる**

✅ **Springdoc OpenAPI を導入するだけでは不十分！**  
✅ **API のリクエスト・レスポンス・認証・データ構造を事前に解析し、Swagger に適切に反映する必要がある！**  
✅ **正しく設定すれば、フロントエンドとバックエンドの連携がスムーズになり、開発効率が向上する！** 🚀

### **✅ フロントのみ Swagger を導入し、バックエンドの解析結果を手動で作成してもよいか？**
**結論:**  
👉 **段階的なアプローチとして、最初にフロントエンドのみ Swagger（OpenAPI）を導入し、バックエンドの解析結果を手動で作成する方法は可能。**  
👉 **ただし、最終的にはバックエンドにも Swagger（Springdoc OpenAPI）を導入し、API 仕様を統一するべき。**  

---

## **🔹 段階的に Swagger を導入するメリット**
| **段階** | **メリット** | **デメリット・リスク** |
|---------|------------|----------------|
| **① フロントのみ Swagger を導入** | - 既存 API 仕様をすぐに整備できる<br>- React 側の開発を先行できる | - 手動作成の API ドキュメントが古くなる可能性<br>- API 変更時にフロントとバックのズレが発生する |
| **② バックエンド解析（手動ドキュメント作成）** | - API の全体構造を整理できる<br>- 開発メンバー間で API の認識を統一できる | - 手動管理のため更新作業が発生 |
| **③ バックエンドにも Swagger を導入** | - API 変更が即 Swagger に反映される<br>- フロントが `Swagger Codegen` で API クライアントを自動生成できる | - 最初のセットアップ作業が必要 |

✅ **まずフロントエンド（Ionic + React）から Swagger（OpenAPI）を導入し、バックエンドの API を解析して手動で `swagger.yaml` を作成するアプローチは有効！**  
✅ **ただし、最終的にはバックエンド（Spring Boot + MyBatis）側にも Swagger（Springdoc OpenAPI）を導入し、API 仕様を自動管理するのが望ましい！**

---

## **✅ ① フロントエンドのみ Swagger を導入**
**📌 手順**
1. **バックエンドの API 解析を手動で実施**
   - `@RestController` のエンドポイントを調査し、手動で `swagger.yaml` を作成。
   - `Postman` でリクエストを確認し、リクエスト・レスポンスの JSON を `swagger.yaml` に反映。

2. **`swagger.yaml` を作成**
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
           '200':
             description: ユーザーリスト
             content:
               application/json:
                 schema:
                   type: array
                   items:
                     type: object
                     properties:
                       id:
                         type: integer
                       name:
                         type: string
   ```

3. **Swagger Codegen を使い、フロント用 API クライアントを自動生成**
   ```sh
   openapi-generator-cli generate -i swagger.yaml -g typescript-axios -o ./generated-client
   ```

4. **フロントエンド（React）で API クライアントを利用**
   ```tsx
   import { DefaultApi } from "./generated-client";

   const api = new DefaultApi();
   api.getUsers().then(response => console.log(response.data));
   ```

✅ **この方法なら、バックエンドの Swagger 導入を待たずにフロントの開発を進められる！**

---

## **✅ ② バックエンド解析（手動ドキュメント作成）**
**📌 解析項目**
| **調査項目** | **調査内容** |
|-------------|----------------|
| **API エンドポイント** | `@GetMapping`, `@PostMapping`, `@PutMapping` の一覧 |
| **リクエストパラメータ** | `@RequestParam`, `@RequestBody` の確認 |
| **レスポンスデータ** | `@ResponseBody`, `DTO` クラスの確認 |
| **認証方式** | JWT / セッション / OAuth2 など |
| **MyBatis の SQL 定義** | `Mapper.xml` で使用されている SQL |

**📌 調査手順**
1. **Spring Boot の `@RestController` の一覧を取得**
   ```sh
   find src/main/java -name "*.java" | xargs grep "@RestController"
   ```
2. **API エンドポイントを確認**
   ```sh
   find src/main/java -name "*.java" | xargs grep "@GetMapping"
   ```

✅ **これらの情報を `swagger.yaml` に手動で記述し、フロントの `Swagger Codegen` で活用する。**

---

## **✅ ③ バックエンドにも Swagger を導入**
**📌 手動作成した `swagger.yaml` を Springdoc OpenAPI に統合する**
1. **`pom.xml` に依存関係を追加**
   ```xml
   <dependency>
       <groupId>org.springdoc</groupId>
       <artifactId>springdoc-openapi-starter-webmvc-ui</artifactId>
       <version>2.0.2</version>
   </dependency>
   ```
2. **Spring Boot の API に Swagger アノテーションを追加**
   ```java
   @RestController
   @RequestMapping("/users")
   @Tag(name = "ユーザー管理")
   public class UserController {

       @Operation(summary = "ユーザー一覧を取得")
       @GetMapping
       public List<UserDto> getUsers() {
           return userService.getUsers();
       }
   }
   ```
3. **Swagger UI で API を確認**
   - `http://localhost:8080/swagger-ui.html` にアクセスすると、Swagger がバックエンドで動作！

✅ **最終的に、手動管理の `swagger.yaml` を不要にし、Springdoc OpenAPI に置き換えられる！**

---

## **✅ まとめ**
| **段階** | **作業内容** | **メリット** | **デメリット・リスク** |
|---------|------------|------------|----------------|
| **① フロントのみ Swagger を導入** | `swagger.yaml` を手動作成し、フロントの API クライアントを自動生成 | フロントの開発をすぐ開始可能 | `swagger.yaml` の手動更新が必要 |
| **② バックエンドの API 解析** | `@RestController`, `DTO`, `MyBatis` の調査 | API 仕様の全体像を把握 | ドキュメントの更新が手作業 |
| **③ バックエンドに Swagger を導入** | Springdoc OpenAPI を適用し、API ドキュメントを自動生成 | API の仕様変更が即座に反映 | 最初の導入作業が必要 |

✅ **まずフロントエンドのみ Swagger を導入し、バックエンドの API 解析を手動で進めても問題なし！**  
✅ **最終的には、バックエンドにも Swagger（Springdoc OpenAPI）を導入し、API 仕様を統一するのがベスト！** 🚀