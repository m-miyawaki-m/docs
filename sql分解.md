SQLファイルからテーブル一覧を作成するためには、以下の手順で実装を進めることができます。既存のコードを拡張して、SQLファイルを直接読み込み、テーブルやビューの情報を抽出するプロセスを構築します。


---

1. SQLファイルの読み込み

read_sql_files関数を新たに作成し、指定されたディレクトリ内の.sqlファイルをすべて収集します。

def read_sql_files(directory):
    """
    指定したディレクトリからSQLファイルを読み取る。
    """
    sql_files = {}
    for file_name in os.listdir(directory):
        if file_name.endswith(".sql"):
            with open(os.path.join(directory, file_name), 'r', encoding='utf-8') as f:
                sql_files[file_name] = f.read()
    return sql_files


---

2. SQL文の解析

sqlparseを利用して、以下の内容を解析します：

テーブル名

FROM句やJOIN句に記載されたテーブル名。


ビュー名

CREATE VIEWの構文を探してビュー名を取得。


カラム情報

SELECT句やINSERT句からカラム情報を抽出。


条件式

WHERE句やJOIN句の条件。



parse_sql関数を活用して、これらの情報を抽出します。


---

3. ビューの判定

CREATE VIEWを含むSQL文をビューとして扱います。この判定はsqlparseのトークンをチェックすることで実現できます。

実装例：

def parse_sql_file(sql_content):
    """
    SQL文を解析し、テーブル名・ビュー名を抽出する。
    """
    tables = {}
    views = {}
    sql_statements = sqlparse.split(sql_content)

    for statement in sql_statements:
        parsed = sqlparse.parse(statement)
        for stmt in parsed:
            tokens = sqlparse.sql.TokenList(stmt.tokens)

            # ビュー判定
            if "CREATE VIEW" in stmt.value.upper():
                view_name = stmt.get_name()
                views[view_name] = {
                    "columns": [],  # カラム情報を追加可能
                    "definition": stmt.value  # ビューの定義全体
                }
                continue

            # テーブル解析 (FROMやJOIN句)
            process_from_and_join(tokens, tables, {})

    return {"tables": tables, "views": views}


---

4. データの統合と出力

既存のsave_to_csvを利用して、以下の形式でデータを出力します。

CSV例：

ファイル名, タイプ, 名称, カラム名, 条件式
example.sql, table, USER_DATA, id, u.sex = m.sex_cd
example.sql, view, USER_VIEW, id,

保存ロジックの更新：

以下のようにviewsも含めてCSVに保存するように修正します。

def save_to_csv(data, output_path):
    """
    テーブル・ビュー情報をCSV形式で保存。
    """
    with open(output_path, 'w', encoding='utf-8', newline='') as f:
        writer = csv.writer(f)
        writer.writerow(["ファイル名", "タイプ", "名称", "カラム名", "条件式"])
        
        for file_name, details in data.items():
            for table_name, table_data in details.get("tables", {}).items():
                writer.writerow([file_name, "table", table_name, "", table_data.get("condition", "")])
            
            for view_name, view_data in details.get("views", {}).items():
                writer.writerow([file_name, "view", view_name, "", view_data.get("definition", "")])


---

5. メイン処理の統合

main.pyを拡張して、SQLファイルの解析プロセスを追加します。

def main():
    input_dir = "./sql_files"  # SQLファイルのディレクトリ
    csv_output_file = "./output/tables_views.csv"

    # SQLファイルを読み取る
    sql_files = read_sql_files(input_dir)
    
    # 全ファイルの解析結果を格納
    all_files_data = {}
    for file_name, content in sql_files.items():
        print(f"Parsing file: {file_name}")
        parsed_data = parse_sql_file(content)
        all_files_data[file_name] = parsed_data

    # 結果を保存
    save_to_csv(all_files_data, csv_output_file)
    print(f"CSVファイルに保存しました: {csv_output_file}")

if __name__ == "__main__":
    main()


---

6. 実行手順

1. SQLファイルを./sql_filesディレクトリに配置。


2. スクリプトを実行して、テーブルとビューの一覧をCSV形式で取得。




---

注意点

SQLの形式：解析には標準的なSQL文が必要です。独自構文や特殊なフォーマットがある場合は、解析ロジックを調整してください。

大規模なファイル：複数のSQL文が含まれる大きなファイルは、sqlparse.splitで分割できます。


このアプローチで、SQLファイルからテーブル一覧を作成するプロセスが効率化されます。追加の要望があれば教えてください！

了解しました！XMLの分解とDDL（SQLファイル）の分解を別々に実行し、DDLで得られるテーブル名の一覧を利用して、XML内のSQL文の解析を補助する流れを以下に整理します。


