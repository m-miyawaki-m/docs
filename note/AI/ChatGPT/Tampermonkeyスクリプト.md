###

```
edge://extensions/
```
へアクセスして開発者モードを有効にしてください。




### **✅ ファイル名の連番 (`chatgpt_001.md`, `chatgpt_002.md` ...) のリセットタイミング**
現在のスクリプトでは、**ブラウザのローカルストレージ (`localStorage`) に保存** された `chatgpt_md_counter` を参照して連番を管理しています。

**つまり、次のようなタイミングでリセットされます。**

---

## **🔹 連番がリセットされる条件**
| **リセットのタイミング** | **説明** |
|------------------|-------------|
| **ブラウザのローカルストレージを削除したとき** | `localStorage.clear()` を実行 or ブラウザ設定でデータ削除 |
| **別のブラウザを使ったとき** | 例: Chrome → Edge に変更すると `localStorage` は別管理 |
| **シークレットモード（プライベートモード）で開いたとき** | `localStorage` が一時的になるため、タブを閉じるとリセット |
| **手動で `chatgpt_md_counter` をリセットしたとき** | `localStorage.setItem("chatgpt_md_counter", 1);` を実行 |
| **ブラウザのキャッシュを完全にクリアしたとき** | 「サイトデータを削除」すると `localStorage` も消える |

---

## **🔹 手動でリセットする方法**
**1️⃣ デベロッパーツールを開く (`F12` または `Ctrl + Shift + J`)**  
**2️⃣ 以下のコマンドを実行**
```javascript
localStorage.setItem("chatgpt_md_counter", 1);
```
**✅ これで次回の保存時に `chatgpt_001.md` から再スタート！**

---

## **🔹 自動でリセットする方法**
例えば、**毎日 or 毎回のセッション開始時に連番をリセット** したい場合、スクリプトを以下のように修正できます。

```javascript
// ==UserScript==
// @name         ChatGPT Markdown Saver (Auto Reset Counter)
// @namespace    http://tampermonkey.net/
// @version      1.3
// @description  ChatGPT の最新 N 件の会話を Markdown に保存（毎日リセット）
// @match        https://chat.openai.com/*
// @grant        none
// ==/UserScript==

(function() {
    'use strict';

    // 🔹 本日の日付を取得
    let today = new Date().toISOString().split('T')[0];

    // 🔹 最後に保存した日付を取得
    let lastSavedDate = localStorage.getItem("chatgpt_md_last_date");

    // 🔹 日付が変わったらカウンターをリセット
    if (lastSavedDate !== today) {
        localStorage.setItem("chatgpt_md_counter", 1);
        localStorage.setItem("chatgpt_md_last_date", today);
    }

    let counter = localStorage.getItem("chatgpt_md_counter") || 1;
    const SAVE_COUNT = 3; // 🔹 最新のN件を保存

    let btn = document.createElement("button");
    btn.innerText = "💾 Save Last N Responses";
    btn.style.position = "fixed";
    btn.style.top = "10px";
    btn.style.right = "10px";
    btn.style.zIndex = "9999";
    btn.style.padding = "10px";
    btn.style.background = "#4CAF50";
    btn.style.color = "white";
    btn.style.border = "none";
    btn.style.cursor = "pointer";
    document.body.appendChild(btn);

    btn.addEventListener("click", function() {
        let conversationElements = document.querySelectorAll('.markdown');
        if (conversationElements.length === 0) {
            alert("❌ ChatGPT の会話が見つかりません！");
            return;
        }

        let startIndex = Math.max(0, conversationElements.length - SAVE_COUNT);
        let selectedConversations = Array.from(conversationElements).slice(startIndex);
        let conversationText = selectedConversations.map(el => el.innerText).join("\n\n");

        let filename = `chatgpt_${String(counter).padStart(3, '0')}.md`;
        counter++;
        localStorage.setItem("chatgpt_md_counter", counter);

        let content = `# ChatGPT の最近の ${SAVE_COUNT} 件の会話\n\n${conversationText}\n`;
        let blob = new Blob([content], { type: "text/markdown" });
        let a = document.createElement("a");
        a.href = URL.createObjectURL(blob);
        a.download = filename;
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);

        alert(`✅ 最新 ${SAVE_COUNT} 件の会話を ${filename} に保存しました！`);
    });
})();
```

---

## **🔹 修正点**
✅ **日付 (`YYYY-MM-DD`) を記録し、日付が変わったら `chatgpt_001.md` からスタート！**  
✅ **「前回保存した日付」と「今日の日付」を比較 → 違っていたらカウンターをリセット！**  
✅ **ブラウザを開いて新しい日になったら自動リセットされる！**

---

## **📌 まとめ**
| **方法** | **リセットタイミング** |
|----------|----------------|
| **手動で `localStorage` をクリア** | デベロッパーツール (`F12`) → `localStorage.clear()` |
| **自動リセット (毎日リセット)** | `localStorage` に日付を保存し、日付が変わったらリセット |
| **ブラウザのキャッシュを削除** | Chrome / Edge の「サイトデータを削除」 |

🚀 **これで、ファイルの連番を「手動 or 自動」で管理できます！**  
**この動作で問題ないか試してみてください！** 🎉