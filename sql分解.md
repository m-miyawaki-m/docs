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

