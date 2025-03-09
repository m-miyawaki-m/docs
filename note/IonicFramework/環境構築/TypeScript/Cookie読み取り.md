### **✅ 目標: JavaScript でクッキーを保存し、VSCode の TypeScript で読み取ってコンソールに出力する**
👉 **流れ**
1. **JavaScript (`setCookie.js`) でクッキーを保存**
2. **VSCode の TypeScript (`getCookie.ts`) でクッキーを読み取る**
3. **VSCode のターミナルで TypeScript を実行し、コンソールにクッキーの値を出力**

---

# **📌 1. クッキーを保存する JavaScript (`setCookie.js`)**
以下のコードを **ブラウザで実行してクッキーを保存** します。

### **✅ `setCookie.js`**
```javascript
function setCookie(name, value, days) {
    let expires = "";
    if (days) {
        const date = new Date();
        date.setTime(date.getTime() + days * 24 * 60 * 60 * 1000);
        expires = "; expires=" + date.toUTCString();
    }
    document.cookie = name + "=" + encodeURIComponent(JSON.stringify(value)) + "; path=/;" + expires;
    console.log("Cookie set:", document.cookie);
}

// `sessionID` を JSON 形式で保存
setCookie("sessionID", { id: "abcdef123456" }, 1);
```

✅ **ブラウザでこのスクリプトを実行すると、クッキーが保存される。**

---

# **📌 2. TypeScript でクッキーを取得 (`getCookie.ts`)**
VSCode で **TypeScript のコードを実行して、クッキーをコンソール出力** します。

### **✅ `getCookie.ts`**
```typescript
function getCookie(name) {
    console.log("All Cookies:", document.cookie); // クッキーを全表示

    var match = document.cookie.match(new RegExp("(^| )" + name + "=([^;]+)"));
    if (match) {
        try {
            // クッキーの値をデコードして JSON に変換
            return JSON.parse(decodeURIComponent(match[2]));
        } catch (e) {
            console.error("❌ JSON パースエラー:", e);
            return null;
        }
    }
    return null;
}

// `sessionID` の値を取得
var sessionData = getCookie("sessionID");

if (sessionData) {
    console.log("✅ Retrieved Session Data:", sessionData);
    console.log("🎯 Session ID:", sessionData.id);
} else {
    console.error("❌ Session ID not found!");
}

```

✅ **このコードを VSCode で実行すると、`sessionID` を取得してコンソールに表示！**

---

# **📌 3. 実行方法**
## **✅ 3-1. `setCookie.js` を実行（クッキーを保存）**
### **方法 1: ブラウザの開発者ツール（DevTools）で実行**
1. **ブラウザを開く（Google Chrome / Edge / Firefox など）**
2. **`F12` を押して開発者ツール（DevTools）を開く**
3. **[Console] タブを選択**
4. **`setCookie.js` のコードをコピーして貼り付け、Enter キーで実行**
5. **「Cookie set: sessionID=abcdef123456」が表示されれば成功！**

### **方法 2: `index.html` を作成して実行**
```html
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>Set Cookie</title>
    <script src="setCookie.js"></script>
</head>
<body>
    <h1>Session ID has been set!</h1>
</body>
</html>
```
1. **`index.html` をブラウザで開く**
2. **開発者ツール (`F12`) の [Application] → [Storage] → [Cookies] で `sessionID` が保存されたことを確認**

---

## **✅ 3-2. TypeScript (`getCookie.ts`) を実行（クッキーを取得）**
### **方法 1: `npx ts-node` で TypeScript を直接実行**
```sh
npx ts-node getCookie.ts
```
**エラー:**  
💥 `document.cookie` は **Node.js では動作しない** ため、 **この方法では取得できない！**

---

### **方法 2: `index.html` で `getCookie.ts` を JavaScript にコンパイルして実行**
1. **TypeScript を JavaScript にコンパイル**
```sh
npx tsc getCookie.ts
```
➡ `getCookie.js` が生成される。

2. **`index.html` にスクリプトを追加**
```html
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <title>Get Cookie</title>
    <script src="getCookie.js"></script>
</head>
<body>
    <h1>Check Console for Session ID</h1>
</body>
</html>
```

3. **ブラウザで `index.html` を開く**
4. **`F12` を押してコンソールに `Retrieved Session ID: abcdef123456` が表示される**

✅ **ブラウザで動かすなら、TypeScript を JavaScript に変換（`tsc`）して、HTML で読み込めば動作する！**

---

# **📌 4. Node.js でクッキーを取得する場合（オプション）**
👉 **Node.js では `document.cookie` は使えないため、`cookie` ライブラリを使う必要がある！**

### **✅ `cookie` ライブラリをインストール**
```sh
npm install cookie
```

### **✅ Node.js でクッキーを取得する `getCookieNode.ts`**
```typescript
import * as cookie from "cookie";

// 仮のクッキーデータ
const cookieHeader = "sessionID=abcdef123456";

// クッキーを解析
const parsedCookies = cookie.parse(cookieHeader);
console.log("Retrieved Session ID:", parsedCookies["sessionID"]);
```

### **✅ 実行方法**
```sh
npx ts-node getCookieNode.ts
```
✅ **Node.js 環境では `cookie` ライブラリを使えばクッキーを解析できる！**

---

# **🎯 まとめ**
| 環境 | クッキーの取得方法 | 実行方法 |
|------|----------------|---------------------|
| **ブラウザ (React / HTML)** | `document.cookie` | **`tsc` でコンパイル → `index.html` で実行** |
| **VSCode / Node.js** | `cookie.parse()` | **`npx ts-node` で実行** |

✅ **ブラウザで動かすなら `document.cookie` を使い、Node.js なら `cookie` ライブラリが必要！** 🚀

試してみて、もし動作しない場合はエラーメッセージを教えてください！ 😊