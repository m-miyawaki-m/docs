以下に **TypeScript + jQuery + Cookie ライブラリのオフライン環境構築手順** をまとめました。  
これで **オフライン環境でも TypeScript、jQuery、Cookie を利用した開発が可能** になります 🚀

---

# **📌 TypeScript + jQuery + Cookie ライブラリのオフライン環境構築手順**

## **✅ 1. 必要な `.tgz` パッケージをオンライン環境で準備**
オフライン環境では `npm install` でパッケージを取得できないため、**事前に `.tgz` ファイルを作成** し、それをオフライン環境に移動します。

### **📌 1-1. オンライン環境で `.tgz` を作成**
まず、オンライン環境で以下のコマンドを実行し、必要なパッケージを `.tgz` に保存します。

```sh
npm pack typescript ts-node @types/node jquery @types/jquery cookie
```

これにより、以下の `.tgz` ファイルが作成されます：

```sh
typescript-5.8.2.tgz
ts-node-10.9.2.tgz
types-node-22.13.10.tgz
jquery-3.7.1.tgz
types-jquery-3.5.32.tgz
cookie-0.5.0.tgz
```

### **📌 1-2. `.tgz` をオフライン環境へ移動**
取得した `.tgz` ファイルをオフライン環境の作業ディレクトリ（例: `C:\Development\git\ts_sample`）に移動します。

---

## **✅ 2. オフライン環境で TypeScript + jQuery + Cookie をセットアップ**
### **📌 2-1. `.tgz` ファイルを使ってインストール**
オフライン環境の作業ディレクトリ (`C:\Development\git\ts_sample`) に移動し、以下のコマンドを実行：

```powershell
npm install ./typescript-5.8.2.tgz ./ts-node-10.9.2.tgz ./types-node-22.13.10.tgz ./jquery-3.7.1.tgz ./types-jquery-3.5.32.tgz ./cookie-1.0.2.tgz --cache ./.npm-cache
```

✅ **成功すると、以下のようなメッセージが表示されるはずです。**
```sh
added 20 packages in Xs
```

### **📌 2-2. インストールされたパッケージを確認**
```powershell
npm list --depth=0
```

✅ **出力例**
```sh
ts_sample@ C:\Development\git\ts_sample
├── @types/jquery@3.5.32
├── @types/node@22.13.10
├── jquery@3.7.1
├── ts-node@10.9.2
├── typescript@5.8.2
└── cookie@1.0.2
```
**これで TypeScript + jQuery + Cookie の環境が整いました！** 🎉

---

## **✅ 3. `tsconfig.json` の作成**
### **📌 3-1. `tsconfig.json` を生成**
以下のコマンドを実行し、TypeScript の設定ファイルを作成します。

```powershell
npx tsc --init
```

### **📌 3-2. `tsconfig.json` を編集**
作成された `tsconfig.json` を開き、以下のように修正します。

```json
{
  "compilerOptions": {
    "outDir": "dist",
    "module": "commonjs",
    "moduleResolution": "node",
    "allowJs": true,  // jQuery の JavaScript を扱うため
    "checkJs": false  // JavaScript の型チェックを無効化
  }
}
```

---

## **✅ 4. TypeScript + jQuery + Cookie の動作確認**
### **📌 4-1. `src/index.ts` を作成**
以下の内容で `src/index.ts` を作成します。

```typescript
import * as $ from "jquery";
import * as cookie from "cookie";

// クッキーをセットする関数
function setCookie(name: string, value: string, days: number) {
    let expires = "";
    if (days) {
        const date = new Date();
        date.setTime(date.getTime() + days * 24 * 60 * 60 * 1000);
        expires = "; expires=" + date.toUTCString();
    }
    document.cookie = name + "=" + encodeURIComponent(value) + "; path=/;" + expires;
    console.log("✅ Cookie Set:", document.cookie);
}

// クッキーを取得する関数
function getCookie(name: string): string | null {
    const match = document.cookie.match(new RegExp("(^| )" + name + "=([^;]+)"));
    return match ? decodeURIComponent(match[2]) : null;
}

$(document).ready(() => {
    $("body").append("<h1>Hello, TypeScript + jQuery + Cookie!</h1>");

    // クッキーを設定
    setCookie("sessionID", "abcdef123456", 1);

    // クッキーを取得
    const sessionID = getCookie("sessionID");
    console.log("🎯 Retrieved Session ID:", sessionID);
});
```

---

### **📌 4-2. TypeScript をコンパイル**
```powershell
npx tsc
```

✅ **成功すると、`dist/index.js` にコンパイルされた JavaScript が生成されます。**

