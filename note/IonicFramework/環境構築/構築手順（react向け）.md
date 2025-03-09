## **📌 オフライン環境での Ionic 開発環境の構築手順**
オフライン環境で **Ionic フレームワークを開発する** ためのセットアップ方法を検討します。  
USB やネット接続はできないため、**ネットに接続した端末で必要なインストーラーやライブラリをすべてダウンロード** し、オフライン環境に持ち込む方法を取ります。

---

## **✅ 1. ネット環境で必要なパッケージを事前に用意**
### **(1) Node.js + npm のオフラインインストール**
Ionic は **Node.js** を利用するため、事前に **オフラインインストール可能なセットアップファイル** を用意します。

1. **Node.js インストーラーをダウンロード**
   - [Node.js 公式サイト](https://nodejs.org/en) から **LTS版 (推奨版)** をダウンロード  
   - `node-vXX.X.X-x64.msi` (Windows) / `node-vXX.X.X.pkg` (Mac) / `node-vXX.X.X.tar.xz` (Linux) などを取得

2. **オフラインでの Node.js インストール方法**
   - `.msi` や `.pkg` を開発環境にコピーして実行

3. **npm (Node Package Manager) のオフラインインストール**
   - `npm` は Node.js に同梱されているため、インストール後に `npm -v` で確認できる

---

### **(2) Ionic CLI のオフラインインストール**
Ionic CLI (`ionic` コマンド) をオフライン環境で動かすため、npm のパッケージをオフラインで持ち込む必要があります。

1. **ネット環境で `ionic` のパッケージをダウンロード**
   ```sh
   npm pack @ionic/cli
   ```
   これにより、`ionic-cli-<version>.tgz` というファイルが生成される。

2. **オフライン環境で `ionic` をインストール**
   - `.tgz` ファイルを開発環境にコピーし、以下のコマンドでインストール
   ```sh
   npm install -g ./ionic-cli-<version>.tgz
   ```

3. **インストール確認**
   ```sh
   ionic -v
   ```
   正しくインストールされていれば、バージョンが表示される。

---

### **(3) Angular / Cordova / Capacitor のオフラインインストール**
Ionic プロジェクトには **Angular / Cordova / Capacitor** などが必要な場合があるため、事前にパッケージをダウンロード。

#### **1. Angular のオフラインインストール**
```sh
npm pack @angular/cli
npm pack @angular/core
npm pack @angular/common
npm pack @angular/compiler
npm pack @angular/platform-browser
npm pack @angular/platform-browser-dynamic
```
上記をオフライン環境で
```sh
npm install -g ./angular-cli-<version>.tgz
```
でインストール。

#### **2. Cordova (モバイル開発向け) のオフラインインストール**
```sh
npm pack cordova
```
オフライン環境で
```sh
npm install -g ./cordova-<version>.tgz
```

#### **3. Capacitor (ネイティブ機能対応) のオフラインインストール**
```sh
npm pack @capacitor/core
npm pack @capacitor/cli
npm pack @capacitor/android
npm pack @capacitor/ios
```
オフライン環境で
```sh
npm install -g ./capacitor-cli-<version>.tgz
```

---

## **✅ 2. Ionic プロジェクトのオフラインセットアップ**
### **(1) ネット環境で Ionic プロジェクトを作成**
```sh
ionic start myApp blank --no-deps
```
このコマンドで **依存関係をインストールせずに** プロジェクトを作成する。

### **(2) `node_modules` を取得してオフラインで使用**
1. **ネット環境で `npm install` して `node_modules` を生成**
   ```sh
   cd myApp
   npm install
   ```
2. **`node_modules` を圧縮**
   ```sh
   tar -czf node_modules.tar.gz node_modules
   ```
3. **オフライン環境に `node_modules.tar.gz` をコピーして解凍**
   ```sh
   tar -xzf node_modules.tar.gz
   ```



### **🔹 この手順は React 版 Ionic では一部変更が必要**
このオフラインセットアップ手順は **Ionic Angular 向けのもの** になっており、**Ionic React で利用する場合は一部修正が必要** です。

---

## **🔹 Ionic React で使える部分**
✅ **そのまま使える手順**
1. **Node.js + npm のオフラインセットアップ**
   - `node-vXX.X.X` のオフラインインストールは共通で必要
   - `npm pack` で `.tgz` を作成してオフラインで `npm install` も可能

2. **Ionic CLI のオフラインインストール**
   - `npm pack @ionic/cli` を使い、オフラインで `npm install -g ./ionic-cli-<version>.tgz`

3. **`node_modules` を圧縮してオフライン環境にコピー**
   - `tar -czf node_modules.tar.gz node_modules` でオフライン環境に持ち込み、解凍後 `npm rebuild`

4. **Android / iOS のオフライン開発環境セットアップ**
   - Android SDK や Xcode のオフラインセットアップは、Ionic Angular でも Ionic React でも同じ

---

## **🔹 Ionic React 用に修正が必要な部分**
### **❌ 修正が必要な手順**
1. **Angular に関するセットアップは不要**
   - `npm pack @angular/cli`
   - `npm pack @angular/core` などの Angular パッケージは **Ionic React では不要！**

2. **React 用のライブラリを事前に用意**
   - **Ionic React では `React` + `React Router` を使うため、以下のパッケージをダウンロード**
   ```sh
   npm pack react
   npm pack react-dom
   npm pack react-router
   npm pack react-router-dom
   npm pack @ionic/react
   npm pack @ionic/react-router
   ```
   - オフライン環境でインストールする場合:
   ```sh
   npm install ./react-<version>.tgz
   npm install ./react-router-dom-<version>.tgz
   npm install ./ionic-react-<version>.tgz
   ```

3. **Ionic プロジェクトの作成方法を変更**
   - **Angular 版の `ionic start myApp blank --no-deps` は使用しない**
   - **Ionic React 用のコマンドを使用**
   ```sh
   ionic start myApp blank --type=react --no-deps
   ```
   - `--type=react` をつけることで、Angular ではなく React プロジェクトとして作成できる。


### **🔹 4. Ionic React プロジェクトのオフラインセットアップ**
❌ **Angular 向けの `npm pack @angular/cli` は不要**  
✅ **Ionic React に必要なパッケージを事前にダウンロード**
```sh
npm pack react
npm pack react-dom
npm pack react-router
npm pack react-router-dom
npm pack @ionic/react
npm pack @ionic/react-router
```
✅ **オフライン環境で `npm install`**
```sh
npm install ./react-<version>.tgz
npm install ./react-dom-<version>.tgz
npm install ./react-router-dom-<version>.tgz
npm install ./ionic-react-<version>.tgz
```

### **✅ 5. Android / iOS のオフライン開発環境セットアップ**
✅ 変更なし（Android SDK, Xcode のセットアップ）

---

## **🔹 まとめ**
| **手順** | **Ionic Angular** | **Ionic React（修正後）** |
|----------|-----------------|------------------|
| **Node.js + npm のオフラインセットアップ** | ✅ そのまま | ✅ そのまま |
| **Ionic CLI のオフラインインストール** | ✅ そのまま | ✅ そのまま |
| **node_modules を取得しオフラインへ持ち込み** | ✅ そのまま | ✅ そのまま |
| **Ionic プロジェクトの作成** | `ionic start myApp blank --no-deps` | `ionic start myApp blank --type=react --no-deps` |
| **Angular 用パッケージ (`@angular/cli` など)** | ✅ 必要 | ❌ **不要** |
| **React 用パッケージ (`react`, `react-router-dom` など)** | ❌ 不要 | ✅ **必要** |
| **Android / iOS の開発環境セットアップ** | ✅ そのまま | ✅ そのまま |

---

## **🔹 結論**
✅ **このオフライン環境構築手順は Ionic React でも使えるが、Angular に依存する部分を修正する必要がある。**  
✅ **`@angular/cli` などの Angular 用パッケージは不要。代わりに `react`, `react-dom`, `react-router-dom`, `@ionic/react` などをオフラインでインストールする必要がある。**  
✅ **Ionic の CLI (`ionic start myApp blank --type=react --no-deps`) を適切に指定すれば、オフライン環境でも Ionic React 開発が可能！** 🚀