JavaParserでよく使われる主要なクラスと、それぞれが持つ代表的なメソッドを以下にまとめます。JavaParserを利用する際の参考にしてください。


---

1. JavaParser クラス

Javaコードを解析するためのエントリーポイント。

主なメソッド

parse(String code): Javaコード文字列を解析してCompilationUnitを返します。

parse(Path path): ファイルパスからJavaコードを解析します。

parse(Resource resource): リソースを基に解析します。

setParserConfiguration(ParserConfiguration config): パーサの設定を変更します。



---

2. CompilationUnit クラス

Javaファイル全体を表すクラス。

主なメソッド

getPackageDeclaration(): パッケージ宣言を取得します。

getImports(): インポート文のリストを取得します。

getType(int i): 指定した位置にあるタイプ（クラスやインターフェースなど）を取得します。

addType(TypeDeclaration<?> type): 新しい型を追加します。

findAll(Class<T> nodeClass): 指定したノード型（例: MethodDeclaration）をすべて取得します。

toString(): ソースコードとして出力します。



---

3. ClassOrInterfaceDeclaration クラス

クラスやインターフェースを表現するクラス。

主なメソッド

setName(String name): クラスまたはインターフェースの名前を設定します。

addMethod(String name): クラスに新しいメソッドを追加します。

addField(String type, String name): クラスに新しいフィールドを追加します。

getMethodsByName(String name): 指定した名前のメソッドを取得します。

isInterface(): インターフェースかどうかを確認します。

addExtendedType(String type): クラスにスーパークラスを追加します。



---

4. MethodDeclaration クラス

メソッドの宣言を表すクラス。

主なメソッド

setName(String name): メソッド名を変更します。

setType(String type): メソッドの戻り値の型を設定します。

setBody(BlockStmt body): メソッドの本体を設定します。

addParameter(String type, String name): パラメータを追加します。

getBody(): メソッド本体のブロックを取得します。

toString(): メソッド全体を文字列として取得します。



---

5. VariableDeclarator クラス

変数の宣言を表すクラス。

主なメソッド

getName(): 変数名を取得します。

getType(): 変数の型を取得します。

setInitializer(Expression initializer): 初期値を設定します。

getInitializer(): 初期値を取得します。



---

6. BlockStmt クラス

メソッドやコンストラクタの本体を表現するクラス。

主なメソッド

addStatement(Statement statement): 新しいステートメントを追加します。

getStatements(): ステートメントのリストを取得します。

toString(): ブロックの内容を文字列として取得します。



---

7. FieldDeclaration クラス

フィールドの宣言を表すクラス。

主なメソッド

setModifiers(Modifier... modifiers): フィールドに修飾子を設定します。

addVariable(VariableDeclarator variable): フィールド変数を追加します。

getVariables(): フィールド変数を取得します。



---

8. ParserConfiguration クラス

パーサの設定を管理するクラス。

主なメソッド

setLanguageLevel(LanguageLevel level): パーサの言語レベルを設定します（例: Java 8, Java 11など）。

setSymbolResolver(SymbolResolver resolver): シンボル解決のロジックを設定します。

setAttributeComments(boolean attributeComments): コメントを属性として扱うかを設定します。



---

9. Comment クラス

コメントを表現するクラス。

主なメソッド

getContent(): コメントの内容を取得します。

setContent(String content): コメントの内容を設定します。

isLineComment(): 行コメントかどうかを確認します。

isBlockComment(): ブロックコメントかどうかを確認します。



---

10. その他の主要クラス


---

JavaParserの特徴的な使い方

これらのクラスとメソッドを活用して、次のような処理が可能です：

1. コードを解析して構造を理解する。


2. 既存コードを変更する。


3. 新しいコードを生成する。


4. コメントやメタ情報を操作する。



公式ドキュメント（JavaParser公式サイト）も参考にしながら、具体的な目的に合わせてクラスやメソッドを選んで利用してください。

