## **Node.jsとは何か？**
### **1. 概要**
**Node.js** は、Google Chrome の V8 JavaScript エンジンの上に構築された **サーバーサイドの JavaScript 実行環境** です。  
もともとは **クライアントサイド（ブラウザ上）で動作する JavaScript** を、**サーバーサイドでも実行できるようにする** ために開発されました。

📌 **ポイント**
- Node.js は **ブラウザなしで JavaScript を実行** できる環境
- **非同期処理** や **イベント駆動** の仕組みを採用
- **バックエンドアプリケーション、APIサーバー、CLIツールの開発** でよく使われる
- **npm（Node Package Manager）** というパッケージ管理ツールを内蔵

---

### **2. なぜ Node.js がよく使われるのか？**
Node.js は **CI/CD パイプラインや開発環境のセットアップ** で頻繁に登場します。その理由は以下のとおり。

#### **✅ 1. JavaScript のエコシステムが強力**
Node.js には `npm` というパッケージマネージャーがあり、**数百万種類のライブラリ** をインストールして利用できる。
```sh
npm install eslint
npm install jest
```
⬆ これだけで、ESLint（Lint チェックツール）や Jest（テストフレームワーク）を簡単に使える。

---

#### **✅ 2. フロントエンド開発と相性が良い**
- **React** / **Vue** / **Angular** のプロジェクトは `npm` や `yarn` を使って管理される。
- CI/CD でフロントエンドをビルドする際に `npm install` する必要がある。

```sh
npm install
npm run build
```
⬆ こうしたコマンドが、フロントエンドのビルドやテストに必須。

---

#### **✅ 3. CI/CD でよく使われる**
Jenkins や GitHub Actions で `Node.js` をインストールする理由の多くは、**JavaScript ベースのツールを実行するため**。

🔹 例1: CI/CD で Lint チェックを実行
```yaml
jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: 18
      - run: npm install
      - run: npm run lint
```

🔹 例2: Jenkins で `Node.js` を使ったテストを実行
```groovy
pipeline {
    agent any
    stages {
        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }
        stage('Run Tests') {
            steps {
                sh 'npm test'
            }
        }
    }
}
```
⬆ **Node.js を使ったプロジェクト**（React, Vue, Express.js など）の場合、`npm install` がないと CI/CD が動かない。

---

#### **✅ 4. CLI ツールが Node.js 製のものが多い**
例えば、以下のようなツールは Node.js で動くため、インストールが必要。

| CLIツール | 役割 |
|-----------|------|
| **ESLint** | コードの静的解析（Lint チェック） |
| **Jest** | JavaScript のテストフレームワーク |
| **Webpack** | フロントエンドのバンドルツール |
| **Vue CLI** | Vue.js のプロジェクト管理 |
| **Create React App** | React のプロジェクト作成ツール |

```sh
npm install -g eslint
eslint src/
```
⬆ Node.js がないと、これらのツールは動作しない。

---

### **3. Node.js を使った代表的なアプリケーション**
Node.js は **Web開発だけでなく、サーバーサイドアプリやCLIツール、API開発** でも利用される。

| 用途 | 代表的なフレームワーク / ツール |
|------|----------------------|
| **フロントエンド** | React.js / Vue.js / Angular |
| **バックエンド** | Express.js / Nest.js / Fastify |
| **API サーバー** | GraphQL / Koa.js |
| **CI/CD・自動化** | ESLint / Jest / Prettier |
| **サーバーレス** | AWS Lambda / Firebase Functions |
| **リアルタイム通信** | WebSocket / Socket.io |
| **デスクトップアプリ** | Electron（Slack, VSCode など） |
| **CLI ツール** | npm / yarn / Webpack |

---

### **4. Node.js のインストール方法**
📌 **Node.js の公式サイト** → [https://nodejs.org/](https://nodejs.org/)

#### **✅ 方法 1: nvm（Node Version Manager）を使う**
Node.js のバージョンを切り替えられるので **おすすめ**。
```sh
# nvm のインストール（Linux/macOS）
curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# Node.js 最新版をインストール
nvm install node
nvm use node

# バージョン確認
node -v
npm -v
```

#### **✅ 方法 2: `apt` / `brew` でインストール**
**Ubuntu / Debian**
```sh
sudo apt update
sudo apt install -y nodejs npm
node -v
npm -v
```
**macOS (Homebrew)**
```sh
brew install node
node -v
npm -v
```

#### **✅ 方法 3: Windows の場合**
1. [公式サイト](https://nodejs.org/) から `.msi` をダウンロード
2. インストーラーを実行してインストール
3. `node -v` で確認

---

### **5. Node.js を使った Hello World**
**Node.js がインストールされたか確認するには？**
```sh
node -v
npm -v
```
**簡単なスクリプトを実行**
```sh
node -e "console.log('Hello, Node.js!')"
```

**`server.js` を作成して、簡単なサーバーを立てる**
```js
const http = require('http');

const server = http.createServer((req, res) => {
    res.writeHead(200, { 'Content-Type': 'text/plain' });
    res.end('Hello, Node.js Server!');
});

server.listen(3000, () => {
    console.log('Server running at http://localhost:3000/');
});
```
```sh
node server.js
```
⬆ **http://localhost:3000/ にアクセスすると "Hello, Node.js Server!" が表示される**

---

## **まとめ**
### **🔹 Node.js とは？**
- **サーバーサイドの JavaScript 実行環境**
- **npm** を使ってライブラリを簡単に管理できる
- **非同期処理が得意**

### **🔹 なぜ CI/CD で頻繁に登場するのか？**
- フロントエンド（React / Vue）のビルドに必要
- ESLint, Jest, Webpack などの CLI ツールが Node.js 製
- CI/CD で `npm install && npm test` することが多い

### **🔹 よく使われる場面**
✅ **CI/CD パイプライン（Jenkins / GitHub Actions）**  
✅ **API サーバー（Express.js / Nest.js）**  
✅ **リアルタイム通信（Socket.io）**  
✅ **デスクトップアプリ（VSCode, Slack）**  

🚀 **つまり、CI/CD やフロントエンド開発では Node.js が必須になることが多い！**