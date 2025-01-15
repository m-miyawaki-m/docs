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

