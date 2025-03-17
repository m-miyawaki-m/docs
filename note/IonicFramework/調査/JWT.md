# **✅ JWT（JSON Web Token）とは？**
## **🔹 1. JWT の概要**
**JWT（JSON Web Token）** は、認証や情報の安全なやりとりを目的としたトークンベースの仕組みです。  
- **ステートレス認証が可能**（サーバー側でセッションを管理しない）
- **改ざん検知ができる**（署名付き）
- **コンパクト & 軽量**（URL や HTTP ヘッダーに埋め込める）

---

## **🔹 2. JWT の構造**
JWT は **3つの部分** で構成されています。

```
ヘッダー.ペイロード.署名
```

**📍 例（実際の JWT）**
```jwt
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIxMjMiLCJyb2xlIjoiYWRtaW4iLCJleHAiOjE3MTM1NTg0MDB9.fMEc6C-YVR3VGrCfhGQhzk30pa7R_E3w0eSnJklsh5Y
```

**📌 各部分の詳細**
| **部分** | **内容** | **説明** |
|---------|--------|--------|
| **ヘッダー（Header）** | `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9` | 署名アルゴリズム（例：HS256） |
| **ペイロード（Payload）** | `eyJ1c2VySWQiOiIxMjMiLCJyb2xlIjoiYWRtaW4iLCJleHAiOjE3MTM1NTg0MDB9` | ユーザー情報・有効期限 |
| **署名（Signature）** | `fMEc6C-YVR3VGrCfhGQhzk30pa7R_E3w0eSnJklsh5Y` | トークンの改ざん防止 |

---

## **🔹 3. JWT の認証フロー**
JWT は **一度発行すると、リクエストごとにサーバーで状態を保持しなくても認証可能** です。

### **📌 フロー**
1️⃣ **ユーザーがログイン**
   - `POST /login` に **ユーザー名・パスワード** を送信  
   - サーバーが認証し、JWT を発行

2️⃣ **クライアントが JWT を保存**
   - ローカルストレージ or Cookie に保存
   - **次回以降のリクエストに JWT を添付**

3️⃣ **サーバーが JWT を検証**
   - **署名を検証** → **改ざんされていないかチェック**
   - 有効期限などをチェックし、認証成功なら API レスポンスを返す

---

## **🔹 4. JWT の実装**
### **📍 サーバー側（Node.js + Express + jsonwebtoken）**
```javascript
const jwt = require('jsonwebtoken');
const express = require('express');
const app = express();
app.use(express.json());

const SECRET_KEY = "my_secret_key";  // 署名用の秘密鍵

// ✅ ユーザーがログインしたときに JWT を発行
app.post('/login', (req, res) => {
  const { username, password } = req.body;

  // 仮のユーザー認証（本来はDB確認）
  if (username === 'admin' && password === 'pass123') {
    const token = jwt.sign({ username, role: 'admin' }, SECRET_KEY, { expiresIn: '1h' });
    res.json({ token });
  } else {
    res.status(401).send('Invalid credentials');
  }
});

// ✅ JWT を検証するミドルウェア
const verifyToken = (req, res, next) => {
  const token = req.headers.authorization?.split(' ')[1];
  if (!token) return res.status(403).send('Token required');

  jwt.verify(token, SECRET_KEY, (err, decoded) => {
    if (err) return res.status(401).send('Invalid token');
    req.user = decoded;
    next();
  });
};

// ✅ 認証が必要な API
app.get('/profile', verifyToken, (req, res) => {
  res.json({ message: `Hello, ${req.user.username}`, role: req.user.role });
});

app.listen(3000, () => console.log("Server running on port 3000"));
```

---

## **🔹 5. JWT の利点と欠点**
### **✅ メリット**
1. **ステートレス（サーバー側にセッションを保存しない）**
   - スケールしやすい（負荷分散に適している）
2. **改ざん検知が可能**
   - 署名付きなので **改ざんされていないか** チェックできる
3. **汎用性が高い**
   - **モバイルアプリ、SPA（React, Vue）などでよく使われる**
   - REST API / GraphQL API / gRPC でも利用可能

### **❌ デメリット**
1. **トークンの無効化が難しい**
   - 一度発行すると、**途中で無効化できない**（セッションとは違う）
   - **対策：有効期限を短くする & リフレッシュトークンを活用**
2. **サイズが大きくなる**
   - Cookie やローカルストレージに保存すると **ストレージ圧迫**
3. **漏洩すると危険**
   - 署名の検証はできるが、**秘密鍵が漏れると偽のトークンを作られるリスク**
   - **対策：HTTPSを必ず使用、Secure & HttpOnlyなCookieに保存**

---

## **🔹 6. JWT の発展**
### **🔸 リフレッシュトークン**
- アクセストークン（短期間有効） + リフレッシュトークン（長期間有効）
- **アクセス期限が切れたら、リフレッシュトークンで新しいJWTを取得**
- **漏洩リスクを減らせる**

### **🔸 JWE（JSON Web Encryption）**
- **JWT はデフォルトで「署名」だけだが、暗号化（JWE）も可能**
- **ペイロードを暗号化し、よりセキュアなデータ送信**

