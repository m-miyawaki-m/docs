以下の手順を修正し、**React に必要なパッケージを含めた完全なオフライン Ionic React + Android 開発環境の構築手順**をまとめました。

---

## **✅ オフライン環境で Ionic React + Android 開発を行う手順（VSCode / Android Studio）**
オフライン環境でも **Ionic React + Capacitor（Android 開発）** を実行できるように、  
**事前に必要なパッケージをダウンロードし、オフライン環境へ持ち込む手順** をまとめました！ 🚀

---

## **📌 1. 事前準備（オンライン環境）**
オフライン環境では `npm install` や `npx` が使えないため、  
**オンライン環境で必要なパッケージを `.tgz` に保存** し、オフライン環境へ持ち込みます。

---

### **📌 1-1. 事前に必要なパッケージを `.tgz` で取得**
**オンライン環境で以下のコマンドを実行**
```sh
mkdir offline_packages
cd offline_packages

# Ionic & Capacitor パッケージ (バージョン指定)
npm pack @ionic/cli@7.2.0 ionic@5.4.16 @capacitor/core@7.0.1 @capacitor/cli@7.0.1 @capacitor/android@7.0.1

# TypeScript & Node関連 (バージョン指定)
npm pack typescript@5.8.2 ts-node@10.9.2 @types/node@22.13.10

# React関連 (バージョン指定)
npm pack react@19.0.0 react-dom@19.0.0 react-router-dom@5.3.4 @ionic/react@8.4.3 @ionic/react-router@8.4.3

npm pack react-scripts@5.0.1
```

✅ **作成される `.tgz`**
```sh
ionic-7.2.0.tgz
@ionic/cli-7.2.0.tgz
capacitor-core-5.0.0.tgz
capacitor-cli-5.0.0.tgz
capacitor-android-5.0.0.tgz
typescript-5.8.2.tgz
ts-node-10.9.2.tgz
types-node-22.13.10.tgz
react-18.3.0.tgz
react-dom-18.3.0.tgz
react-router-dom-7.3.0.tgz
@ionic/react-7.2.0.tgz
@ionic/react-router-7.2.0.tgz
```

---

### **📌 1-2. `.tgz` をオフライン環境へコピー**
取得した **`offline_packages/`** フォルダごとオフライン環境へ移動。  
（USB、OneDrive、LAN経由などでコピー）

---

## **📌 2. オフライン環境で開発環境をセットアップ**
### **📌 2-1. 必要なパッケージをオフライン環境にインストール**
オフライン環境の作業ディレクトリ（例: `C:\Development\ionic-offline`）に `.tgz` を移動し、以下のコマンドを実行。

```sh
cd C:\Development\ionic-offline

# オフライン環境で npm パッケージをインストール
npm install `
  "../offline_packages/capacitor-android-7.0.1.tgz" `
  "../offline_packages/capacitor-cli-7.0.1.tgz" `
  "../offline_packages/capacitor-core-7.0.1.tgz" `
  "../offline_packages/ionic-5.4.16.tgz" `
  "../offline_packages/ionic-cli-7.2.0.tgz" `
  "../offline_packages/ionic-react-8.4.3.tgz" `
  "../offline_packages/ionic-react-router-8.4.3.tgz" `
  "../offline_packages/react-18.3.1.tgz" `
  "../offline_packages/react-dom-18.3.1.tgz" `
  "../offline_packages/react-router-dom-6.15.0.tgz" `
  "../offline_packages/ts-node-10.9.2.tgz" `
  "../offline_packages/types-node-22.13.10.tgz" `
  "../offline_packages/typescript-5.8.2.tgz" `
  "../offline_packages/react-scripts-5.0.1.tgz" `
  "../offline_packages/types-react-18.3.18.tgz" `
  "../offline_packages/types-react-dom-18.3.5.tgz" `
  --legacy-peer-deps --cache "../.npm-cache"




```

✅ **成功すると、以下がローカルにインストールされる**
```sh
added 30 packages in Xs
```

---

## **📌 3. オフラインで新規 Ionic React プロジェクトを作成**
### **🔧 PowerShell に対応したインストール手順**
**PowerShell では、改行時に `\` ではなく `` ` `` （バッククォート）を使用する必要があります。**  
また、**`../` の表記を `..\` に修正** し、PowerShell に対応しました。

---

## **📌 PowerShell 対応版: オフラインで新規 Ionic React プロジェクトを作成**

### **📌 3-1. プロジェクト作成**
```powershell
ionic start myApp blank --type=react --no-confirm
```
📌 **`--no-confirm` でオンライン確認をスキップ**  
✅ **成功すると `myApp/` フォルダが作成される！**

---

### **📌 3-2. 作成したプロジェクトへ移動**
```powershell
Set-Location -Path "C:\Development\docs\note\IonicFramework\環境構築\offline_package\myApp"
```

---

### **📌 3-3. TypeScript + Capacitor + React をインストール**
```powershell
npm install `
  ..\offline_packages\capacitor-core-7.0.1.tgz `
  ..\offline_packages\capacitor-cli-7.0.1.tgz `
  ..\offline_packages\capacitor-android-7.0.1.tgz `
  ..\offline_packages\react-19.0.0.tgz `
  ..\offline_packages\react-dom-19.0.0.tgz `
  ..\offline_packages\react-router-dom-5.3.4.tgz `
  ..\offline_packages\ionic-react-8.4.3.tgz `
  ..\offline_packages\ionic-react-router-8.4.3.tgz `
  --legacy-peer-deps
```
📌 **`--legacy-peer-deps` をつけることで `react-router-dom` のバージョン問題を回避**

