### **✅ HTTP は毎回セッションを作成しなおしているのか？**
**結論：** はい、**HTTP は基本的に「ステートレス（stateless）」なプロトコルなので、毎回新しい接続を作成しなおす** 仕組みになっています。  

ただし、**「セッション維持」や「持続的な接続」を実現する方法** もあります。  

---

## **🔹 1. HTTP の基本的な仕組み**
### **🔸 通常の HTTP の動作**
1. **クライアント（ブラウザやアプリ）が HTTP リクエストを送る**
2. **サーバーがリクエストを受け取り、レスポンスを返す**
3. **通信が終了し、接続が切れる（TCPコネクションが閉じられる）**

📌 **ポイント：**
- **HTTP は「ステートレス」なので、リクエストごとに新しい TCP 接続を作成する。**
- **リクエストが終わると、接続が切れる。（毎回セッションが作り直される）**

---

## **🔹 2. 例：HTTP 1.1 の場合**
### **(1) HTTP 1.0（持続的な接続なし）**
```http
GET /index.html HTTP/1.0
Host: example.com
```
- **リクエストごとに TCP 接続を開く → レスポンスを受け取ったら切断する。**
- 画像やスクリプトを読み込むたびに、毎回新しい TCP 接続が必要。

---

### **(2) HTTP 1.1（Keep-Alive あり）**
```http
GET /index.html HTTP/1.1
Host: example.com
Connection: keep-alive
```
- **`Connection: keep-alive` を指定すると、TCP 接続を維持できる。**
- **複数のリクエストを同じ接続で送るので、速度が向上する。**
- ただし、一定時間後に接続は切れる（永遠には続かない）。

---

### **(3) HTTP/2（多重化）**
- **1つの TCP 接続内で複数のリクエストを同時に処理できる。**
- **「ストリーム」と呼ばれる仕組みで、並列にリクエストを送れる。**
- **画像やCSS、JSなどを一気に送信可能なので、速度が向上。**

---

### **(4) HTTP/3（QUIC を使用）**
- **TCP ではなく UDP を使うことで、接続の確立時間を短縮。**
- **モバイル環境などで、途中で IP アドレスが変わっても接続が維持される。**
- **Google や YouTube などで使われている。**

---

## **🔹 3. 「セッション」を維持する仕組み**
### **🔸 セッションを維持する方法**
1. **Cookie（セッションIDを保存）**
   - サーバー側で「セッション ID」を発行し、Cookie に保存。
   - クライアントは次回のリクエスト時に Cookie を送る。
   - **セッションの情報はサーバー側で管理される。（状態を持つ）**

2. **JWT（JSON Web Token）**
   - クライアント側で認証トークンを保持し、リクエストごとに送信。
   - サーバー側で認証し、ユーザーを識別。
   - **セッションをサーバーに保存しなくても、ユーザーを識別できる。（スケールしやすい）**

3. **WebSocket（双方向通信）**
   - HTTP はステートレスだが、WebSocket は **「1回の接続を維持し続ける」** ことができる。
   - **リアルタイム通信（チャット、ゲーム、ストリーミングなど）に向いている。**

---

## **🔹 4. まとめ**
| **プロトコル** | **セッションの状態** | **接続の特徴** |
|--------------|-----------------|----------------|
| **HTTP 1.0** | 毎回切れる | 毎回新しい TCP 接続 |
| **HTTP 1.1** | `keep-alive` で一時的に維持 | しばらく再利用可能 |
| **HTTP/2** | 1つの接続を維持 | 多重化（並列リクエスト） |
| **HTTP/3** | UDP を使用 | 高速＆安定した接続 |
| **WebSocket** | 永続的な接続 | 双方向通信 |

**✅ HTTP は「基本的に毎回セッションを作り直す」が、HTTP/1.1 の `keep-alive` や HTTP/2, WebSocket などを使うことで接続を維持できる。**

# **✅ Cookie と Session の違い & API 通信の仕組み**
## **🔹 1. Cookie と Session の違い**
| **項目** | **Cookie** | **Session** |
|---------|----------|----------|
| **保存場所** | クライアント（ブラウザなど） | サーバー側 |
| **データの管理** | クライアント側で保存・管理 | サーバーがセッションIDを管理 |
| **サイズ制限** | **4KB** まで | **サーバー側の制限に依存** |
| **セキュリティ** | クライアントで保持するため **改ざんリスクがある** | セッションIDのみクライアントに渡すため **比較的安全** |
| **データの有効期限** | **ブラウザを閉じても保持できる（Expires, Max-Age指定可）** | **ブラウザを閉じると基本的に無効になる** |
| **用途** | ユーザー情報、設定の保存 | 認証情報、ログイン状態の維持 |

---

## **🔹 2. Cookie の仕組み**
### **📌 Cookie を使った認証フロー**
1. **ユーザーがログインリクエストを送信**
2. **サーバーが認証情報を確認し、Cookie を発行**
3. **クライアント（ブラウザ）は Cookie を保存**
4. **次回以降のリクエストに Cookie を自動送信**
5. **サーバーは Cookie の情報を見てユーザーを認証する**