---

## **🔹 7. まとめ**
### **📌 JWT の特徴**
✅ ステートレス → **サーバー側でセッションを持たない**  
✅ 署名付き → **改ざんを検知できる**  
✅ REST API や SPA に最適（React, Vue, モバイルアプリ）  
✅ **短期間で有効なアクセストークン + 長期間有効なリフレッシュトークンを組み合わせると安全性UP**  

### **📌 いつ JWT を使うべきか？**
- **SPA（シングルページアプリケーション）**
- **モバイルアプリの API 認証**
- **マイクロサービス間の認証**
- **ステートレスなスケール可能なシステムが必要な場合**

💡 **ただし、ログアウトやトークン無効化が重要なら、セッションベース認証も検討するべき！** 🚀


クッキーに `sessionID` を保存する方法と、APIリクエストのヘッダーに `role` や `所属`（例えば `department`）を追加する方法は、**JWT とは異なる認証管理の手法** です。  

---

## **🔹 1. クッキーに sessionID を保存する方式**
**🔍 これは「セッションベース認証（Session Authentication）」** と呼ばれる一般的な手法です。  

### **✅ 仕組み**
1️⃣ **ユーザーがログイン**  
   - `POST /login` で ユーザー名・パスワードを送信  
   - サーバーが認証し、**セッションIDを発行**
  
2️⃣ **セッションIDをクッキーに保存**
   - `Set-Cookie: sessionID=abcdef123456; HttpOnly; Secure`
   - **ブラウザは以降のリクエストに自動でクッキーを送信**
  
3️⃣ **サーバーがセッションを管理**
   - `sessionID` に紐づく**ユーザー情報をサーバーのデータベース or メモリ（Redisなど）で管理**
   - 各リクエストごとに `sessionID` をもとに認証・認可処理

**🛠 具体例（Express + express-session）**
```javascript
const express = require('express');
const session = require('express-session');

const app = express();
app.use(session({
  secret: 'my_secret_key',
  resave: false,
  saveUninitialized: true,
  cookie: { secure: true, httpOnly: true }
}));

app.post('/login', (req, res) => {
  req.session.user = { id: 123, role: 'admin', department: 'IT' };
  res.send('Logged in');
});

app.get('/profile', (req, res) => {
  if (!req.session.user) return res.status(401).send('Unauthorized');
  res.json(req.session.user);
});

app.listen(3000, () => console.log("Server running"));
```

**🔹 特徴**
- **サーバーがセッションを管理**（状態を持つ = **ステートフル**）
- **セッションIDをクッキーに保存**
- **ログアウト時にサーバー側のセッションを削除できる**

**🔹 デメリット**
- **スケールしにくい**（複数サーバー構成時、セッション共有が必要）
- **サーバー側の管理コストがかかる**

---

## **🔹 2. APIリクエストのヘッダーに role・所属を追加**
**🔍 これは JWT のように見えますが、JWT とは限りません。**  

### **✅ 可能な2つのパターン**
🔸 **(1) JWT を使って role・所属をヘッダーに含める**
```javascript
Authorization: Bearer eyJhbGciOiJIUzI1NiIs...
```
この場合、サーバーはリクエストの `Authorization` ヘッダーに含まれる JWT を検証し、デコードすることで **ユーザーの役割（role）や所属（department）を取得** します。

🔸 **(2) セッションベース認証でも、ヘッダーに role・所属を含める**
- **認証時に、サーバーが role・所属を追加**
- `X-User-Role: admin` や `X-User-Department: IT` のようなカスタムヘッダーを API レスポンスに追加

```http
GET /user/profile HTTP/1.1
Cookie: sessionID=abcdef123456

HTTP/1.1 200 OK
X-User-Role: admin
X-User-Department: IT
```

---

## **🔹 3. JWT と セッションの違い**
| **方式** | **セッションベース認証** | **JWT 認証** |
|----------|-----------------|------------|
| **クライアントの情報保存** | `sessionID` をクッキーに保存 | JWT をクッキー or ローカルストレージに保存 |
| **サーバーの管理** | サーバー側でセッションを管理 | **ステートレス**（サーバーで管理不要） |
| **スケール** | 複数サーバーでセッション共有が必要 | スケールしやすい（どのサーバーでも検証可能） |
| **ログアウト処理** | **セッションを削除** すれば即座に無効化 | **ログアウト後も有効期限が切れるまで使える** |
| **データ改ざん防止** | セッションIDを改ざんされる可能性あり | 署名付きなので改ざん検知が可能 |
| **適したシステム** | **従来のWebアプリ（サーバーレンダリング）** | **SPA, モバイルアプリ, マイクロサービス** |

---

## **🔹 4. まとめ**
✅ **「クッキーに sessionID を保存」** → **セッションベース認証（ステートフル）**  
✅ **「APIリクエストのヘッダーに role や 所属を追加」** → **JWT またはセッションでも可能**  
✅ **JWT はトークンベースの認証**（ステートレス）であり、セッションとは別の仕組み  

**結論：**
「JWT ではないが、API の設計次第で JWT のように見えることもある！」 🚀