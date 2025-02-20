## **🔍 `localStorage` / `sessionStorage` と `cookie` の違い**
JavaScript では、**ブラウザにデータを保存する方法** として **`localStorage` / `sessionStorage` / `cookie`** の 3 つがあります。  
それぞれ **用途・保存期間・サイズ・セキュリティ** が異なります。

---

## **🟢 1. `localStorage` / `sessionStorage` / `cookie` の比較表**

| 項目 | `localStorage` | `sessionStorage` | `cookie` |
|------|--------------|----------------|---------|
| **データの保存期間** | **無期限**（手動で削除しない限り残る） | **セッション終了まで**（タブを閉じると消える） | **有効期限を指定可能**（デフォルトはセッション単位） |
| **保存容量** | 約 5MB | 約 5MB | **4KB** まで |
| **送信のタイミング** | **クライアントサイドのみ**（サーバーには送信されない） | **クライアントサイドのみ** | **サーバーへ自動送信**（リクエスト時に送信される） |
| **アクセス可能範囲** | **同じオリジン（ドメイン+プロトコル+ポート）のページ間で共有** | **タブごとに分離** | **すべてのリクエストで送信**（ドメイン全体で共有可能） |
| **セキュリティ** | **JavaScript でアクセス可能**（`httpOnly` なし） | **JavaScript でアクセス可能** | **`httpOnly` を指定すれば JavaScript からアクセス不可** |
| **用途** | **永続的なデータ保存（例: ユーザー設定）** | **一時的なデータ保存（例: 入力フォームの内容保持）** | **セッション管理（例: ログイン情報）** |

---

## **🟢 2. `localStorage` の特徴**
- **手動で削除しない限りデータが残る（永続的）**
- **JavaScript でのみアクセス可能（サーバーには送信されない）**
- **保存容量が大きい（約 5MB）**

✅ **保存・取得・削除の例**
```js
// データの保存
localStorage.setItem("username", "太郎");

// データの取得
console.log(localStorage.getItem("username")); // "太郎"

// データの削除
localStorage.removeItem("username");

// 全データ削除
localStorage.clear();
```

✅ **用途**
- ユーザーの **設定情報** や **テーマの選択** を保存する
- **カート情報** などをブラウザに保存する

---

## **🟢 3. `sessionStorage` の特徴**
- **タブ（またはウィンドウ）を閉じるとデータが消える**
- **`localStorage` と同様に JavaScript でのみアクセス可能**
- **保存容量が大きい（約 5MB）**
- **他のタブとは共有されない**

✅ **保存・取得の例**
```js
sessionStorage.setItem("tempData", "一時データ");
console.log(sessionStorage.getItem("tempData")); // "一時データ"

// タブを閉じると `sessionStorage` のデータは消える
```

✅ **用途**
- フォーム入力内容の **一時保存**
- ページのリロード後も **タブが閉じるまではデータを保持**

---

## **🟢 4. `cookie` の特徴**
- **サーバーへ自動送信される**
- **有効期限（`expires` や `max-age`）を指定可能**
- **デフォルトでは JavaScript からアクセス可能（`httpOnly` を指定すれば不可）**
- **保存容量が少ない（4KB）**

✅ **Cookie のセット（JavaScript で操作）**
```js
document.cookie = "username=太郎; expires=Fri, 31 Dec 2025 23:59:59 GMT; path=/";
```
✅ **Cookie の取得**
```js
console.log(document.cookie); // "username=太郎"
```
✅ **Cookie の削除**
```js
document.cookie = "username=; expires=Thu, 01 Jan 1970 00:00:00 GMT; path=/";
```

✅ **用途**
- **ログイン情報の保存**
- **トラッキング情報の管理（セッション ID など）**
- **サーバーとのデータ共有**

---

## **🟢 5. `localStorage` / `sessionStorage` / `cookie` の使い分け**
| **用途** | **おすすめの保存方法** |
|---------|--------------------|
| **ユーザー設定（テーマ、言語）** | `localStorage`（長期間保存） |
| **一時的なデータ（入力フォームの保存）** | `sessionStorage`（タブを閉じたら消える） |
| **ログイン情報の管理** | `cookie`（`httpOnly` を設定しセキュアに） |
| **API トークンの保存** | **`localStorage` は非推奨⚠（XSS の危険あり）→ `cookie` + `httpOnly`** |

---

## **🟢 6. `localStorage` と `cookie` のセキュリティ**
**✅ `localStorage` のリスク**
- `localStorage` は **`JavaScript` から直接アクセスできる** → **XSS（クロスサイトスクリプティング）攻撃の対象** になる
- **API トークンを `localStorage` に保存すると、悪意のあるスクリプトに盗まれるリスクがある**
- **対策** → **`cookie`（`httpOnly` + `Secure`）を推奨**

**✅ `cookie` のリスク**
- **デフォルトではサーバーに自動送信される** ため、セッションハイジャックのリスクがある
- **対策** → `Secure`（HTTPS のみ） & `HttpOnly`（JavaScript からアクセス不可） を設定

```js
Set-Cookie: sessionId=abc123; HttpOnly; Secure; SameSite=Strict
```

---

# **🎯 まとめ**
| **特徴** | **localStorage** | **sessionStorage** | **cookie** |
|---------|--------------|----------------|---------|
| **データの保存期間** | 永続（削除しない限り残る） | タブを閉じると消える | 有効期限を指定可能 |
| **保存容量** | 約 5MB | 約 5MB | **最大 4KB** |
| **サーバーとの通信** | **なし**（クライアントのみ） | **なし**（クライアントのみ） | **毎回サーバーに送信** |
| **アクセス範囲** | 同じオリジンのすべてのページ | 同じタブ内のみ | ドメイン全体で共有 |
| **セキュリティ** | XSS に弱い（JavaScript でアクセス可能） | XSS に弱い | `httpOnly` 設定で XSS 対策可能 |
| **主な用途** | **ユーザー設定、カート情報** | **フォーム入力の一時保存** | **セッション管理、認証情報** |

✅ **ブラウザにデータを保存する方法を適切に選択しよう！** 🚀