---

### **📌 4-3. `index.html` を作成し、jQuery を適用**
次に、`index.html` を作成し、コンパイル済みの `dist/index.js` を読み込みます。

```html
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TypeScript + jQuery + Cookie</title>
    <script src="dist/index.js"></script>
</head>
<body>
</body>
</html>
```

### **📌 4-4. `index.html` をブラウザで開く**
ブラウザで `index.html` を開くと **「Hello, TypeScript + jQuery + Cookie!」が表示され、クッキーが設定・取得されれば成功！** 🎉

---

## **✅ 5. `package.json` に `.tgz` を登録（オプション）**
今後の開発を楽にするために、`package.json` に `.tgz` のパスを追加。

### **📌 5-1. `package.json` を編集**
手動で `package.json` を編集し、`dependencies` に `.tgz` のパスを追加。

```json
{
  "dependencies": {
    "@types/jquery": "file:types-jquery-3.5.32.tgz",
    "@types/node": "file:types-node-22.13.10.tgz",
    "jquery": "file:jquery-3.7.1.tgz",
    "ts-node": "file:ts-node-10.9.2.tgz",
    "typescript": "file:typescript-5.8.2.tgz",
    "cookie": "file:cookie-0.5.0.tgz"
  }
}
```

### **📌 5-2. `npm install` を実行**
```powershell
npm install
```

✅ **これで `npm install` だけでオフライン環境でもパッケージが管理可能！**

---

## **🎯 まとめ**
| 手順 | 内容 |
|------|------|
| **1** | オンライン環境で `.tgz` を作成 (`npm pack`) |
| **2** | `.tgz` をオフライン環境へ移動 |
| **3** | `npm install` でオフライン環境にインストール |
| **4** | `tsconfig.json` を作成し、TypeScript の設定を適用 |
| **5** | `npx tsc` で TypeScript をコンパイル |
| **6** | `index.html` で jQuery + Cookie の動作を確認 |

✅ **オフライン環境でも TypeScript + jQuery + Cookie を使った開発が可能！** 🚀  
エラーが出たら、どの手順で問題が発生したか教えてください！ 😊


以下に、**TypeScript + jQuery で API リクエストを作成するサンプルコード** を用意しました。  
このコードは **GET / POST / PUT / DELETE** の各 HTTP メソッドを使って WebLogic などのバックエンド API にリクエストを送信できます。

---

## **📌 1. TypeScript + jQuery で API リクエストを作成**
### **✅ 汎用的な `fetchApi` 関数**
まず、API リクエストを簡単に管理するための **汎用関数** を作成します。

```typescript
import * as $ from "jquery"; // jQuery をインポート

type HttpMethod = "GET" | "POST" | "PUT" | "DELETE";

interface ApiRequestOptions {
  method: HttpMethod;
  url: string;
  data?: any;
  headers?: Record<string, string>;
}

async function fetchApi<T>({ method, url, data, headers = {} }: ApiRequestOptions): Promise<T> {
  return new Promise((resolve, reject) => {
    $.ajax({
      url,
      type: method,
      data: method === "GET" ? data : JSON.stringify(data),
      contentType: "application/json",
      headers,
      success: (response) => resolve(response),
      error: (xhr, status, error) => reject(`Error: ${status}, ${error}`),
    });
  });
}
```

✅ **ポイント**
- **`fetchApi<T>()` を使えば、どの API でも簡単にリクエストが送信できる！**
- **Promise を返す** ため、`async/await` で使いやすい。
- **デフォルトで `Content-Type: application/json`** を設定。

---

## **📌 2. 実際の API リクエストの使い方**
### **✅ `GET` リクエスト**
WebLogic の API から **データを取得** する。

```typescript
async function getUsers() {
  try {
    const users = await fetchApi<{ id: number; name: string }[]>({
      method: "GET",
      url: "http://localhost:7001/api/users",
    });
    console.log("Users:", users);
  } catch (error) {
    console.error(error);
  }
}

getUsers();
```

---

### **✅ `POST` リクエスト**
新しいユーザーを作成する。

```typescript
async function createUser() {
  try {
    const newUser = { name: "John Doe", age: 30 };
    const response = await fetchApi<{ id: string }>({
      method: "POST",
      url: "http://localhost:7001/api/users",
      data: newUser,
    });
    console.log("User created:", response);
  } catch (error) {
    console.error(error);
  }
}

createUser();
```

---

### **✅ `PUT` リクエスト**
既存のユーザー情報を更新する。

