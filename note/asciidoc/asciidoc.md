ASCIIDOC導入方法
https://itcweb.cc.affrc.go.jp/affrit/documents/guide/asciidoc/start



Asciidocは軽量なマークアップ言語で、文書の構造を簡単に定義しやすいのが特徴です。以下に、基本的な文法とAsciidocでできることを説明します。


---

基本文法

1. 見出し

= タイトル (レベル1の見出し)
== セクション1 (レベル2の見出し)
=== サブセクション (レベル3の見出し)

2. 段落

普通の文章は空行で区切って書くだけで段落として認識されます。

これは段落です。

これは別の段落です。

3. 強調

斜体: _斜体_

太字: *太字*


これは _斜体_ です。
これは *太字* です。

4. リスト

箇条書きリスト:


* アイテム1
* アイテム2
  ** サブアイテム

番号付きリスト:


. 項目1
. 項目2

5. リンク

http://example.com[リンクのテキスト]

6. 画像

image::example.png[代替テキスト]

7. コードブロック

[source, java]
----
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
}
----

8. テーブル

|===
|列1 |列2 |列3
|値1 |値2 |値3
|値4 |値5 |値6
|===

9. 引用

[quote]
____
これは引用です。
____

10. アトリビュート（変数）

文書中で再利用可能な値を定義できます。

:project_name: Asciidoc Project

{project_name}は素晴らしいツールです。


---

Asciidocでやれること

1. 技術ドキュメント作成

手順書やガイドライン、APIドキュメントなどの技術的な文章作成。

AsciidoctorやAntoraなどのツールを使えば、HTMLやPDFに変換可能。



2. ブログやウェブサイトの作成

スタイルを定義して美しいHTML出力を生成可能。



3. 書籍執筆

長い文章や書籍の執筆にも向いています。章やセクションごとにファイルを分けて管理可能。



4. プレゼンテーション

reveal.jsなどのツールを使えば、スライドを簡単に作成可能。



5. スニペットやコード例の管理

コードブロックをハイライトしてドキュメントに組み込む。



6. Gitとの連携

テキストベースなのでGitでバージョン管理が簡単。





---

簡潔な文法で高機能なドキュメントを作成できるのがAsciidocの魅力です。試しに短い文書を作成してみると理解が深まります。

Asciidoc自体には直接PowerPoint（PPTX）ファイルを生成する機能はありませんが、以下の方法を利用すればAsciidocからプレゼンテーションを作成し、PowerPoint形式に変換することが可能です。


---

1. reveal.jsを利用してHTMLスライドを作成

Asciidoctor-reveal.jsを使うことで、Asciidoc文書からreveal.jsベースのHTMLスライドを生成できます。

手順:

1. 必要なツールをインストール

gem install asciidoctor asciidoctor-revealjs


2. Asciidoc文書を作成

= プレゼンテーションタイトル
:revealjs_theme: simple

== スライド1
ここにスライド1の内容を書きます。

== スライド2
ここにスライド2の内容を書きます。


3. スライドを生成

asciidoctor-revealjs presentation.adoc

これでHTMLスライドが作成されます。



4. PowerPointに変換

HTMLスライドをPDFに変換（ブラウザの印刷機能などを使用）。

PDFをPowerPoint形式（PPTX）に変換できるツール（Adobe Acrobat、オンラインツールなど）を使用。





---

2. Pandocを利用してPPTXを直接生成

Pandocを利用すると、Asciidoc形式からPPTX形式に直接変換できます。

手順:

1. Pandocのインストール

公式サイトからインストールします。



2. Asciidoc文書を準備

= プレゼンテーションタイトル
:slide-level: 2

== スライド1
スライド1の内容。

== スライド2
スライド2の内容。


3. PPTXを生成

pandoc -f asciidoc -t pptx -o presentation.pptx presentation.adoc

-f asciidoc: 入力形式をAsciidocに指定。

-t pptx: 出力形式をPPTXに指定。



4. カスタマイズ

Pandocではテンプレート（reference.pptx）を指定してカスタマイズしたスライドを作成可能。





---

3. Asciidoc→Markdown→PowerPoint

Asciidoc文書を一旦Markdownに変換し、PowerPointに対応したツールで読み込む方法もあります。

手順:

1. AsciidocをMarkdownに変換

asciidoctor -b markdown presentation.adoc -o presentation.md


2. PowerPoint用ツールに読み込み

Marpを利用してMarkdownからスライドを生成。

Marpでスライドを作成した後、PDFまたはPPTX形式でエクスポート。





---

まとめ

直接的なPPTX生成はPandocを使う方法が最適です。

reveal.jsを使ったHTMLスライドをPDF経由でPPTXに変換する方法も一般的。

Markdownを経由する方法も柔軟性があります。


ご自身の環境や要件に合わせて選択してください！



はい、Markdownを経由する方法では、特に複雑な図形やレイアウトが崩れる可能性が高いです。Markdown自体はテキストベースの軽量マークアップ言語であり、図形やレイアウトの詳細な指定にはあまり向いていないため、Asciidocのレイアウトをそのまま忠実にPPTXに移行するのは難しい場合があります。

以下に、崩れを防ぐための方法や代替案を示します。


---

1. Pandocで直接PPTXを生成する方法

Markdownを経由するのではなく、Pandocを使って直接AsciidocからPPTXを生成する方法を採用すると、図形やレイアウトの崩れを最小限に抑えられます。

