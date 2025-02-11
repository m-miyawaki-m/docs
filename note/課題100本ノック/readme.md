ファイル名に日時を含めるように修正する場合、例えば `YYYY-MM-DD_HHMM` 形式を用いることで、日付と時刻ごとに保存されるようになります。  
以下のように `new Date().toISOString()` を活用して `YYYY-MM-DD_HHMM` 形式のファイル名を作成し、コードを修正できます。

### **修正後のスクリプト**
```javascript
// ==UserScript==
// @name         ChatGPT Markdown Saver (Thread Name + DateTime)
// @namespace    http://tampermonkey.net/
// @version      2.0
// @description  ChatGPT の最新 1 件の会話を Markdown に保存（スレッド名 + 日時付き）
// @match        https://chat.openai.com/*
// @match        https://chatgpt.com/*
// @grant        none
// ==/UserScript==

(function() {
    'use strict';

    let btn = document.createElement("button");
    btn.innerText = "💾 Copy & Save Latest Markdown";
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

    btn.addEventListener("click", async function() {
        let copyButtons = document.querySelectorAll('button[aria-label="コピーする"]');

        if (copyButtons.length === 0) {
            alert("❌ ChatGPT のコピーボタンが見つかりません！");
            return;
        }

        let latestButton = copyButtons[copyButtons.length - 1]; // 最新の1件を取得
        latestButton.click(); // コピーボタンを押す

        await new Promise(resolve => setTimeout(resolve, 500)); // クリップボード処理待機

        let clipboardText = await navigator.clipboard.readText(); // クリップボードから取得

        // 🔹 スレッド名を取得（document.title から生成）
        let threadName = document.title.replace(/ - ChatGPT$/, "").trim();
        threadName = threadName.replace(/[<>:"/\\|?*]+/g, "_"); // ファイル名に使えない文字を `_` に置換
        if (threadName === "") {
            threadName = "chatgpt"; // スレッド名が取得できない場合のフォールバック
        }

        // 🔹 現在の日時を取得（YYYY-MM-DD_HHMM 形式）
        let now = new Date();
        let formattedDate = now.toISOString().split('T')[0]; // YYYY-MM-DD
        let formattedTime = now.toTimeString().split(' ')[0].replace(/:/g, ""); // HHMMSS
        let timestamp = `${formattedDate}_${formattedTime.substring(0,4)}`; // YYYY-MM-DD_HHMM

        // 🔹 ファイル名を作成（スレッド名 + 日時）
        let filename = `${threadName}_${timestamp}.md`;

        let content = `# ${threadName} の最新の会話 (${timestamp})\n\n${clipboardText}\n`;
        let blob = new Blob([content], { type: "text/markdown" });
        let a = document.createElement("a");
        a.href = URL.createObjectURL(blob);
        a.download = filename;
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);

        alert(`✅ 最新の会話を ${filename} に保存しました！`);
    });
})();
```

### **修正ポイント**
1. **ファイル名に日付・時刻を追加**
   - `YYYY-MM-DD_HHMM` の形式で日時を取得してファイル名に追加。
   - `HHMMSS` のうち `HHMM` までを使用（例: `2025-02-09_1530.md`）。

2. **Markdown のファイル内容にも日時を追加**
   - `# スレッド名 の最新の会話 (YYYY-MM-DD_HHMM)` の形式で記録。

### **例**
このスクリプトを実行すると、例えば以下のようなファイル名で保存されます。
```
プロジェクト計画_2025-02-09_1530.md
```
ファイルの中身:
```
# プロジェクト計画 の最新の会話 (2025-02-09_1530)

ChatGPT との会話内容...
```

この修正により、会話が日時付きで保存され、後から整理しやすくなります！ 🚀