```typescript
async function updateUser(userId: string) {
  try {
    const updatedUser = { name: "John Doe Updated", age: 31 };
    const response = await fetchApi({
      method: "PUT",
      url: `http://localhost:7001/api/users/${userId}`,
      data: updatedUser,
    });
    console.log("User updated:", response);
  } catch (error) {
    console.error(error);
  }
}

updateUser("12345");
```

---

### **✅ `DELETE` リクエスト**
ユーザーを削除する。

```typescript
async function deleteUser(userId: string) {
  try {
    await fetchApi({
      method: "DELETE",
      url: `http://localhost:7001/api/users/${userId}`,
    });
    console.log(`User ${userId} deleted.`);
  } catch (error) {
    console.error(error);
  }
}

deleteUser("12345");
```

---

## **📌 3. `application/x-www-form-urlencoded` でリクエストを送る**
WebLogic では `application/json` ではなく **`application/x-www-form-urlencoded`** を求められることがあります。

### **✅ `application/x-www-form-urlencoded` を使う場合**
```typescript
async function sendFormEncodedData() {
  const params = new URLSearchParams();
  params.append("name", "John Doe");
  params.append("age", "30");

  $.ajax({
    url: "http://localhost:7001/api/users",
    type: "POST",
    contentType: "application/x-www-form-urlencoded",
    data: params.toString(),
    success: (response) => console.log("Response:", response),
    error: (xhr, status, error) => console.error("AJAX Error:", error),
  });
}

sendFormEncodedData();
```

---

## **📌 4. `fetchApi` に Basic 認証 / JWT を追加**
### **✅ Basic 認証**
```typescript
async function fetchWithBasicAuth() {
  const username = "admin";
  const password = "password";
  const authHeader = "Basic " + btoa(`${username}:${password}`);

  try {
    const response = await fetchApi({
      method: "GET",
      url: "http://localhost:7001/api/secure-data",
      headers: { Authorization: authHeader },
    });
    console.log("Secure Data:", response);
  } catch (error) {
    console.error(error);
  }
}

fetchWithBasicAuth();
```

---

### **✅ JWT 認証**
```typescript
async function fetchWithJWT(token: string) {
  try {
    const response = await fetchApi({
      method: "GET",
      url: "http://localhost:7001/api/secure-data",
      headers: { Authorization: `Bearer ${token}` },
    });
    console.log("Secure Data:", response);
  } catch (error) {
    console.error(error);
  }
}

const jwtToken = "your_jwt_token_here";
fetchWithJWT(jwtToken);
```

---

## **🎯 まとめ**
| 機能 | 実装方法 |
|------|---------|
| **`GET` リクエスト** | `fetchApi({ method: "GET", url })` |
| **`POST` リクエスト** | `fetchApi({ method: "POST", url, data })` |
| **`PUT` リクエスト** | `fetchApi({ method: "PUT", url, data })` |
| **`DELETE` リクエスト** | `fetchApi({ method: "DELETE", url })` |
| **`application/x-www-form-urlencoded`** | `$.param()` を使う |
| **Basic 認証** | `headers: { Authorization: "Basic " + btoa("user:pass") }` |
| **JWT 認証** | `headers: { Authorization: "Bearer " + token }` |

---

## **🚀 使い方**
1. **`fetchApi<T>()` を使って API を簡単に呼び出せる！**
2. **GET / POST / PUT / DELETE すべてに対応**
3. **認証（Basic / JWT）にも対応可能**
4. **WebLogic API で `application/x-www-form-urlencoded` にも対応**

これで **TypeScript + jQuery で WebLogic の API にリクエストを送信** できるようになります！  
試してみて、もしエラーが出たら詳細を教えてください 😊🚀

**TypeScript + jQuery でクッキーから `sessionID` を取得し、API リクエストに追加する方法** を説明します。  
これで **既存の JavaScript の仕様を維持しつつ、TypeScript で API リクエストを行うことが可能** になります。 🚀

---

## **📌 1. クッキーから `sessionID` を取得する**
クッキーに保存された `sessionID` を取得するには、`document.cookie` をパースする関数を作成します。

### **✅ `getCookie()` 関数の実装**
```typescript
function getCookie(name: string): string | null {
  const match = document.cookie.match(new RegExp("(^| )" + name + "=([^;]+)"));
  return match ? match[2] : null;
}