理由: PandocはPPTXフォーマットを直接サポートしており、スライドの構造を維持しながら変換できます。

注意点:

reference.pptxを指定して、スライドのデザインやレイアウトを事前に定義しておくことを推奨します。

複雑な図や表は可能な限り画像として埋め込む（Asciidoc内で画像リンクを使用）。




---

2. 図形やレイアウトが複雑な場合の代替案

AsciidocやMarkdownでは、複雑な図形やレイアウトが崩れる可能性が高いので、以下の方法を検討するとよいでしょう。

2.1 Asciidoc内で図を画像として扱う

Asciidocでは、図形を直接定義するのではなく、外部画像として挿入することでレイアウト崩れを回避できます。

image::path/to/diagram.png[代替テキスト, width=500]

これにより、図形が変換時にそのまま表示されます。

2.2 手動で調整

Asciidoc→HTMLスライド→PPTXと変換する際に、一部手動でPPTX内の調整を行う方法。

特に図形や複雑な表はHTMLスライドで確認し、必要に応じてPowerPointで微調整します。



---

3. Marpや他ツールを使う際の注意

Markdownを経由してMarpや類似ツールでスライドを作成する場合、図形や複雑なレイアウトを維持するための工夫が必要です。

SVG形式を利用

MarpやMarkdownツールでは、SVGをそのまま埋め込むことが可能です。これにより、図形の品質を維持できます。


PDFベースで変換

Marpやreveal.jsを利用してPDFを生成し、それをPPTXに変換することでレイアウト崩れを最小限に抑えます。




---

4. 最終手段：PowerPointで直接作成する

複雑な図形やレイアウトを伴うプレゼンテーションで、どうしてもツールによる崩れが回避できない場合、Asciidocをベースにしたスライドのアウトラインだけを生成し、PowerPoint上で図形や細かいレイアウトを手動で補足します。

Asciidocはスライド構成を簡単に定義するのに優れていますが、図形やレイアウトが重視される場合には完全自動化は困難です。



---

結論

図形やレイアウトが重要な場合は、画像形式（PNG/SVG）を利用して埋め込むか、手動でPowerPointを調整する。

Markdown経由は軽量な文書や単純なスライド構成に適しているものの、複雑な図形やレイアウトには向かない。

PandocやHTMLスライドを活用しつつ、部分的に手作業で調整する方法が現実的。


作業内容やスライドの要件に合わせて最適な方法を選んでください！


AsciidocとDocBookの比較をステップバイステップで行います。それぞれの特徴、利点、欠点、ユースケースを明確に理解できるように整理します。


---

1. 概要の比較

Asciidoc

軽量マークアップ言語。

人間が読みやすい文法。

シンプルで素早く文書作成が可能。

HTML、PDF、EPUBなどへの出力が簡単（特にAsciidoctorを使用）。


DocBook

重量級マークアップ言語（XMLベース）。

産業規格として使用されることが多い。

複雑で構造化された技術文書の記述に適している。

XMLの専門知識が必要。



---

2. 文法の違い

見出しの書き方

Asciidoc:


= ドキュメントタイトル
== 見出し1
=== 見出し2

DocBook:


<book>
  <title>ドキュメントタイトル</title>
  <chapter>
    <title>見出し1</title>
    <section>
      <title>見出し2</title>
    </section>
  </chapter>
</book>

ポイント:

Asciidocは直感的でシンプル。

DocBookはXML構造に基づいているため冗長。



---

リストの書き方

Asciidoc:


* リスト1
* リスト2
  ** サブリスト

DocBook:


<itemizedlist>
  <listitem><para>リスト1</para></listitem>
  <listitem><para>リスト2</para>
    <itemizedlist>
      <listitem><para>サブリスト</para></listitem>
    </itemizedlist>
  </listitem>
</itemizedlist>

ポイント:

Asciidocはマークアップが短く、読みやすい。

DocBookは詳細な記述が可能だが、冗長性が高い。



---

コードブロックの書き方

Asciidoc:


[source, java]
----
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
}
----

DocBook:


<programlisting language="java">
public class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
}
</programlisting>

ポイント:

Asciidocは読みやすさを重視。

DocBookはXMLに準拠したタグが必要。



---

3. ツールのサポート

ポイント:

Asciidocは簡単な文書作成に向いている。

DocBookは大規模な技術文書や複雑な構造を必要とする場合に向いている。



---

4. 利用シーンの違い

Asciidocが向いている場合

軽量なドキュメント作成（手順書、ブログ、プレゼンテーション）。

人間が読みやすいマークアップを使いたい場合。

素早くHTMLやPDFを生成したい場合。


DocBookが向いている場合

大規模な技術文書や公式文書（マニュアル、規格書など）。

高度な構造化や再利用性が必要な場合。

XMLベースのワークフローを利用している場合。



---

5. 拡張性と互換性の比較


---

6. 結論と選択ガイド

簡潔な判断基準

1. 素早く簡単にドキュメントを作りたい場合 → Asciidoc。


2. 大規模で複雑な技術文書を管理したい場合 → DocBook。



ユースケースの具体例

Asciidoc: 開発者向けのREADME、ブログ、手順書。

DocBook: 製品の公式マニュアル、業界標準規格書。



---

DocBookは詳細な構造と高度なカスタマイズを可能にしますが、学習コストが高いため、必要性に応じて選ぶのが良いでしょう。一方、Asciidocは学習が容易で軽量な文書作成に非常に適しています。



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