---

全体の流れ

1. DDL解析

DDL（SQLファイル）からすべてのテーブル名を抽出する。

このテーブル名一覧は、後の解析で利用される。



2. XML解析

XMLファイルから抽出したSQL文を字句解析する際に、DDLから得られたテーブル名を利用して解析を補助する。





---

手順

1. DDL解析

まず、SQLファイルからすべてのテーブル名を抽出します。

実装

def extract_table_names_from_ddl(sql_contents):
    """
    DDL(SQL)ファイルからテーブル名を抽出する。
    """
    table_names = set()
    create_table_pattern = re.compile(r"CREATE\s+TABLE\s+(\w+)", re.IGNORECASE)

    for sql_content in sql_contents.values():
        # CREATE TABLE文を探す
        matches = create_table_pattern.findall(sql_content)
        table_names.update(matches)

    return table_names

入力例

sql_files = {
    "schema1.sql": """
    CREATE TABLE USER_DATA (
        id INT PRIMARY KEY,
        name VARCHAR(100)
    );

    CREATE TABLE M_SEX (
        sex_cd CHAR(1),
        sex_value VARCHAR(10)
    );
    """,
    "schema2.sql": """
    CREATE TABLE PRODUCT (
        product_id INT,
        product_name VARCHAR(100)
    );
    """
}

出力例

{'USER_DATA', 'M_SEX', 'PRODUCT'}


---

2. XML解析

次に、XMLファイルのSQL文を解析します。この際、DDLで取得したテーブル名を利用して、FROM句やJOIN句に出現するテーブル名を確定します。

実装

def analyze_xml_with_tables(parsed_xml_data, table_names):
    """
    XML内のSQL文を解析し、DDLで得られたテーブル名を活用する。
    """
    analyzed_data = {}

    for namespace, tags in parsed_xml_data.items():
        analyzed_data[namespace] = {}
        for tag, tag_data in tags.items():
            analyzed_data[namespace][tag] = {}
            for tag_id, sql_content in tag_data.items():
                # SQL文解析
                parsed_tables = parse_sql_with_table_names(sql_content, table_names)
                analyzed_data[namespace][tag][tag_id] = parsed_tables

    return analyzed_data

def parse_sql_with_table_names(sql_content, table_names):
    """
    SQL文を解析し、DDLから得たテーブル名に基づいて解析する。
    """
    tables = {}
    sql = sqlparse.format(sql_content, keyword_case='upper')

    # FROM句・JOIN句からテーブル名を抽出
    from_join_pattern = re.compile(r"(FROM|JOIN)\s+(\w+)", re.IGNORECASE)
    matches = from_join_pattern.findall(sql)

    for _, table_name in matches:
        if table_name in table_names:  # テーブル名がDDLで定義済みか確認
            if table_name not in tables:
                tables[table_name] = {"columns": [], "parameters": [], "condition": ""}
    
    # その他の解析（条件式、カラムなど）
    process_where_clause(sql, tables)

    return tables


---

3. 解析結果の統合と出力

両方の解析結果を統合して出力します。

実装

def save_combined_results(xml_analysis, output_path):
    """
    XML解析結果をCSV形式で保存。
    """
    with open(output_path, 'w', encoding='utf-8', newline='') as f:
        writer = csv.writer(f)
        writer.writerow(["namespace", "tag", "tag ID", "table name", "columns", "parameters", "condition"])

        for namespace, tags in xml_analysis.items():
            for tag, tag_ids in tags.items():
                for tag_id, tables in tag_ids.items():
                    for table_name, table_data in tables.items():
                        writer.writerow([
                            namespace, tag, tag_id, table_name,
                            ", ".join(table_data.get("columns", [])),
                            ", ".join(table_data.get("parameters", [])),
                            table_data.get("condition", "")
                        ])


---

4. 統合メイン処理

全体を統合するメイン処理を作成します。

def main():
    # DDL解析
    ddl_dir = "./ddl_sql"
    sql_files = read_sql_files(ddl_dir)
    table_names = extract_table_names_from_ddl(sql_files)

    # XML解析
    xml_dir = "./mybatis_xml"
    xml_files = read_xml_files(xml_dir)
    parsed_xml_data = {}
    for file_name, file_path in xml_files.items():
        parsed_xml_data[file_name] = parse_mybatis_xml(file_path)

    # XML解析結果とテーブル名の結合解析
    analyzed_data = analyze_xml_with_tables(parsed_xml_data, table_names)

    # CSV保存
    output_csv = "./output/combined_analysis.csv"
    save_combined_results(analyzed_data, output_csv)
    print(f"解析結果をCSVに保存しました: {output_csv}")