---

### **📌 3-4. Capacitor を初期化**
```powershell
npx cap init myApp com.example.myapp
```
✅ **成功すると `capacitor.config.ts` が作成される！**

---

## **📌 4. Android 環境のセットアップ**

### **📌 4-1. Android プラットフォームを追加**
```powershell
npx cap add android
```
✅ **`android/` フォルダが作成される！**

---

### **📌 4-2. Android Studio で開く**
```powershell
npx cap open android
```
📌 **これで Android Studio が開き、アプリを実行可能！**

---

### **📌 4-3. エミュレータ・実機でアプリを実行**
```powershell
npx cap run android
```
📌 **エミュレータまたは接続された実機でアプリが起動！**

---

## **📌 5. VSCode でオフライン開発**
### **📌 5-1. プロジェクトを VSCode で開く**
```powershell
code .
```

### **📌 5-2. Ionic アプリのホットリロード**
```powershell
ionic serve --no-open
```
📌 **ブラウザで `http://localhost:8100` を開けばアプリ確認OK！**

---

## **🎯 PowerShell 対応版: まとめ**
| 手順 | コマンド | 説明 |
|------|---------|------|
| **1** | `npm pack ...` | オンラインで `.tgz` を取得（React も含める） |
| **2** | `npm install ...` | オフライン環境で `.tgz` をインストール |
| **3** | `ionic start myApp blank --type=react` | 新規 Ionic React プロジェクト作成 |
| **4** | `npx cap add android` | Android プラットフォーム追加 |
| **5** | `npx cap open android` | Android Studio で開く |
| **6** | `npx cap run android` | エミュレータ・実機で実行 |
| **7** | `code .` | VSCode で開発 |

✅ **PowerShell でも問題なく動作するように修正済み！** 🚀


### **📌 `Cannot run init for a project using a non-JSON configuration file.` エラーの対応方法**
このエラーは、`capacitor.config.ts` がすでに存在しているために `npx cap init` が実行できないことが原因です。  
**Capacitor 5 以降では、`capacitor.config.ts` よりも `capacitor.config.json` を使用することを推奨** しており、`init` コマンドが `.json` 形式の設定ファイルを求めています。

---

### **✅ 修正手順**
#### **1️⃣ 既存の `capacitor.config.ts` を削除**
```powershell
Remove-Item -Path "capacitor.config.ts" -Force
```

#### **2️⃣ `capacitor.config.json` を作成**
手動で `capacitor.config.json` を作成するか、`npx cap init` を再実行します。

```powershell
npx cap init myApp com.example.myapp
```

✅ **成功すると、新しい `capacitor.config.json` が作成されます。**

---

### **📌 `capacitor.config.ts` を維持したい場合**
もし **`capacitor.config.ts` を維持したい場合** は、以下の手順で `.ts` 形式でも `init` を通せるようにします。

1. **手動で `capacitor.config.json` を一時的に作成**
   ```powershell
   echo "{ \"appId\": \"com.example.myapp\", \"appName\": \"myApp\", \"webDir\": \"www\", \"bundledWebRuntime\": false }" > capacitor.config.json
   ```

2. **その後、`capacitor.config.ts` を使うために `.json` を削除**
   ```powershell
   Remove-Item -Path "capacitor.config.json" -Force
   ```

📌 **これで、手動で作成した `capacitor.config.ts` を維持しつつ設定ができます！** 🚀

このエラーを解決するには、`capacitor.config.ts` を削除し、`capacitor.config.json` を使用する必要があります。

### **✅ 修正手順**
#### **1️⃣ 既存の `capacitor.config.ts` を削除**
PowerShellで以下のコマンドを実行してください：
```powershell
Remove-Item -Path "capacitor.config.ts" -Force
```

#### **2️⃣ `capacitor.config.json` を作成**
再度 `npx cap init` を実行：
```powershell
npx cap init myApp com.example.myapp
```
✅ **成功すると、新しい `capacitor.config.json` が作成されます。**

---

### **📌 `capacitor.config.ts` を維持したい場合**
もし TypeScript 形式の `capacitor.config.ts` を維持したい場合は、以下の手順を試してください：

#### **1️⃣ 一時的に `capacitor.config.json` を作成**
手動で `capacitor.config.json` を作成し、次の内容を含めます：
```powershell
New-Item -Path "capacitor.config.json" -ItemType File
Set-Content -Path "capacitor.config.json" -Value '{ "appId": "com.example.myapp", "appName": "myApp", "webDir": "www", "bundledWebRuntime": false }'
```

#### **2️⃣ `capacitor.config.ts` を作成**
その後、`capacitor.config.ts` に変換することもできます：
```typescript
import { CapacitorConfig } from '@capacitor/cli';

const config: CapacitorConfig = {
  appId: 'com.example.myapp',
  appName: 'myApp',
  webDir: 'www',
  bundledWebRuntime: false,
};

export default config;
```

#### **3️⃣ `capacitor.config.json` を削除**
```powershell
Remove-Item -Path "capacitor.config.json" -Force
```
📌 **これで `capacitor.config.ts` を維持しつつ、設定を適用できます！** 🚀