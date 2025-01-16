Ruby 3.3 (x64) の ZIPファイル版 しかない場合でも、オフライン環境で Asciidoctor を動かすことは可能です。ただし、以下のような準備が必要です。


---

手順

1. ZIP ファイルを解凍して Ruby をセットアップ

1. ZIP ファイルの解凍

ruby33-x64.zip を適当なディレクトリに解凍します。

例: C:\ruby33 に解凍。



2. 環境変数の設定

Ruby の実行ファイルが見つかるよう、パスを通します。

1. 「システム環境変数」を開きます。


2. PATH に解凍したディレクトリのパスを追加：

C:\ruby33\bin


3. コマンドプロンプトを再起動して反映。





3. 動作確認

コマンドプロンプトで以下を実行して Ruby が認識されていることを確認：

ruby --version





---

2. 必要な gem の準備

1. オンライン環境で gem をダウンロード

必要な gem を事前にダウンロードします。

gem install --install-dir ./gems asciidoctor
gem install --install-dir ./gems asciidoctor-pdf

ダウンロードされた gem ファイル（./gems/*.gem）をオフライン環境にコピー。



2. gem のオフラインインストール

コピーした gem をインストール：

gem install --local ./gems/*.gem



3. 動作確認

asciidoctor のバージョンを確認：

asciidoctor --version





---

3. PDF 出力の準備と実行

1. テーマファイルの準備

必要に応じてカスタムテーマ（例: default-theme.yml）を準備。

テーマは公式リポジトリから取得可能： Asciidoctor PDF Themes



2. PDF 出力

以下のコマンドを実行して PDF を生成：

asciidoctor-pdf -r asciidoctor-pdf -a pdf-theme=default-theme.yml sample.adoc





---

4. 問題が発生した場合

依存関係の不足

必要な gem の依存関係が不足している場合、エラーメッセージに記載される gem をオンライン環境で追加ダウンロードしてコピーします。

gem install --install-dir ./gems gem_name


テーマエラー

テーマファイルのパス指定を確認するか、テーマを省略して実行：

asciidoctor-pdf sample.adoc




---

まとめ

ZIP 版の Ruby を使っても問題なく Asciidoctor と asciidoctor-pdf を動かすことができます。

ただし、gem の準備をオンライン環境で事前に行う必要があります。

何か問題が発生した場合は、エラーメッセージを教えていただければ解決策を提供します。


