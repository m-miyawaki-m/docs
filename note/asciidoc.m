Asciidoc自体には、複数ページをタブ管理するネイティブ機能はありません。ただし、Asciidocで生成したHTMLやその他の出力フォーマットにカスタムCSSやJavaScriptを組み込むことで、複数ページのタブ管理を実現できます。

以下は、Asciidocでタブ管理を行うための一般的なアプローチです。


---

方法 1: Asciidoc内にHTMLを埋め込む

Asciidocの中でHTMLを直接記述し、タブ機能を実現します。

++++
<div class="tabs">
  <button class="tablinks" onclick="openTab(event, 'Page1')">Page 1</button>
  <button class="tablinks" onclick="openTab(event, 'Page2')">Page 2</button>
</div>

<div id="Page1" class="tabcontent">
  <h3>Page 1</h3>
  <p>こちらはページ1の内容です。</p>
</div>

<div id="Page2" class="tabcontent" style="display:none;">
  <h3>Page 2</h3>
  <p>こちらはページ2の内容です。</p>
</div>

<script>
function openTab(evt, tabName) {
  var i, tabcontent, tablinks;
  tabcontent = document.getElementsByClassName("tabcontent");
  for (i = 0; i < tabcontent.length; i++) {
    tabcontent[i].style.display = "none";
  }
  tablinks = document.getElementsByClassName("tablinks");
  for (i = 0; i < tablinks.length; i++) {
    tablinks[i].className = tablinks[i].className.replace(" active", "");
  }
  document.getElementById(tabName).style.display = "block";
  evt.currentTarget.className += " active";
}
</script>
++++

この方法で実現できること

ページ1とページ2の内容をタブで切り替え。

CSSやJavaScriptを追加することで、デザインや機能をカスタマイズ可能。



---

方法 2: 外部CSS/JavaScriptを利用する

HTML出力後、外部のCSSフレームワーク（例: BootstrapやTailwind）を活用すると、より高度なタブ機能を簡単に実装できます。

Asciidocのコード例:

++++
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>

<ul class="nav nav-tabs" id="myTab" role="tablist">
  <li class="nav-item" role="presentation">
    <button class="nav-link active" id="page1-tab" data-bs-toggle="tab" data-bs-target="#page1" type="button" role="tab">Page 1</button>
  </li>
  <li class="nav-item" role="presentation">
    <button class="nav-link" id="page2-tab" data-bs-toggle="tab" data-bs-target="#page2" type="button" role="tab">Page 2</button>
  </li>
</ul>
<div class="tab-content">
  <div class="tab-pane fade show active" id="page1" role="tabpanel">こちらはページ1の内容です。</div>
  <div class="tab-pane fade" id="page2" role="tabpanel">こちらはページ2の内容です。</div>
</div>
++++

この方法のメリット

Bootstrapのスタイルを利用できるため、見た目が整ったタブを簡単に作成可能。

JavaScriptの実装を最小限に抑えられる。



---

方法 3: 静的な複数ページ構成でナビゲーションリンクを使用

タブ管理ではなく、各ページを独立させてリンクで管理する方法です。

Asciidocのコード例:

= Main Page

タブのように見せるためのリンクを作成します。

* link:page1.html[Page 1]
* link:page2.html[Page 2]

補足

各ページ（page1.adocやpage2.adoc）を別々に記述し、ビルド時にそれぞれHTMLに変換します。


---

推奨

簡易的な実装: 方法1でHTMLを埋め込む。

洗練されたデザイン: 方法2でBootstrapや外部ライブラリを活用。

シンプルな静的構成: 方法3でナビゲーションリンクを使用。


文字数: 898
トークン数: 124


Bootstrapを使いながら、ページの内容をAsciidocの内容で差し込むには、以下のように設定を行います。


---

手順

1. AsciidocにBootstrapのCSS/JSを読み込む Asciidocに直接Bootstrapのリンクを埋め込むことで、Bootstrapのスタイルを利用可能にします。


2. Asciidocの内容をHTMLタブに差し込む Asciidocの構文を使って、タブごとに内容を記述し、HTML出力時にBootstrapのタブ機能を適用します。




---

実装例

以下は、Bootstrapのタブ機能を使用し、Asciidocの内容を差し込む例です。

Asciidocのコード例

++++
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
++++

=== タブ管理のサンプル

以下にタブを作成し、各タブに内容を差し込みます。

++++
<ul class="nav nav-tabs" id="myTab" role="tablist">
  <li class="nav-item" role="presentation">
    <button class="nav-link active" id="page1-tab" data-bs-toggle="tab" data-bs-target="#page1" type="button" role="tab">Page 1</button>
  </li>
  <li class="nav-item" role="presentation">
    <button class="nav-link" id="page2-tab" data-bs-toggle="tab" data-bs-target="#page2" type="button" role="tab">Page 2</button>
  </li>
</ul>
<div class="tab-content">
  <div class="tab-pane fade show active" id="page1" role="tabpanel">
++++

.Page 1の内容
Asciidocの内容をここに記述できます。
例えば、以下のリストなど:
* アイテム1
* アイテム2

++++
  </div>
  <div class="tab-pane fade" id="page2" role="tabpanel">
++++

.Page 2の内容
表を記述することも可能です。

[cols="1,1", options="header"]
|===
|列1 |列2
|データ1 |データ2
|データ3 |データ4
|===

++++
  </div>
</div>
++++


---

仕組みのポイント

1. Bootstrapのタブ構造 Bootstrapが提供するタブ機能の構造をHTML内に記述します。nav-tabsやtab-contentを活用します。