// 例: クッキーから `sessionID` を取得
const sessionID = getCookie("sessionID");
console.log("Session ID:", sessionID);
```

✅ **`getCookie("sessionID")` を呼び出せば、クッキーに保存された `sessionID` を取得できる！**

---

## **📌 2. 取得した `sessionID` を API リクエストに追加**
取得した `sessionID` を API リクエストの `headers` に `Authorization` または `Cookie` として追加できます。

### **✅ `sessionID` を `Authorization` ヘッダーに追加**
```typescript
async function fetchWithSessionID() {
  const sessionID = getCookie("sessionID");
  if (!sessionID) {
    console.error("Session ID not found in cookies");
    return;
  }

  try {
    const response = await fetchApi({
      method: "GET",
      url: "http://localhost:7001/api/secure-data",
      headers: { Authorization: `Bearer ${sessionID}` }, // セッションIDをヘッダーに追加
    });

    console.log("Secure Data:", response);
  } catch (error) {
    console.error(error);
  }
}

fetchWithSessionID();
```

---

## **📌 3. `sessionID` を `Cookie` ヘッダーで送信**
もし WebLogic の API が `Cookie` ヘッダー経由で `sessionID` を受け取る場合、以下のように `headers` に追加します。

```typescript
async function fetchWithSessionInCookie() {
  const sessionID = getCookie("sessionID");
  if (!sessionID) {
    console.error("Session ID not found in cookies");
    return;
  }

  try {
    const response = await fetchApi({
      method: "GET",
      url: "http://localhost:7001/api/secure-data",
      headers: { Cookie: `sessionID=${sessionID}` }, // クッキーとして送信
    });

    console.log("Secure Data:", response);
  } catch (error) {
    console.error(error);
  }
}

fetchWithSessionInCookie();
```

---

## **📌 4. `fetchApi` に `sessionID` を自動で追加**
毎回 `sessionID` を取得するのが面倒な場合、`fetchApi` の `headers` に自動的に `sessionID` を追加できるようにします。

### **✅ `sessionID` を自動で追加する `fetchApi`**
```typescript
import * as $ from "jquery";

type HttpMethod = "GET" | "POST" | "PUT" | "DELETE";

interface ApiRequestOptions {
  method: HttpMethod;
  url: string;
  data?: any;
  headers?: Record<string, string>;
}

// クッキーから `sessionID` を取得
function getCookie(name: string): string | null {
  const match = document.cookie.match(new RegExp("(^| )" + name + "=([^;]+)"));
  return match ? match[2] : null;
}

// API リクエスト用の関数
async function fetchApi<T>({ method, url, data, headers = {} }: ApiRequestOptions): Promise<T> {
  const sessionID = getCookie("sessionID");

  return new Promise((resolve, reject) => {
    $.ajax({
      url,
      type: method,
      data: method === "GET" ? data : JSON.stringify(data),
      contentType: "application/json",
      headers: {
        ...headers,
        ...(sessionID ? { Authorization: `Bearer ${sessionID}` } : {}), // 自動的に sessionID を追加
      },
      success: (response) => resolve(response),
      error: (xhr, status, error) => reject(`Error: ${status}, ${error}`),
    });
  });
}
```

✅ **これで、毎回 `sessionID` を取得しなくても `fetchApi` を使うだけで `sessionID` をヘッダーに追加可能！**

---

## **📌 5. `sessionID` を WebLogic に送る方法の違い**
| 送信方法 | 設定するヘッダー | 使用例 |
|----------|---------------|-------|
| **`Authorization` ヘッダー** | `Authorization: Bearer {sessionID}` | `fetchApi({ method: "GET", url, headers: { Authorization: "Bearer ..." } })` |
| **`Cookie` ヘッダー** | `Cookie: sessionID={sessionID}` | `fetchApi({ method: "GET", url, headers: { Cookie: "sessionID=..." } })` |
| **ブラウザに Cookie を自動送信させる** | `credentials: "include"` を設定 | `fetch(url, { credentials: "include" })` |

---

## **🎯 まとめ**
1. **クッキーから `sessionID` を取得する**
   ```typescript
   function getCookie(name: string): string | null
   ```
2. **`sessionID` を `Authorization` ヘッダーに追加**
   ```typescript
   headers: { Authorization: `Bearer ${sessionID}` }
   ```
3. **`sessionID` を `Cookie` ヘッダーに追加**
   ```typescript
   headers: { Cookie: `sessionID=${sessionID}` }
   ```
4. **`fetchApi` で `sessionID` を自動追加**
   - `fetchApi` を使うだけで `sessionID` を毎回手動で設定しなくて済む 🎯

✅ **これで、TypeScript + jQuery の環境でクッキーに保存された `sessionID` を使ったリクエストが可能に！** 🚀  
試してみて、もし動作しない場合は詳細を教えてください！ 😊

### **✅ 結論: 既存のシステムを実行したまま、VSCode の開発環境 (TypeScript) からその `sessionID` を取得し、認証情報を横取りしてリクエストを作成できる！** 🎯

---

## **📌 1. どうして可能なのか？**
✔ **既存のシステム**（ブラウザで実行中の Web アプリ）が `sessionID` を **ブラウザのクッキーに保存** している。  
✔ **VSCode の TypeScript 環境（開発環境）** は、**同じブラウザ環境内で動く JavaScript / TypeScript のコードを実行可能**。  
✔ **開発中の TypeScript コード** も `document.cookie` を使ってクッキーを読み取ることが可能。  
✔ **取得した `sessionID` を API リクエストの `Authorization` ヘッダーに追加すれば、認証が通る**！ 🎯

---

## **📌 2. 具体的な手順**
### **✅ 1️⃣ 既存のシステムで `sessionID` を確認**
まず、ブラウザの開発ツール（DevTools）を開き、`sessionID` がクッキーに保存されているか確認。

1. **Google Chrome の DevTools を開く**（`F12` または `Ctrl + Shift + I`）
2. **[Application] タブを開く**
3. 左メニューの **[Storage] → [Cookies]** から **既存システムのドメインを選択**
4. **`sessionID` という名前のクッキーがあるか確認**
5. **値をコピーする**

> もし `sessionID` のクッキーが **`HttpOnly` なら、JavaScript から直接取得できない** ので、サーバーの `Set-Cookie` 設定を確認する必要あり。

---

### **✅ 2️⃣ `sessionID` を取得して TypeScript から API リクエスト**
```typescript
function getCookie(name: string): string | null {
  const match = document.cookie.match(new RegExp("(^| )" + name + "=([^;]+)"));
  return match ? match[2] : null;
}

