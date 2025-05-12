### ✅ ステップ 1: Vuetify 3 の導入

#### 【1-1】プロジェクトの前提条件

* Node.js（最新版推奨）
* Vue 3 プロジェクト（Vite または Vue CLI）

---

#### 【1-2】Vite + Vuetify プロジェクトの新規作成（推奨）

```bash
npm create vite@latest my-vuetify-app -- --template vue
cd my-vuetify-app
npm install
```

#### 【1-3】Vuetify 3 のインストール

```bash
npm install vuetify@latest
```

#### 【1-4】Vuetify 用の依存パッケージも追加

```bash
npm install sass sass-loader@^13 vite-plugin-vuetify
```

---

#### 【1-5】Vite に Vuetify プラグインを追加（vite.config.ts）

```ts
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import vuetify from 'vite-plugin-vuetify'

export default defineConfig({
  plugins: [
    vue(),
    vuetify({ autoImport: true }), // ← 追加
  ],
})
```

---

#### 【1-6】Vuetify を main.ts に設定

```ts
// main.ts
import { createApp } from 'vue'
import App from './App.vue'
import { createVuetify } from 'vuetify'
import 'vuetify/styles'

import { aliases, mdi } from 'vuetify/iconsets/mdi'
import '@mdi/font/css/materialdesignicons.css'

const vuetify = createVuetify({
  icons: {
    defaultSet: 'mdi',
    aliases,
    sets: { mdi },
  },
})

createApp(App).use(vuetify).mount('#app')
```

---

#### 【1-7】基本動作テスト用の Vuetify コンポーネントを追加

```vue
<!-- App.vue -->
<template>
  <v-app>
    <v-main>
      <v-container class="pa-4">
        <v-btn color="primary">Vuetify ボタン</v-btn>
      </v-container>
    </v-main>
  </v-app>
</template>
```

---

これで **Vuetify 3 の導入完了**です。

次は「2. 基本コンポーネントの理解」に進みますか？