if __name__ == "__main__":
    main()


---

出力結果


---

ポイント

1. DDLを先に解析
SQLファイルからテーブル一覧を作成しておき、XML解析時に活用します。


2. 解析の補助
DDLで得られたテーブル名を利用することで、SQL文中の曖昧なテーブル参照を解決できます。


3. ビューへの対応
DDLからビュー名も抽出しておけば、XMLの解析時に同様の補助が可能です。



これで、DDL解析とXML解析を分離した上で、統合的な解析が可能になります。必要に応じて調整してください！

以下に、SQLファイル（DDL解析）とXMLファイル（MyBatisマッパー）の分解・解析プロセスを元にした要件定義と基本設計を記載します。


---

要件定義

1. 目的

SQLファイル（DDL）の解析により、テーブルおよびビューの一覧を抽出する。

XMLファイル（MyBatisマッパー）内のSQL文を解析し、DDLで抽出したテーブル名を補助情報として活用して、正確な解析結果を得る。

解析結果を一元化し、namespace、tag ID、table nameを紐付けたCSV形式で出力する。



---

2. 対象

SQLファイル（DDL解析）

対象フォーマット：.sqlファイル

対象のDDL文：

CREATE TABLE

CREATE VIEW



XMLファイル（MyBatisマッパー）

対象フォーマット：.xmlファイル

対象タグ：

<select>, <insert>, <update>, <delete>, <sql>




---

3. 出力内容

CSV形式の出力例

CSV列の説明


---

4. 必須機能

1. SQL解析

SQLファイルからテーブルおよびビュー名を抽出。

テーブル名一覧を基に、後続処理（XML解析）を補助。



2. XML解析

XMLファイルからSQL文を解析。

SQL文内で使用されているテーブル名をDDLから得た一覧で検証。



3. 結果出力

テーブル名、カラム名、条件式、パラメータを紐付けてCSV形式で出力。





---

基本設計

1. 処理の全体フロー

1. SQLファイル解析（DDL解析）

指定されたディレクトリからSQLファイルを読み取り、テーブル名・ビュー名を抽出。

結果をリストとして保持。



2. XMLファイル解析

指定されたディレクトリからXMLファイルを読み取り、SQL文を抽出。

DDL解析で得たテーブル名一覧を基に、SQL解析を補助。



3. 解析結果の統合

XML解析結果をDDL解析結果と照合。

namespace、tag ID、table nameを紐付けて整理。



4. CSV形式で出力

統合結果を1行ごとにCSVファイルに保存。





---

2. 各処理の詳細

2.1 SQLファイル解析

対象操作

CREATE TABLE、CREATE VIEW文からテーブル名やビュー名を抽出。


使用技術

reモジュールで正規表現解析。


出力形式

テーブル名のリスト（例：{'USER_DATA', 'M_SEX', 'PRODUCT'}）。



2.2 XMLファイル解析

対象操作

XMLタグ（<select>など）を解析し、SQL文を抽出。

SQL文を解析してテーブル名や条件式を抽出。


使用技術

xml.etree.ElementTreeでXMLパース。

sqlparseを利用してSQL解析。


補助情報

DDL解析結果のテーブル名一覧を利用してテーブル名の特定精度を向上。



2.3 CSV出力

出力形式

各namespaceとtag IDに対し、使用されているテーブル名・カラム情報を出力。


使用技術

csvモジュール。




---

3. 制約事項と考慮点

1. SQL文の標準フォーマットへの依存

DDL解析はCREATE TABLEやCREATE VIEW文の標準的なフォーマットに依存。

フォーマットの違いに対応するため、正規表現を柔軟に設計。



2. 解析順序

DDL解析を先行して実施し、得られたテーブル名をXML解析で使用。



3. ビューへの対応

ビューをテーブルと区別し、適切に処理。



4. 拡張性

今後、DDLやXML解析対象の追加（例：DROP TABLEなど）にも対応可能な設計。





---

4. 使用技術


---

5. 実装例のディレクトリ構成

project/
│
├── ddl_sql/                     # DDLファイルを格納
├── mybatis_xml/                 # XMLファイルを格納
├── output/                      # CSVファイルの出力先
├── main.py                      # メインスクリプト
├── sql_parser.py                # SQL解析ロジック
├── xml_parser.py                # XML解析ロジック
└── ddl_parser.py                # DDL解析ロジック


---

この要件定義と基本設計をベースに、具体的な実装を進めることができます。拡張や修正が必要であれば、詳細をお伝えください！