### **🔸 Cookie の例（HTTP ヘッダー）**
**📍 サーバーから Cookie をセット**
```http
Set-Cookie: session_id=abc123; Path=/; HttpOnly; Secure; SameSite=Strict
```
**📍 クライアントが Cookie を送信**
```http
Cookie: session_id=abc123
```
📌 **ポイント**
- `HttpOnly` → JavaScript からアクセス不可（XSS 対策）
- `Secure` → HTTPS の場合のみ送信
- `SameSite=Strict` → 他のサイトからのリクエストでは送信されない（CSRF 対策）

---

## **🔹 3. セッション（Session）の仕組み**
### **📌 セッションを使った認証フロー**
1. **ユーザーがログインリクエストを送信**
2. **サーバーが認証情報を確認し、セッション ID を発行**
3. **セッション ID をサーバー側のデータベースやメモリに保存**
4. **セッション ID を Cookie にセットしてクライアントへ送信**
5. **クライアントは Cookie に保存されたセッション ID をリクエストごとに送信**
6. **サーバーはセッション ID を照合し、認証する**

### **🔸 セッションの例**
**📍 サーバー側（Node.js + Express）**
```javascript
const session = require('express-session');

app.use(session({
  secret: 'mysecretkey',
  resave: false,
  saveUninitialized: true,
  cookie: { secure: true }  // HTTPSのみ
}));

app.post('/login', (req, res) => {
  req.session.userId = "user123";
  res.send("Logged in");
});

app.get('/profile', (req, res) => {
  if (req.session.userId) {
    res.send(`Hello, ${req.session.userId}`);
  } else {
    res.status(401).send("Unauthorized");
  }
});
```
📌 **ポイント**
- **セッション ID をサーバー側で管理するため、安全性が高い**
- **セッション情報はメモリ or DB に保存可能**
- **クライアント側にはセッション ID しか渡さない**

---

## **🔹 4. API 通信の仕組み**
API（Application Programming Interface）は、クライアント（例：React, iOS, Android）とサーバー間のデータ通信を可能にする仕組み。

---

### **📌 API 通信の基本フロー**
1. **クライアントが HTTP リクエストを送信**
2. **サーバーがリクエストを受け取る**
3. **必要なデータを処理し、レスポンスを返す**
4. **クライアントがレスポンスを受け取る**
5. **クライアント側でデータを表示する**

---

### **📌 代表的な API 通信方式**
| **通信方式** | **特徴** | **用途** |
|------------|--------|------|
| **REST API** | HTTP を利用（GET, POST など） | Web サービス全般 |
| **GraphQL** | 必要なデータのみ取得 | SPA, ダッシュボード |
| **gRPC** | バイナリ通信で高速 | マイクロサービス |
| **WebSocket** | 双方向通信 | チャット、ゲーム |

---

### **🔹 REST API の例（JSONベース）**
**📍 クライアント（axios を使用）**
```javascript
axios.get("https://api.example.com/user/123")
  .then(response => console.log(response.data))
  .catch(error => console.error(error));
```
**📍 サーバー（Node.js + Express）**
```javascript
app.get('/user/:id', (req, res) => {
  res.json({ id: req.params.id, name: "John Doe" });
});
```
📌 **ポイント**
- クライアントが `GET /user/123` を送る
- サーバーが JSON `{ "id": "123", "name": "John Doe" }` を返す

---

### **🔹 認証付き API の例**
認証付き API では、**トークンを利用することが多い**。

#### **📍 JWT（JSON Web Token）を使った認証**
1. **ユーザーがログインし、サーバーが JWT を発行**
2. **クライアントは JWT を保存し、リクエストごとに送信**
3. **サーバーは JWT を検証し、認証を行う**

**📍 クライアント（React）**
```javascript
const token = "your-jwt-token";
axios.get("https://api.example.com/profile", {
  headers: { Authorization: `Bearer ${token}` }
});
```
**📍 サーバー（Node.js + Express + JWT）**
```javascript
const jwt = require('jsonwebtoken');

app.get('/profile', (req, res) => {
  const token = req.headers.authorization?.split(" ")[1];
  if (!token) return res.status(401).send("Unauthorized");

  jwt.verify(token, "secretkey", (err, user) => {
    if (err) return res.status(403).send("Forbidden");
    res.json({ id: user.id, name: "John Doe" });
  });
});
```
📌 **ポイント**
- **JWT を使うと、サーバー側にセッションを保存しなくても認証ができる**
- **ステートレスなので、スケールしやすい**

---

## **🔹 5. まとめ**
| **項目** | **Cookie** | **Session** |
|--------|---------|---------|
| **データの保存場所** | クライアント | サーバー |
| **セキュリティ** | クライアントに依存（改ざんリスクあり） | サーバー管理（比較的安全） |
| **使用例** | ユーザー設定、トラッキング | ログイン認証 |

| **API 通信方式** | **特徴** |
|---------------|--------|
| **REST API** | 一般的な HTTP API（JSON 形式） |
| **GraphQL** | 必要なデータのみ取得（柔軟なクエリ） |
| **WebSocket** | リアルタイム通信 |
| **JWT 認証** | トークンを使ったステートレス認証 |

API を使う場合、認証には **セッション（Session）や JWT を使うことが多い**。  
🚀 **「どの方式が適切か？」は、セキュリティや用途に応じて選ぶのがポイント！**