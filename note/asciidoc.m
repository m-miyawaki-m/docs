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