2. Asciidocの内容をタブごとに差し込む 各タブの<div>内にAsciidocで記述した内容を埋め込みます。


3. HTML埋め込み (++++ブロック) ++++ブロックでHTMLを直接記述し、その中にAsciidocの構文を含めて利用します。




---

出力イメージ

1. Page 1: リスト形式の内容が表示される。


2. Page 2: 表形式のデータが表示される。




---

補足

BootstrapのリンクはCDN経由で読み込んでいますが、必要に応じてローカルにファイルを配置して使用することも可能です。

data-bs-toggleやtab-paneのクラスを変更することで、Bootstrapのスタイルに応じたカスタマイズが可能です。



---

この方法で、Asciidocの内容を直接タブに差し込みつつ、Bootstrapのスタイルを活用できます。



サイドバーでジャンルを切り替え、それぞれのジャンルに複数のタブを用意するには、Bootstrapのサイドバーとタブ機能を組み合わせる方法が最適です。

以下に、具体的な手順とAsciidocコード例を示します。


---

手順

1. サイドバーを作成 Bootstrapのlist-groupやnavクラスを使ってサイドバーを作成します。


2. ジャンルごとにタブを用意 各ジャンルをtab-content内に対応するHTML要素として記述し、タブで切り替えられるようにします。


3. ジャンルとタブの連携 サイドバーの項目をクリックすると、対応するジャンルが表示されるようにします。




---

実装例

以下のコードは、サイドバーでジャンルを切り替え、それぞれのジャンルで複数のタブを用意する例です。

Asciidocコード例

++++
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
++++

=== サイドバーとタブ管理のサンプル

以下に、サイドバーとタブ機能を組み合わせた構造を作成します。

++++
<div class="container-fluid">
  <div class="row">
    <!-- サイドバー -->
    <nav class="col-md-2 d-md-block bg-light sidebar">
      <div class="position-sticky">
        <ul class="nav flex-column">
          <li class="nav-item">
            <a class="nav-link active" id="genre1-link" data-bs-toggle="tab" href="#genre1" role="tab">ジャンル1</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" id="genre2-link" data-bs-toggle="tab" href="#genre2" role="tab">ジャンル2</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" id="genre3-link" data-bs-toggle="tab" href="#genre3" role="tab">ジャンル3</a>
          </li>
        </ul>
      </div>
    </nav>

    <!-- メインコンテンツ -->
    <main class="col-md-10">
      <div class="tab-content">
        <!-- ジャンル1 -->
        <div class="tab-pane fade show active" id="genre1" role="tabpanel">
          <ul class="nav nav-tabs" id="genre1-tabs">
            <li class="nav-item">
              <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#genre1-tab1">タブ1</button>
            </li>
            <li class="nav-item">
              <button class="nav-link" data-bs-toggle="tab" data-bs-target="#genre1-tab2">タブ2</button>
            </li>
          </ul>
          <div class="tab-content">
            <div class="tab-pane fade show active" id="genre1-tab1">ジャンル1 - タブ1の内容</div>
            <div class="tab-pane fade" id="genre1-tab2">ジャンル1 - タブ2の内容</div>
          </div>
        </div>

        <!-- ジャンル2 -->
        <div class="tab-pane fade" id="genre2" role="tabpanel">
          <ul class="nav nav-tabs" id="genre2-tabs">
            <li class="nav-item">
              <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#genre2-tab1">タブ1</button>
            </li>
            <li class="nav-item">
              <button class="nav-link" data-bs-toggle="tab" data-bs-target="#genre2-tab2">タブ2</button>
            </li>
          </ul>
          <div class="tab-content">
            <div class="tab-pane fade show active" id="genre2-tab1">ジャンル2 - タブ1の内容</div>
            <div class="tab-pane fade" id="genre2-tab2">ジャンル2 - タブ2の内容</div>
          </div>
        </div>

        <!-- ジャンル3 -->
        <div class="tab-pane fade" id="genre3" role="tabpanel">
          <ul class="nav nav-tabs" id="genre3-tabs">
            <li class="nav-item">
              <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#genre3-tab1">タブ1</button>
            </li>
            <li class="nav-item">
              <button class="nav-link" data-bs-toggle="tab" data-bs-target="#genre3-tab2">タブ2</button>
            </li>
          </ul>
          <div class="tab-content">
            <div class="tab-pane fade show active" id="genre3-tab1">ジャンル3 - タブ1の内容</div>
            <div class="tab-pane fade" id="genre3-tab2">ジャンル3 - タブ2の内容</div>
          </div>
        </div>
      </div>
    </main>
  </div>
</div>
++++


---

実装のポイント

1. サイドバー (Sidebar)

Bootstrapのnavクラスを使い、ジャンルを切り替えるリンクを作成します。

data-bs-toggle="tab"属性で、ジャンル切り替えを実現。



2. ジャンルごとのタブ

各ジャンルに対応するdivを用意し、その中にさらにタブを配置。

各タブの内容はtab-paneクラスで記述。



3. レスポンシブ対応

container-fluidやcol-md-*を使用して、レスポンシブデザインを適用。





---

出力イメージ

1. 左側のサイドバーでジャンルを切り替え。


2. 右側のメインコンテンツで、選択したジャンルに対応するタブが表示。


3. タブを切り替えると、それぞれの内容が表示される。




---

カスタマイズのヒント

サイドバーのスタイルを変更したい場合は、bg-lightやposition-stickyを変更。

各ジャンルやタブの内容をAsciidocで記述して柔軟に対応可能。


このコードを使うことで、サイドバーとタブを組み合わせた構造を簡単に構築できます。