async function fetchWithSession() {
  const sessionID = getCookie("sessionID"); // 既存のセッション情報を取得
  if (!sessionID) {
    console.error("Session ID not found in cookies");
    return;
  }

  try {
    const response = await fetch("http://localhost:7001/api/secure-data", {
      method: "GET",
      headers: { Authorization: `Bearer ${sessionID}` }, // 認証情報を追加
    });

    const data = await response.json();
    console.log("Secure Data:", data);
  } catch (error) {
    console.error("Error fetching data:", error);
  }
}

fetchWithSession();
```
✅ **TypeScript の開発環境（VSCode など）から `sessionID` を横取りして API リクエスト可能！**

---

### **✅ 3️⃣ 既存のクッキーを自動送信する（`credentials: "include"`）**
もし API が **クッキーを認証に使用** している場合、以下のように `credentials: "include"` を追加するだけで、開発環境からもセッションを利用できます。

```typescript
async function fetchWithCookies() {
  try {
    const response = await fetch("http://localhost:7001/api/secure-data", {
      method: "GET",
      credentials: "include", // 既存のセッション情報を自動送信
    });

    const data = await response.json();
    console.log("Secure Data:", data);
  } catch (error) {
    console.error("Error fetching data:", error);
  }
}

fetchWithCookies();
```

✅ **開発環境の TypeScript から、既存のブラウザセッションをそのまま使ってリクエスト可能！**

---

## **📌 3. もし `document.cookie` で `sessionID` を取得できない場合**
1. **`sessionID` が `HttpOnly` に設定されている**  
   - JavaScript では取得できないため、`credentials: "include"` を使うべき。
   - または、開発環境用の **認証 API** を作成して `sessionID` を取得する必要あり。

2. **API が CORS をブロックしている**  
   - **開発環境と本番環境のドメインが異なる場合、CORS の問題が発生する可能性がある。**
   - サーバー側の `Access-Control-Allow-Origin` に **開発環境のドメインを追加する** 必要がある。

3. **セッションが `SameSite=Strict` に設定されている**  
   - `SameSite=Strict` の場合、異なるオリジンからのリクエストではクッキーが送信されない。
   - `SameSite=None; Secure` に変更すれば、開発環境からのアクセスも可能。

---

## **📌 4. まとめ**
| 方法 | 説明 |
|------|------|
| **`document.cookie` で `sessionID` を取得** | 取得した `sessionID` を `Authorization` ヘッダーに追加し、API リクエストを送信 |
| **`credentials: "include"` を使う** | 既存のシステムのセッションをそのまま使ってリクエスト |
| **CORS / `SameSite` の問題を確認** | API サーバーが開発環境からのリクエストを許可しているか確認 |

✅ **結論:** 既存のシステムをそのまま動かしながら、VSCode の TypeScript 環境で `sessionID` を取得し、開発中のコードで認証情報を利用することは可能！ 🚀

**試してみて、もしエラーが出たら詳細を教えてください！** 😊